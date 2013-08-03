#! perl -w

use strict;
use warnings;

use Test::More;

use_ok("Unix::Statgrab");
Unix::Statgrab->import(":all");

my @constants_names = (
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

foreach my $constname (@constants_names)
{
    ok(eval "my \$a = $constname; 1", "Unix::Statgrab::$constname");

    my $c = Unix::Statgrab->can($constname);
    ok( $c, "Unix::Statgrab->can('$constname')" ) or skip("Can't get constant value of $constname");
    my $v = &{$c}();
    ok(defined($v), "value of $constname");
}

my %funcs = (
    get_host_info     => [qw/os_name os_release os_version platform hostname uptime/],
    get_cpu_stats     => [qw/user kernel idle iowait swap nice total systime/],
    get_disk_io_stats => [qw/disk_name read_bytes write_bytes systime/],
    get_fs_stats      => [qw/device_name fs_type mnt_point size
          used avail total_inodes used_inodes free_inodes
          avail_inodes io_size block_size total_blocks
          free_blocks used_blocks avail_blocks/
    ],
    get_load_stats       => [qw/min1 min5 min15/],
    get_mem_stats        => [qw/total free used cache/],
    get_swap_stats       => [qw/total free used/],
    get_network_io_stats => [qw/interface_name tx rx ipackets opackets
          ierrors oerrors collisions systime/
    ],
    get_network_iface_stats => [qw/interface_name speed factor duplex up/],
    get_page_stats          => [qw/pages_pagein pages_pageout systime/],
    get_process_stats       => [
        qw/proc_name proc_title pid parent_pid pgid
          uid euid gid egid proc_size proc_resident
          start_time time_spent cpu_percent nice state/
    ],
    get_user_stats => [qw/name_list/],
            );

my %methods = (
    get_cpu_stats => {
                       get_cpu_stats_diff => [qw/user kernel idle iowait swap nice total systime/],
                       get_cpu_percents   => [qw/user kernel idle iowait swap nice systime/],
                     },
    get_disk_io_stats =>
      { get_disk_io_stats_diff => [qw/num_disks disk_name read_bytes write_bytes systime/], },
    get_fs_stats => {
        get_fs_stats_diff => [
            qw/num_fs device_name fs_type mnt_point size
              used avail total_inodes used_inodes free_inodes
              avail_inodes io_size block_size total_blocks
              free_blocks used_blocks avail_blocks/
        ],
    },
    get_network_io_stats => {
        get_network_io_stats_diff => [
            qw/num_ifaces interface_name tx rx ipackets opackets
              ierrors oerrors collisions systime/
        ],
    },
    get_page_stats => { get_page_stats_diff => [qw/pages_pagein pages_pageout systime/], },
              );

# we only check that nothing segfaults
foreach my $func ( sort keys %funcs )
{
  SKIP:
    {
        my $sub = Unix::Statgrab->can($func);
        ok( $sub, "Unix::Statgrab->can('$func')" ) or skip("Can't invoke unknow stats-call $func");
        my $o = &{$sub}();
        ok( $o, "Unix::Statgrab::$func" ) or skip("Can't invoke methods on non-object");
        my $methods = $funcs{$func};
        foreach my $method (@$methods)
        {
            ok( $o->$method(), "Unix::Statgrab::sg_$func->$method" );
        }
    }
}

done_testing();
