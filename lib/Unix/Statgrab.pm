package Unix::Statgrab;

use 5.00503;
use strict;
use Carp;

require Exporter;
require DynaLoader;
use AutoLoader;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $AUTOLOAD);
@ISA = qw(Exporter
	DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Unix::Statgrab ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
%EXPORT_TAGS = ( 'all' => [ qw(
	get_error drop_privileges 
	get_host_info 
	get_cpu_stats get_cpu_stats_diff get_cpu_percents
	get_disk_io_stats get_disk_io_stats_diff
	get_fs_stats
	get_load_stats
	get_mem_stats
	get_swap_stats
	get_network_io_stats get_network_io_stats_diff
	get_network_iface_stats
	get_page_stats get_page_stats_diff
	get_user_stats
	SG_ERROR_ASPRINTF
	SG_ERROR_DEVSTAT_GETDEVS
	SG_ERROR_DEVSTAT_SELECTDEVS
	SG_ERROR_ENOENT
	SG_ERROR_GETIFADDRS
	SG_ERROR_GETMNTINFO
	SG_ERROR_GETPAGESIZE
	SG_ERROR_KSTAT_DATA_LOOKUP
	SG_ERROR_KSTAT_LOOKUP
	SG_ERROR_KSTAT_OPEN
	SG_ERROR_KSTAT_READ
	SG_ERROR_KVM_GETSWAPINFO
	SG_ERROR_KVM_OPENFILES
	SG_ERROR_MALLOC
	SG_ERROR_NONE
	SG_ERROR_OPEN
	SG_ERROR_OPENDIR
	SG_ERROR_PARSE
	SG_ERROR_SETEGID
	SG_ERROR_SETEUID
	SG_ERROR_SETMNTENT
	SG_ERROR_SOCKET
	SG_ERROR_SWAPCTL
	SG_ERROR_SYSCONF
	SG_ERROR_SYSCTL
	SG_ERROR_SYSCTLBYNAME
	SG_ERROR_SYSCTLNAMETOMIB
	SG_ERROR_UNAME
	SG_ERROR_UNSUPPORTED
	SG_ERROR_XSW_VER_MISMATCH
	SG_IFACE_DUPLEX_FULL
	SG_IFACE_DUPLEX_HALF
	SG_IFACE_DUPLEX_UNKNOWN
	SG_PROCESS_STATE_RUNNING
	SG_PROCESS_STATE_SLEEPING
	SG_PROCESS_STATE_STOPPED
	SG_PROCESS_STATE_UNKNOWN
	SG_PROCESS_STATE_ZOMBIE
) ] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

@EXPORT = qw(

	get_error drop_privileges 
	get_host_info 
	get_cpu_stats get_cpu_stats_diff get_cpu_percents
	get_disk_io_stats get_disk_io_stats_diff
	get_fs_stats
	get_load_stats
	get_mem_stats
	get_swap_stats
	get_network_io_stats get_network_io_stats_diff
	get_network_iface_stats
	get_page_stats get_page_stats_diff
	get_user_stats
	
	SG_ERROR_ASPRINTF
	SG_ERROR_DEVSTAT_GETDEVS
	SG_ERROR_DEVSTAT_SELECTDEVS
	SG_ERROR_ENOENT
	SG_ERROR_GETIFADDRS
	SG_ERROR_GETMNTINFO
	SG_ERROR_GETPAGESIZE
	SG_ERROR_KSTAT_DATA_LOOKUP
	SG_ERROR_KSTAT_LOOKUP
	SG_ERROR_KSTAT_OPEN
	SG_ERROR_KSTAT_READ
	SG_ERROR_KVM_GETSWAPINFO
	SG_ERROR_KVM_OPENFILES
	SG_ERROR_MALLOC
	SG_ERROR_NONE
	SG_ERROR_OPEN
	SG_ERROR_OPENDIR
	SG_ERROR_PARSE
	SG_ERROR_SETEGID
	SG_ERROR_SETEUID
	SG_ERROR_SETMNTENT
	SG_ERROR_SOCKET
	SG_ERROR_SWAPCTL
	SG_ERROR_SYSCONF
	SG_ERROR_SYSCTL
	SG_ERROR_SYSCTLBYNAME
	SG_ERROR_SYSCTLNAMETOMIB
	SG_ERROR_UNAME
	SG_ERROR_UNSUPPORTED
	SG_ERROR_XSW_VER_MISMATCH
	SG_IFACE_DUPLEX_FULL
	SG_IFACE_DUPLEX_HALF
	SG_IFACE_DUPLEX_UNKNOWN
	SG_PROCESS_STATE_RUNNING
	SG_PROCESS_STATE_SLEEPING
	SG_PROCESS_STATE_STOPPED
	SG_PROCESS_STATE_UNKNOWN
	SG_PROCESS_STATE_ZOMBIE
);

$VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Unix::Statgrab::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}

bootstrap Unix::Statgrab $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Unix::Statgrab - Perl extension for collecting information about the machine

=head1 SYNOPSIS

    use Unix::Statgrab;

    local $, = "\n";
    
    my $host = get_host_info or 
	die get_error;
	
    print $host->os_name, 
	  $host->os_release,
	  $host->os_version,
	  ...;

    my $disks = get_disk_io_stats or
	die get_error;
	
    for (0 .. $disks->num_disks - 1) {
	print $disks->disk_name($_),
	      $disks->read_bytes($_),
	      ...;
    }

=head1 DESCRIPTION

Unix::Statgrab is a wrapper for libstatgrab as available from L<http://www.i-scream.org/libstatgrab/>. It is a reasonably portable attempt to query interesting stats about your computer. It covers information on the operating system, CPU, memory usage, network interfaces, hard-disks etc. 

Each of the provided functions follow a simple rule: It never takes any argument and returns either an object (in case of success) or C<undef>. In case C<undef> was returned, check the return value of C<get_error>. Also see L<"ERROR HANDLING"> further below.

=head1 FUNCTIONS

=head2 get_host_info()

Returns generic information about this machine. The object it returns supports the following methods:

=over 4

=item * B<os_name>

=item * B<os_release>

=item * B<os_version>

=item * B<platform>

=item * B<hostname>

=item * B<uptime>

=back

=head2 get_cpu_stats

Returns information about this machine's usage of the CPU. The object it returns supports the following methods, all of which return the number of ticks the processor has spent in the respective states:

=over 4

=item * B<user>

=item * B<kernel>

=item * B<idle>

=item * B<iowait>

=item * B<swap>

=item * B<nice>

=item * B<total>

=item * B<systime>

The system time in seconds.

=back

=head2 get_cpu_stats_diff

Returns the differences in ticks for each of the states since last time C<get_cpu_stats> or C<get_cpu_stats_diff> was called.
If C<cpu_get_stats_diff> is called for the first time (and C<get_cpu_stats> wasn't called before) its return values will be the same as C<get_cpu_stats>.

Its return value supports the same methods as C<get_cpu_stats>. C<systime> then will be the seconds since the last call of this function.

=head2 get_cpu_percent

Calls C<get_cpu_stats_diff> under the hood but instead of returning ticks, it returns percentages. Its return value provides the same methods as C<get_cpu_stats> and C<get_cpu_stats_diff>.

=head2 get_disk_io_stats

Returns the disk IO per disk stored in the kernel which holds the amount of data transferred since bootup. Unlike most other methods presented in this manpage, the methods you can call on its return value take an additional optional parameter which specifies which disk you want information about. If you do not provide this parameter, 0 (= first disk) is assumed.

=over 4

=item * B<num_disks>

The number of disks that were found on this machine.

=item * B<disk_name($disk)>

=item * B<read_bytes($disk)>

=item * B<write_bytes($disk)>

=item * B<systime($disk)>

The system time in seconds over which C<read_bytes> and C<write_bytes> were transferred.

=back

=head2 get_disk_io_stats_diff

The same as C<get_disk_io_stats> except that it will report the difference to the last call of either C<get_disk_io_stats> or C<get_disk_io_stats_diff>. Provides the same methods as C<get_disk_io_stats>.

=head2 get_fs_stats

Returns statistics about the mounted filesystems, including free space and inode usage. The provided methods again take one optional argument which specifies which partition you want information about. If you do not provide this parameter, 0 (= first mounted filesystem) is assumed:

=over 4

=item * B<num_fs>

The number of mounted filesystems that were found on this machine.

=item * B<device_name($fs)>

=item * B<fs_type($fs)>

=item * B<mnt_point($fs)>

=item * B<size($fs)>

Size in bytes.

=item * B<used($fs)>

=item * B<avail($fs)>

=item * B<total_inodes($fs)>

=item * B<used_inodes($fs)>

=item * B<free_inodes($fs)>

=back

=head2 get_load_stats()

Returns the load average over various span of times. The following methods are provided:

=over 4

=item * B<min1>

Load average over 1 minute.

=item * B<min5>

=item * B<min15>

=back

=head2 get_mem_stats()

Returns statistics about memory usage. The following methods exist:

=over 4

=item * B<total>

Total memory in bytes.

=item * B<free>

=item * B<used>

=item * B<cache>

Amount of cache used in bytes.

=back

=head2 get_swap_stats()

Returns statistics about swap usage. The following methods exist:

=over 4

=item * B<total>

Total swap memory in bytes.

=item * B<used>

=item * B<free>

=back

=head2 get_network_io_stats()

Returns statistics about the network traffic per network interface as stored in the kernel. Again, the provided methods support one optional parameter specifiying which network interface to query. If the parameter is missing, 0 (= first interface) is assumed.

=over 4

=item * B<num_ifaces>

The number of network interfaces found on your machine.

=item * B<interface_name($if)>

=item * B<tx($if)>

The number of bytes transmitted.

=item * B<rx($if)>

The number of bytes received.

=item * B<ipackets($if)>

The number of packets received.

=item * B<opackets($if)>

The number of bytes transmitted.

=item * B<ierrors($if)>

The number of receive errors

=item * B<oerrors($if)>

The number of transmit errors

=item * B<collisions($if)>

=item * B<systime>

The time period over which C<tx> and C<rx> were transferred.

=back

=head2 get_network_io_stats_diff()

The same as C<get_network_io_stats> except that it will report on the difference to the last time C<get_network_io_stats> or C<get_network_io_stats_diff> was called. It supports the same methods as C<get_network_io_stats>.

=head2 get_network_iface_stats()

Returns statistics about each of the found network interfaces in your computer. The provided methods take one optional argument being the interface to query. If this parameter is missing, 0 (= first interface) is assumed.

=over 4

=item * B<num_ifaces>

The number of interfaces found.

=item * B<interface_name($if)>

=item * B<speed($if)>

The speed of the interface, in megabits/sec

=item * B<dup($if)>

One of C<SG_IFACE_DUPLEX_FULL>, C<SG_IFACE_DUPLEX_HALF> and C<SG_IFACE_DUPLEX_UNKNOWN>. Unknown could mean that duplex hasn't been negotiated yet.

=item * B<up($if)>

Whether the interface is up.

=back

=head2 get_page_stats()

Returns the number of pages the system has paged in  and  out since bootup. It supports the following methods:

=over 4

=item * B<pages_pagein>

=item * B<pages_pageout>

=item * B<systime>

The time period over which pages_pagein and pages_pageout were transferred, in seconds.

=back

=head2 get_page_stats_diff()

The same as C<get_page_stats> except that it will report the difference to the last time C<get_page_stats> or C<get_page_stats_diff> was called. Supports the same methods as C<get_page_stats>.

=head2 get_user_stats()

Returns information about the currently logged in users. It supports the following methods:

=over 4

=item * B<num_entries>

The number of currently logged in users.

=item * B<name_list>

A list of the users currently logged in.

=back

=head1 ERROR HANDLING

One function C<get_error> exists that will return the error encountered during the last operation, if any. Its return value is dual-typed. In string context, it returns a text representation of the error. In numeric context it returns one of the following values:

    SG_ERROR_ASPRINTF
    SG_ERROR_DEVSTAT_GETDEVS
    SG_ERROR_DEVSTAT_SELECTDEVS
    SG_ERROR_ENOENT
    SG_ERROR_GETIFADDRS
    SG_ERROR_GETMNTINFO
    SG_ERROR_GETPAGESIZE
    SG_ERROR_KSTAT_DATA_LOOKUP
    SG_ERROR_KSTAT_LOOKUP
    SG_ERROR_KSTAT_OPEN
    SG_ERROR_KSTAT_READ
    SG_ERROR_KVM_GETSWAPINFO
    SG_ERROR_KVM_OPENFILES
    SG_ERROR_MALLOC
    SG_ERROR_NONE
    SG_ERROR_OPEN
    SG_ERROR_OPENDIR
    SG_ERROR_PARSE
    SG_ERROR_SETEGID
    SG_ERROR_SETEUID
    SG_ERROR_SETMNTENT
    SG_ERROR_SOCKET
    SG_ERROR_SWAPCTL
    SG_ERROR_SYSCONF
    SG_ERROR_SYSCTL
    SG_ERROR_SYSCTLBYNAME
    SG_ERROR_SYSCTLNAMETOMIB
    SG_ERROR_UNAME
    SG_ERROR_UNSUPPORTED
    SG_ERROR_XSW_VER_MISMATCH

Based on the above, you have finer control over the error handling:

    my $disks = get_disk_io_stats;
    
    if (! $disks) {
	if (get_error == SG_ERROR_PARSE) {
	    ...
	} else if (get_error == SG_ERROR_OPEN) {
	    ...
	} 
	etc. 
    }

=head1 EXPORT

B<All> by default. This means all of the above functions plus the following constants:

  SG_ERROR_ASPRINTF
  SG_ERROR_DEVSTAT_GETDEVS
  SG_ERROR_DEVSTAT_SELECTDEVS
  SG_ERROR_ENOENT
  SG_ERROR_GETIFADDRS
  SG_ERROR_GETMNTINFO
  SG_ERROR_GETPAGESIZE
  SG_ERROR_KSTAT_DATA_LOOKUP
  SG_ERROR_KSTAT_LOOKUP
  SG_ERROR_KSTAT_OPEN
  SG_ERROR_KSTAT_READ
  SG_ERROR_KVM_GETSWAPINFO
  SG_ERROR_KVM_OPENFILES
  SG_ERROR_MALLOC
  SG_ERROR_NONE
  SG_ERROR_OPEN
  SG_ERROR_OPENDIR
  SG_ERROR_PARSE
  SG_ERROR_SETEGID
  SG_ERROR_SETEUID
  SG_ERROR_SETMNTENT
  SG_ERROR_SOCKET
  SG_ERROR_SWAPCTL
  SG_ERROR_SYSCONF
  SG_ERROR_SYSCTL
  SG_ERROR_SYSCTLBYNAME
  SG_ERROR_SYSCTLNAMETOMIB
  SG_ERROR_UNAME
  SG_ERROR_UNSUPPORTED
  SG_ERROR_XSW_VER_MISMATCH
  SG_IFACE_DUPLEX_FULL
  SG_IFACE_DUPLEX_HALF
  SG_IFACE_DUPLEX_UNKNOWN
  SG_PROCESS_STATE_RUNNING
  SG_PROCESS_STATE_SLEEPING
  SG_PROCESS_STATE_STOPPED
  SG_PROCESS_STATE_UNKNOWN
  SG_PROCESS_STATE_ZOMBIE

If you don't want that, use the module thusly:

    use Unix::Statgrab ();

or provide a list of those symbols you want:

    use Unix::Statgrab qw/get_network_iface_stats 
                          SG_IFACE_DUPLEX_FULL
			  SG_IFACE_DUPLEX_HALF
			  SG_IFACE_DUPLEX_UNKNOWN/;

=head1 SEE ALSO

The excellent and very complete manpage of statgrab(3). You can get additional information for each of the above
functions by prefixing the function name with "sg_" and feed it to C<man>:

    man sg_get_network_iface_stats

libstatgrab's home is at L<http://www.i-scream.org/libstatgrab/>

=head1 AUTHOR

Tassilo von Parseval, E<lt>tassilo.von.parseval@rwth-aachen.deE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by Tassilo von Parseval

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation; either version 2.1 of the License, or (at your option) any
later version.

=cut
