package Statgrab::Builder;

use warnings;
use strict;

use parent 'Module::Build';

use Config;
use Carp;

use Config::AutoConf::SG;

use File::Copy;
use File::Spec;

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
}

sub ACTION_write_constants
{
    my $self = shift;

    if ( eval { require ExtUtils::Constant; 1 } )
    {
        # If you edit these definitions to change the constants used by this module,
        # you will need to use the generated const-c.inc and const-xs.inc
        # files to replace their "fallback" counterparts before distributing your
        # changes.
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
              SG_ERROR_MUTEX_UNLOCK)
        );

        ExtUtils::Constant::WriteConstants(
                                            NAME         => 'Unix::Statgrab',
                                            NAMES        => \@names,
                                            DEFAULT_TYPE => 'IV',
                                            C_FILE       => 'const-c.inc',
                                            XS_FILE      => 'const-xs.inc',
                                          );

    }
    else
    {
        foreach my $file ( 'const-c.inc', 'const-xs.inc' )
        {
            my $fallback = File::Spec->catfile( 'fallback', $file );
            copy( $fallback, $file ) or die "Can't copy $fallback to $file: $!";
        }
    }

    return;
}

sub ACTION_code
{
    my $self = shift;

    # for my $path (catdir("blib","bindoc"), catdir("blib","bin")) {
    #     mkpath $path unless -d $path;
    # }

    $self->dispatch("configure");
    $self->dispatch("write_constants");
    $self->dispatch("compile_xscode");
}

sub ACTION_compile_xscode
{
    my $self = shift;

}

1;
