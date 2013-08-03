eval "use Test::Pod::Coverage 0.08";
if ($@) {
    print "1..0 # Skip Test::Pod::Coverage (at least 0.08) not installed\n";
    exit;
} 

my $ARGS = {
    also_private    => [qr/^constant$/],
    trustme	    => [qr/^get_error$/, qr/^sort_procs_by_.*$/],
};

all_pod_coverage_ok( $ARGS );
