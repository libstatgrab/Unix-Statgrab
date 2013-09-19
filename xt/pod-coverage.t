#! perl

use strict;
use warnings;

use Test::More;
use Test::Pod::Coverage;
use Pod::Coverage;

my $ARGS = {
    also_private    => [qr/^constant$/],
    trustme        => [qr/^get_error$/, qr/^sort_procs_by_.*$/],
};
all_pod_coverage_ok( $ARGS );
