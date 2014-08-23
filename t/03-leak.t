#! perl -w

use strict;
use warnings;
use Test::More;

use Unix::Statgrab;

my $have_test_leak_trace = eval { require Test::LeakTrace; 1 };
$have_test_leak_trace or plan skip_all => "Need Test::LeakTrace";

Test::LeakTrace->import;

my %funcs = (
    get_host_info => [
        qw/os_name os_release os_version platform hostname
          bitwidth host_state ncpus maxcpus uptime systime/
    ],
    get_cpu_stats => [
        qw/user kernel idle iowait swap nice total
          context_switches voluntary_context_switches
          involuntary_context_switches syscalls
          interrupts soft_interrupts systime/
    ],
    get_disk_io_stats => [qw/disk_name read_bytes write_bytes systime/],
    get_fs_stats      => [
        qw/device_name fs_type mnt_point device_type size used free avail
          total_inodes used_inodes free_inodes avail_inodes io_size
          block_size total_blocks free_blocks used_blocks avail_blocks
          systime/
    ],
    get_load_stats          => [qw/min1 min5 min15 systime/],
    get_mem_stats           => [qw/total free used cache systime/],
    get_swap_stats          => [qw/total free used systime/],
    get_network_io_stats    => [qw/interface_name tx rx ipackets opackets ierrors oerrors collisions systime/],
    get_network_iface_stats => [qw/interface_name speed factor duplex up systime/],
    get_page_stats          => [qw/pages_pagein pages_pageout systime/],
    get_process_stats       => [
        qw/process_name proctitle pid parent pgid sessid context_switches
          voluntary_context_switches involuntary_context_switches proc_size
          proc_resident start_time time_spent cpu_percent nice state systime/
    ],
    get_user_stats => [qw/login_name record_id device hostname pid login_time systime/],
);

my %errs = (
    get_error => [qw/error error_name error_value error_arg strperror/],
);

my %methods = (
    get_cpu_stats => {
        get_cpu_stats_diff => $funcs{get_cpu_stats},
        get_cpu_percents   => [qw/user kernel idle iowait swap nice time_taken/],
    },
    get_disk_io_stats => {
        get_disk_io_stats_diff => $funcs{get_disk_io_stats},
    },
    get_fs_stats => {
        get_fs_stats_diff => $funcs{get_fs_stats},
    },
    get_network_io_stats => {
        get_network_io_stats_diff => $funcs{get_network_io_stats},
    },
    get_page_stats => {
        get_page_stats_diff => $funcs{get_page_stats},
    },
);

foreach my $func ( sort keys %funcs, keys %errs )
{
    Test::LeakTrace::no_leaks_ok(
        sub {
            eval {
		my $sub = Unix::Statgrab->can($func);
                my $current = $sub->()
                  or croak( get_error()->strperror() );

                my @stats = $current->as_list();
            };
        },
        "$func doesn't leak"
    );
}

done_testing;
