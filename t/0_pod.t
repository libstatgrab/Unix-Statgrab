eval "use Test::Pod 1.18";
if ($@) {
    print "1..0 # Skip Test::Pod (at least 1.18) not installed\n";
    exit;
} 
 
my @PODS = qw#../blib#;

all_pod_files_ok( all_pod_files(@PODS) );
