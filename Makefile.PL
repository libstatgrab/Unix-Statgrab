use 5.00503;
use ExtUtils::MakeMaker;
use Config;

sub have_libstatgrab {
    my $CC = $Config{cc};
    my %args = map { split /\s*=\s*/ } @ARGV;
    my $LIBS = $args{ LIBS } || "-lstatgrab";
    my $INC = $args{ INC };
    return 1 if system("$CC check.c $INC $LIBS 2>/dev/null") == 0;
    return 0;
}

if (! have_libstatgrab()) {
    die <<EOD;
*******************************************
Couldn't find libstatgrab which is required 
for this module.

To obtain it, go to
    http://www.i-scream.org/libstatgrab/
*******************************************
EOD
}

WriteMakefile(
    NAME              => 'Unix::Statgrab',
    VERSION_FROM      => 'lib/Unix/Statgrab.pm', # finds $VERSION
    PREREQ_PM         => {}, 
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Unix/Statgrab.pm', # retrieve abstract from module
       AUTHOR         => 'Tassilo von Parseval <tassilo.von.parseval@rwth-aachen.de>') : ()),
    LIBS              => ['-lstatgrab'], 
    DEFINE            => '', 
    INC               => '-I.',
    clean	      => { FILES => "a.out" },
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (qw(SG_ERROR_ASPRINTF SG_ERROR_DEVSTAT_GETDEVS
		 SG_ERROR_DEVSTAT_SELECTDEVS SG_ERROR_ENOENT
		 SG_ERROR_GETIFADDRS SG_ERROR_GETMNTINFO SG_ERROR_GETPAGESIZE
		 SG_ERROR_KSTAT_DATA_LOOKUP SG_ERROR_KSTAT_LOOKUP
		 SG_ERROR_KSTAT_OPEN SG_ERROR_KSTAT_READ
		 SG_ERROR_KVM_GETSWAPINFO SG_ERROR_KVM_OPENFILES
		 SG_ERROR_MALLOC SG_ERROR_NONE SG_ERROR_OPEN SG_ERROR_OPENDIR
		 SG_ERROR_PARSE SG_ERROR_SETEGID SG_ERROR_SETEUID
		 SG_ERROR_SETMNTENT SG_ERROR_SOCKET SG_ERROR_SWAPCTL
		 SG_ERROR_SYSCONF SG_ERROR_SYSCTL SG_ERROR_SYSCTLBYNAME
		 SG_ERROR_SYSCTLNAMETOMIB SG_ERROR_UNAME SG_ERROR_UNSUPPORTED
		 SG_ERROR_XSW_VER_MISMATCH SG_IFACE_DUPLEX_FULL
		 SG_IFACE_DUPLEX_HALF SG_IFACE_DUPLEX_UNKNOWN
		 SG_PROCESS_STATE_RUNNING SG_PROCESS_STATE_SLEEPING
		 SG_PROCESS_STATE_STOPPED SG_PROCESS_STATE_UNKNOWN
		 SG_PROCESS_STATE_ZOMBIE));
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'Unix::Statgrab',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
