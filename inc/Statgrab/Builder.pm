package Statgrab::Builder;

use warnings;
use strict;

use parent 'Module::Build';

use Config;
use Carp;

use Config::AutoConf::SG ();

use Cwd qw(getcwd);
use File::Spec         ();

use AutoSplit ();
use ExtUtils::Constant ();
use ExtUtils::Mkbootstrap ();
use ExtUtils::ParseXS ();

sub ACTION_configure
{
    my $autoconf = Config::AutoConf::SG->new();
    $autoconf->check_libstatgrab() or die <<EOD;
*******************************************
Couldn't find libstatgrab (at least 0.90)
which is required for this module.

To obtain it, go to
    http://www.i-scream.org/libstatgrab/
*******************************************
EOD
    # $autoconf->write_config_h();
    use Data::Dumper;
    print STDERR Dumper($autoconf);
    return;
}

sub ACTION_write_constants
{
    my $self = shift;

    my @names = (
        qw(SG_ERROR_NONE SG_ERROR_INVALID_ARGUMENT SG_ERROR_ASPRINTF
          SG_ERROR_SPRINTF SG_ERROR_DEVICES SG_ERROR_DEVSTAT_GETDEVS
          SG_ERROR_DEVSTAT_SELECTDEVS SG_ERROR_DISKINFO SG_ERROR_ENOENT
          SG_ERROR_GETIFADDRS SG_ERROR_GETMNTINFO SG_ERROR_GETPAGESIZE
          SG_ERROR_HOST SG_ERROR_KSTAT_DATA_LOOKUP SG_ERROR_KSTAT_LOOKUP
          SG_ERROR_KSTAT_OPEN SG_ERROR_KSTAT_READ SG_ERROR_KVM_GETSWAPINFO
          SG_ERROR_KVM_OPENFILES SG_ERROR_MALLOC SG_ERROR_MEMSTATUS
          SG_ERROR_OPEN SG_ERROR_OPENDIR SG_ERROR_READDIR SG_ERROR_PARSE
          SG_ERROR_PDHADD SG_ERROR_PDHCOLLECT SG_ERROR_PDHOPEN SG_ERROR_PDHREAD
          SG_ERROR_PERMISSION SG_ERROR_PSTAT SG_ERROR_SETEGID SG_ERROR_SETEUID
          SG_ERROR_SETMNTENT SG_ERROR_SOCKET SG_ERROR_SWAPCTL SG_ERROR_SYSCONF
          SG_ERROR_SYSCTL SG_ERROR_SYSCTLBYNAME SG_ERROR_SYSCTLNAMETOMIB
          SG_ERROR_SYSINFO SG_ERROR_MACHCALL SG_ERROR_IOKIT SG_ERROR_UNAME
          SG_ERROR_UNSUPPORTED SG_ERROR_XSW_VER_MISMATCH SG_ERROR_GETMSG
          SG_ERROR_PUTMSG SG_ERROR_INITIALISATION SG_ERROR_MUTEX_LOCK
          SG_ERROR_MUTEX_UNLOCK),
        qw(sg_unknown_configuration sg_physical_host sg_virtual_machine
          sg_paravirtual_machine sg_hardware_virtualized),
        qw(sg_fs_unknown sg_fs_regular sg_fs_special sg_fs_loopback
          sg_fs_remote sg_fs_local sg_fs_alltypes),
        qw(SG_IFACE_DUPLEX_FULL SG_IFACE_DUPLEX_HALF SG_IFACE_DUPLEX_UNKNOWN),
        qw(SG_IFACE_DOWN SG_IFACE_UP),
        qw(SG_PROCESS_STATE_RUNNING SG_PROCESS_STATE_SLEEPING
          SG_PROCESS_STATE_STOPPED SG_PROCESS_STATE_ZOMBIE
          SG_PROCESS_STATE_UNKNOWN),
                );

    my $xsfile = "lib/Unix/Statgrab.xs";
    my $spec = $self->_infer_xs_spec($xsfile);
    ExtUtils::Constant::WriteConstants(
                                        NAME         => 'Unix::Statgrab',
                                        NAMES        => \@names,
                                        DEFAULT_TYPE => 'UV',
                                        C_FILE       => File::Spec->catfile(getcwd(), 'const-c.inc'),
                                        XS_FILE      => File::Spec->catfile(getcwd(), 'const-xs.inc'),
                                      );
    $self->add_to_cleanup(File::Spec->catfile(getcwd(), 'const-c.inc')); ## FIXME
    $self->add_to_cleanup(File::Spec->catfile(getcwd(), 'const-xs.inc')); ## FIXME

    return;
}

sub ACTION_autosplit
{
    my $self = shift;
    AutoSplit::autosplit("blib/lib/Unix/Statgrab.pm", "blib/arch/auto", 0, 1, 1);
}


sub ACTION_code
{
    my $self = shift;

    # for my $path (catdir("blib","bindoc"), catdir("blib","bin")) {
    #     mkpath $path unless -d $path;
    # }

    $self->dispatch("configure");
    $self->dispatch("write_constants");

    $self->SUPER::ACTION_code();

    $self->dispatch("compile_xs");
    $self->dispatch("autosplit");
}

sub ACTION_compile_xs
{
    my $self = shift;
    my $cbuilder = $self->cbuilder;
    my $xsfile = "lib/Unix/Statgrab.xs";
    my $spec = $self->_infer_xs_spec($xsfile);

    File::Path::mkpath($spec->{archdir}, 0, oct(777)) unless -d $spec->{archdir};

    $self->log_info( "Compiling Statgrab.xs\n");
    if (!$self->up_to_date($xsfile, $spec->{c_file})) {
        ExtUtils::ParseXS::process_file( filename   => $xsfile,
                                         prototypes => 0,
					 # typemap => File::Spec->catfile(getcwd(), "typemap"),
                                         output     => $spec->{c_file});
    }
    $self->add_to_cleanup($spec->{c_file}); ## FIXME
    $self->add_to_cleanup($spec->{obj_file}); ## FIXME

    my $extra_compiler_flags = $self->notes('CFLAGS');
    $Config{ccflags} =~ /(-arch \S+(?: -arch \S+)*)/ and $extra_compiler_flags .= " $1";

    if (!$self->up_to_date($spec->{c_file}, $spec->{obj_file})) {
        $cbuilder->compile( source               => $spec->{c_file},
                            include_dirs         => [ "." ],
                            extra_compiler_flags => $extra_compiler_flags,
                            object_file          => $spec->{obj_file});
    }

    # Create .bs bootstrap file, needed by Dynaloader.
    if ( !$self->up_to_date( $spec->{obj_file}, $spec->{bs_file} ) ) {
        ExtUtils::Mkbootstrap::Mkbootstrap($spec->{bs_file});
        if ( !-f $spec->{bs_file} ) {
            # Create file in case Mkbootstrap didn't do anything.
            open( my $fh, '>', $spec->{bs_file} ) or confess "Can't open $spec->{bs_file}: $!";
        }
        utime( (time) x 2, $spec->{bs_file} );    # touch
    }

    my $extra_linker_flags = $cbuilder->{config}{ldflags}; # XXX
    my $objects = [ $spec->{obj_file} ];
    # .o => .(a|bundle)
    if ( !$self->up_to_date( [ @$objects ], $spec->{lib_file} ) ) {
        $cbuilder->link(
                        module_name => 'Unix::Statgrab',
                        extra_linker_flags => join(" ", $extra_linker_flags, "-lstatgrab"),
                        objects     => $objects,
			lib_file    => $spec->{lib_file},
                       );
    }
}

1;
