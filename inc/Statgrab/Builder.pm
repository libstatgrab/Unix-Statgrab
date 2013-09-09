package Statgrab::Builder;

use warnings;
use strict;

use parent 'Module::Build';

use Config;
use Carp;

use Config::AutoConf::SG ();

use Cwd qw(getcwd);
use File::Spec ();

use AutoSplit             ();
use ExtUtils::Constant    ();
use ExtUtils::Mkbootstrap ();
use ExtUtils::ParseXS     ();

sub ACTION_configure
{
    my $self = shift;

    my $autoconf = Config::AutoConf::SG->new();
    $autoconf->check_libstatgrab() or die <<EOD;
*******************************************
Couldn't find libstatgrab (at least 0.90)
which is required for this module.

To obtain it, go to
    http://www.i-scream.org/libstatgrab/
*******************************************
EOD

    $autoconf->check_sizeof_IVUV_fit_stat();

    my $xsfile   = "lib/Unix/Statgrab.xs";
    my $spec     = $self->_infer_xs_spec($xsfile);
    my $config_h = File::Spec->catfile( $spec->{src_dir}, 'config.h' );
    $autoconf->write_config_h($config_h);

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

    my $xsfile  = "lib/Unix/Statgrab.xs";
    my $spec    = $self->_infer_xs_spec($xsfile);
    my $c_const = File::Spec->catfile( $spec->{src_dir}, 'const-c.inc' );
    #my $c_const = File::Spec->catfile(getcwd(), 'const-c.inc');
    my $xs_const = File::Spec->catfile( $spec->{src_dir}, 'const-xs.inc' );
    #my $xs_const = File::Spec->catfile(getcwd(), 'const-xs.inc');

    # workaround #ifdef around each constant (stupid that it's not documented)
    open( my $c_fh, ">", $c_const ) or die("Cannot open $c_const for writing: $!");
    foreach my $name (@names)
    {
        print $c_fh "#define $name $name\n";
    }
    ExtUtils::Constant::WriteConstants(
                                        NAME         => 'Unix::Statgrab',
                                        NAMES        => \@names,
                                        DEFAULT_TYPE => 'UV',
                                        C_FH         => $c_fh,
                                        XS_FILE      => $xs_const,
                                      );
    close($c_fh);
    $self->add_to_cleanup($c_const);     ## FIXME
    $self->add_to_cleanup($xs_const);    ## FIXME

    return;
}

sub ACTION_autosplit
{
    my $self = shift;
    AutoSplit::autosplit( "blib/lib/Unix/Statgrab.pm", "blib/arch/auto", 0, 1, 1 );
}

sub ACTION_code
{
    my $self     = shift;
    my $cbuilder = $self->cbuilder;

    $self->{properties}->{extra_linker_flags} ||= [];
    unshift(
             @{ $self->{properties}->{extra_linker_flags} },
             split( " ", $cbuilder->{config}{ldflags} )
           );    # XXX currently silently ignored by EU::CB
    push( @{ $self->{properties}->{extra_linker_flags} }, '-lstatgrab' )
      ;          # XXX fetch it from $autoconf ...

    # for my $path (catdir("blib","bindoc"), catdir("blib","bin")) {
    #     mkpath $path unless -d $path;
    # }

    #$self->dispatch("configure");
    $self->dispatch("write_constants");

    $self->SUPER::ACTION_code();

    $self->dispatch("autosplit");
}

1;
