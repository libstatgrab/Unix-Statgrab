#! perl

use strict;
use warnings;

use Test::More;
BEGIN {
  $] >= 5.008 or plan skip_all => "Test::Pod::Coverage requires perl 5.8";
}
use Test::Pod::Coverage;
use Pod::Coverage;

my $ARGS = {
    also_private    => [qr/^constant$/],
    trustme        => [qr/^get_error$/, qr/^sort_procs_by_.*$/],
};
all_pod_coverage_ok( $ARGS );
