use 5.006;

use Test::More;
eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD Coverage" if $@;

my $ARGS = {
    also_private    => [qr/^constant$/],
    trustme        => [qr/^get_error$/, qr/^sort_procs_by_.*$/],
};
all_pod_coverage_ok( $ARGS );
