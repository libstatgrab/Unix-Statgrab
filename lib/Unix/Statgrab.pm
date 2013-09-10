package Unix::Statgrab;

use 5.008003;
use strict;
use warnings;

use Carp;

require Exporter;
require DynaLoader;

use AutoLoader;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $AUTOLOAD);
@ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Unix::Statgrab ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.

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

%EXPORT_TAGS = ( 'all' => [ qw(
	get_error drop_privileges 
	get_host_info 
	get_cpu_stats
	get_disk_io_stats
	get_fs_stats
	get_load_stats
	get_mem_stats
	get_swap_stats
	get_network_io_stats
	get_network_iface_stats
	get_page_stats
	get_user_stats
	get_process_stats),
	@constants_names
    ] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

@EXPORT = (qw(
	get_error drop_privileges 
	get_host_info 
	get_cpu_stats
	get_disk_io_stats
	get_fs_stats
	get_load_stats
	get_mem_stats
	get_swap_stats
	get_network_io_stats
	get_network_iface_stats
	get_page_stats
	get_user_stats
	get_process_stats),
	@constants_names
    );

$VERSION = '0.101';

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
	*$AUTOLOAD = sub { $val };
    }
    goto &$AUTOLOAD;
}

bootstrap Unix::Statgrab $VERSION;

my $to_hash_array = sub {
    my ($self, @keys) = @_;
    my $entries = $self->entries;
    my @ary_hash;
    foreach my $entry (0 .. $entries - 1)
    {
	my %kv = map { $_ => $self->$_($entry); } @keys;
	push(@ary_hash, \%kv);
    }
    return @ary_hash;
};

my @sg_cpu_stats_attrs = (qw(user kernel idle iowait swap nice total),
	qw(context_switches voluntary_context_switches involuntary_context_switches syscalls),
	qw(interrupts soft_interrupts systime));

sub Unix::Statgrab::sg_cpu_stats::as_list { return $to_hash_array->( $_[0], @sg_cpu_stats_attrs ); }

my @sg_cpu_percent_attrs = (qw(user kernel idle iowait swap nice time_taken));

sub Unix::Statgrab::sg_cpu_percents::as_list { return $to_hash_array->( $_[0], @sg_cpu_percent_attrs ); }

my @sg_host_info_attrs = (qw(os_name os_release os_version platform hostname),
qw(bitwidth host_state ncpus maxcpus uptime systime));

sub Unix::Statgrab::sg_host_info::as_list { return $to_hash_array->( $_[0], @sg_host_info_attrs ); }

my @sg_disk_io_stats_attrs = (qw(disk_name read_bytes write_bytes systime));

sub Unix::Statgrab::sg_disk_io_stats::as_list { return $to_hash_array->( $_[0], @sg_disk_io_stats_attrs ); }

my @sg_fs_stats_attrs = (qw(device_name fs_type mnt_point device_type),
	qw(size used free avail total_inodes used_inodes free_inodes avail_inodes),
	qw(io_size block_size total_blocks free_blocks used_blocks avail_blocks systime));

sub Unix::Statgrab::sg_fs_stats::as_list { return $to_hash_array->( $_[0], @sg_fs_stats_attrs ); }

my @sg_load_stats_attrs = (qw(min1 min5 min15 systime));

sub Unix::Statgrab::sg_load_stats::as_list { return $to_hash_array->( $_[0], @sg_load_stats_attrs ); }

my @sg_mem_stats_attrs = (qw(total free used cache systime));

sub Unix::Statgrab::sg_mem_stats::as_list { return $to_hash_array->( $_[0], @sg_mem_stats_attrs ); }

my @sg_swap_stats_attrs = (qw(total free used systime));

sub Unix::Statgrab::sg_swap_stats::as_list { return $to_hash_array->( $_[0], @sg_swap_stats_attrs ); }

my @sg_network_io_stats_attrs = (qw(interface_name tx rx ipackets opackets),
	qw(ierrors oerrors collisions systime));

sub Unix::Statgrab::sg_network_io_stats::as_list { return $to_hash_array->( $_[0], @sg_network_io_stats_attrs ); }

my @sg_network_iface_stats_attrs = (qw(interface_name speed factor duplex up systime));

sub Unix::Statgrab::sg_network_iface_stats::as_list { return $to_hash_array->( $_[0], @sg_network_iface_stats_attrs ); }

my @sg_page_stats_attrs = (qw(pages_pagein pages_pageout systime));

sub Unix::Statgrab::sg_page_stats::as_list { return $to_hash_array->( $_[0], @sg_page_stats_attrs ); }

my @sg_user_stats_attrs = (qw(login_name record_id device hostname pid login_time systime));

sub Unix::Statgrab::sg_user_stats::as_list { return $to_hash_array->( $_[0], @sg_user_stats_attrs ); }

my @sg_process_stats_attrs = (qw(process_name proctitle pid parent pgid sessid uid euid gid egid),
	qw(context_switches voluntary_context_switches involuntary_context_switches),
	qw(proc_size proc_resident start_time time_spent cpu_percent nice state systime));

sub Unix::Statgrab::sg_process_stats::as_list { return $to_hash_array->( $_[0], @sg_process_stats_attrs ); }

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__


=head1 NAME

Unix::Statgrab - Perl extension for collecting information about the machine

=head1 SYNOPSIS

    use Unix::Statgrab;

    my $host_stats = get_host_info();
    print $host_stats->hostname . " is a " . $host_stats->bitwidth . " " . $host_stats->os_name . "\n";

    my $filesystems = get_fs_stats();
    my @mount_points = map { $filesystems->mnt_point($_) } (0 .. $filesystems->entries() - 1);
    print $host_stats->hostname . " has " . join( ", ", @mount_points ) . " mounted\n";

    my $proc_list = get_process_stats();
    my @proc_by_type;
    foreach my $proc_entry (0 .. $proc_list->entries() - 1) {
	$proc_by_type[$proc_list->state($proc_entry)]++;
    }
    my $total_procs = 0;
    $total_procs += $_ for grep { defined $_ } @proc_by_type;
    foreach my $state (qw(SG_PROCESS_STATE_RUNNING SG_PROCESS_STATE_SLEEPING
			  SG_PROCESS_STATE_STOPPED SG_PROCESS_STATE_ZOMBIE
					  SG_PROCESS_STATE_UNKNOWN)) {
	defined $proc_by_type[Unix::Statgrab->$state] or next;
	print $proc_by_type[Unix::Statgrab->$state] . " of " . $total_procs . " procs in $state\n";
    }

    my $last_cpu_stats = get_cpu_stats() or croak( get_error()->strperror() );
    do_sth_way_longer();
    my $cpu_diff = get_cpu_stats()->get_cpu_stats_diff($last_cpu_stats);

    my $last_cpu_percent = $last_cpu_percent->get_cpu_percents();
    my $diff_cpu_percent = $cpu_diff->get_cpu_percents();
    my $now_cpu_percent = get_cpu_stats()->get_cpu_percents();

=head1 DESCRIPTION

Unix::Statgrab is a wrapper for libstatgrab as available from
L<http://www.i-scream.org/libstatgrab/>. It is a reasonably portable attempt
to query interesting stats about your computer. It covers information on the
operating system, CPU, memory usage, network interfaces, hard-disks etc. 

Each of the provided functions follow a simple rule: It never takes any
argument and returns either an object (in case of success) or C<undef>. In
case C<undef> was returned, check the return value of C<get_error>. Also
see L<"ERROR HANDLING"> further below.

To avoid error during copying documentation, the original function
documentation will be refererred where reasonable. Each returned object
has a getter method named as the attribute in original documentation.
Those getters take a optional index argument, asking for the attribute
of the C<n>th statistic item. Further, each object provides an C<entries>()
method, telling you how much statistics for requested type are returned
(yes, even C<get_host_info()> has that, maybe we have more host_info
when grabbing that statistic in a cluster, grid or cloud). Additionally,
for the users of Perl's list processing features, each object has an
C<as_list>() method which returns the statistic as list of hash items
containing each attribute / value pair of available attributes.

=head1 METHODS of sg_*_stats

=over 4

=item * C<entries>

Provides the number of statistic objects in the returned collection.

=item * C<as_list>

Provides a list containing each statistic entry as a hash with the
attribute names as key and the statistic attribute as appropriate
value.

=item * C<systime>

Even if it's always an attribute (beside for C<cpu_percents>), returns
the seconds since epoch of the time when the statistics are snapshotted.

=item * I<attribute>(C<offset> I<= 0>)

Returns the value of the queried attribute of the given entry of
the statistics collection. If C<offset> exceeds the range, C<undef>
is returned.

=back

=head1 FUNCTIONS

=head2 drop_privileges()

Unix::Statgrab can be told to discard I<setuid> and I<setgid> privileges
which is usually a good thing. If your program
doesn't need the elevated privileges somewhere else, call it right after
C<use>ing the module.

This function is depreciated and might be removed in a future version of
libstatgrab (and then in Unix::Statgrab, too).

=head2 get_host_info()

Returns generic information about this machine. The object it returns
is a L<http://www.i-scream.org/libstatgrab/docs/sg_get_host_info.3.html|Unix::Statgrab::sg_host_info>.

=head2 get_cpu_stats

Returns information about this machine's usage of the CPU. The object it
returns is a L<http://www.i-scream.org/libstatgrab/docs/sg_get_cpu_stats.3.html|Unix::Statgrab::sg_cpu_stats>.

=head3 extra sg_cpu_stats methods

=over 4

=item * C<get_cpu_stats_diff>

Provides the difference between the last measurement and the recent one.

  $recent->get_cpu_stats_diff($last);

Returns L<http://www.i-scream.org/libstatgrab/docs/sg_get_cpu_stats.3.html|Unix::Statgrab::sg_cpu_stats>

=item * C<get_cpu_percents>

Provides a percentage representation of the single cpu ticks measured.
Returns L<http://www.i-scream.org/libstatgrab/docs/sg_get_cpu_stats.3.html|Unix::Statgrab::sg_cpu_percents>

=back

=head2 get_disk_io_stats

Delivers the disk IO per disk stored in the kernel which holds the amount of
data transferred since bootup. The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_disk_io_stats.3.html|Unix::Statgrab::sg_disk_io_stats>.

=head3 extra sg_disk_io_stats methods

=over 4

=item * C<get_disk_io_stats_diff>

Provides the difference between the last measurement and the recent one.

  $recent->get_disk_io_stats_diff($last);

Returns L<http://www.i-scream.org/libstatgrab/docs/sg_get_disk_io_stats.3.html|Unix::Statgrab::sg_disk_io_stats>

=back

=head2 get_fs_stats

Returns statistics about the mounted filesystems. The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_fs_stats.3.html|Unix::Statgrab::sg_fs_stats>.

=head3 extra sg_fs_stats methods

=over 4

=item * C<get_fs_stats_diff>

Provides the difference between the last measurement and the recent one.

  $recent->get_fs_stats_diff($last);

Returns L<http://www.i-scream.org/libstatgrab/docs/sg_get_fs_stats.3.html|Unix::Statgrab::sg_fs_stats>

=back

=head2 get_load_stats

Returns the load average over various span of times. The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_load_stats.3.html|Unix::Statgrab::sg_load_stats>.

=head2 get_mem_stats

Returns statistics about memory usage. The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_mem_stats.3.html|Unix::Statgrab::sg_mem_stats>.

=head2 get_swap_stats

Returns statistics about swap usage. The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_swap_stats.3.html|Unix::Statgrab::sg_swap_stats>.

=head2 get_network_io_stats

Returns statistics about the network traffic per network interface as
stored in the kernel. The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_network_io_stats.3.html|Unix::Statgrab::sg_network_io_stats>.

=head3 extra sg_network_io_stats methods

=over 4

=item * C<get_network_io_stats_diff>

Provides the difference between the last measurement and the recent one.

  $recent->get_network_io_stats_diff($last);

Returns L<http://www.i-scream.org/libstatgrab/docs/sg_get_network_io_stats.3.html|Unix::Statgrab::sg_network_io_stats>

=back

=head2 get_network_iface_stats

Returns statistics about each of the found network interfaces in your computer.
The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_network_iface_stats.3.html|Unix::Statgrab::sg_network_iface_stats>.

=head2 get_page_stats

Returns the number of pages the system has paged in and out since bootup.
The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_page_stats.3.html|Unix::Statgrab::sg_page_stats>.

=head3 extra sg_page_stats methods

=over 4

=item * C<get_page_stats_diff>

Provides the difference between the last measurement and the recent one.

  $recent->get_page_stats_diff($last);

Returns L<http://www.i-scream.org/libstatgrab/docs/sg_get_page_stats.3.html|Unix::Statgrab::sg_page_stats>

=back

=head2 get_process_stats

Returns loads of information about the current processes.
The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_process_stats.3.html|Unix::Statgrab::sg_process_stats>.

=head2 get_user_stats

Returns session information about logged on users.
The object it returns is a
L<http://www.i-scream.org/libstatgrab/docs/sg_get_user_stats.3.html|Unix::Statgrab::sg_user_stats>.

=head1 ERROR HANDLING

One function C<get_error> exists that will return the last error encountered,
if any. It's return value is an object of type
L<http://www.i-scream.org/libstatgrab/docs/sg_get_error.3.html|Unix::Statgrab::sg_error_details>.

=head3 extra sg_error_details methods

=over 4

=item * C<error_name>

Returns a textual representation for the C<error> numeric value. The textual
representation is delivered by the libstatgrab function C<sg_str_error>.

=item * C<strperror>

Returns a textual representation for the C<sg_error_details> object. The
textual representation is delivered by the libstatgrab function
C<sg_strperror>.

=back

=head1 EXPORT

B<All> by default. This means all of the above functions plus the following constants:

  SG_ERROR_NONE
  SG_ERROR_INVALID_ARGUMENT
  SG_ERROR_ASPRINTF
  SG_ERROR_SPRINTF
  SG_ERROR_DEVICES
  SG_ERROR_DEVSTAT_GETDEVS
  SG_ERROR_DEVSTAT_SELECTDEVS
  SG_ERROR_DISKINFO
  SG_ERROR_ENOENT
  SG_ERROR_GETIFADDRS
  SG_ERROR_GETMNTINFO
  SG_ERROR_GETPAGESIZE
  SG_ERROR_HOST
  SG_ERROR_KSTAT_DATA_LOOKUP
  SG_ERROR_KSTAT_LOOKUP
  SG_ERROR_KSTAT_OPEN
  SG_ERROR_KSTAT_READ
  SG_ERROR_KVM_GETSWAPINFO
  SG_ERROR_KVM_OPENFILES
  SG_ERROR_MALLOC
  SG_ERROR_MEMSTATUS
  SG_ERROR_OPEN
  SG_ERROR_OPENDIR
  SG_ERROR_READDIR
  SG_ERROR_PARSE
  SG_ERROR_PDHADD
  SG_ERROR_PDHCOLLECT
  SG_ERROR_PDHOPEN
  SG_ERROR_PDHREAD
  SG_ERROR_PERMISSION
  SG_ERROR_PSTAT
  SG_ERROR_SETEGID
  SG_ERROR_SETEUID
  SG_ERROR_SETMNTENT
  SG_ERROR_SOCKET
  SG_ERROR_SWAPCTL
  SG_ERROR_SYSCONF
  SG_ERROR_SYSCTL
  SG_ERROR_SYSCTLBYNAME
  SG_ERROR_SYSCTLNAMETOMIB
  SG_ERROR_SYSINFO
  SG_ERROR_MACHCALL
  SG_ERROR_IOKIT
  SG_ERROR_UNAME
  SG_ERROR_UNSUPPORTED
  SG_ERROR_XSW_VER_MISMATCH
  SG_ERROR_GETMSG
  SG_ERROR_PUTMSG
  SG_ERROR_INITIALISATION
  SG_ERROR_MUTEX_LOCK
  SG_ERROR_MUTEX_UNLOCK

  sg_unknown_configuration
  sg_physical_host
  sg_virtual_machine
  sg_paravirtual_machine
  sg_hardware_virtualized

  sg_fs_unknown
  sg_fs_regular
  sg_fs_special
  sg_fs_loopback
  sg_fs_remote
  sg_fs_local
  sg_fs_alltypes

  SG_IFACE_DUPLEX_FULL
  SG_IFACE_DUPLEX_HALF
  SG_IFACE_DUPLEX_UNKNOWN

  SG_IFACE_DOWN
  SG_IFACE_UP

  SG_PROCESS_STATE_RUNNING
  SG_PROCESS_STATE_SLEEPING
  SG_PROCESS_STATE_STOPPED
  SG_PROCESS_STATE_ZOMBIE
  SG_PROCESS_STATE_UNKNOWN

If you don't want that, use the module thusly:

    use Unix::Statgrab ();

or provide a list of those symbols you want:

    use Unix::Statgrab qw/get_network_iface_stats 
                          SG_IFACE_DUPLEX_FULL
			  SG_IFACE_DUPLEX_HALF
			  SG_IFACE_DUPLEX_UNKNOWN/;

=head1 SEE ALSO

The excellent and very complete manpage of statgrab(3). You can get
additional information for each of the above functions by prefixing the
function name with "sg_" and feed it to C<man>:

    man sg_get_network_iface_stats

libstatgrab's home is at L<http://www.i-scream.org/libstatgrab/>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Unix::Statgrab

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Unix-Statgrab>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Unix-Statgrab>

=item * CPAN Ratings

L<http://cpanratings.perl.org/s/Unix-Statgrab>

=item * CPAN Search

L<http://search.cpan.org/dist/Unix-Statgrab/>

=back

=head2 Where can I go for help?

If you have a bug report, a patch or a suggestion, please open a new
report ticket at CPAN (but please check previous reports first in case
your issue has already been addressed). You can mail any of the module
maintainers, but you are more assured of an answer by posting to
the dbi-users list or reporting the issue in RT.

Report tickets should contain a detailed description of the bug or
enhancement request and at least an easily verifiable way of
reproducing the issue or fix. Patches are always welcome, too.

=head2 Where can I go for help with a concrete version?

Bugs and feature requests are accepted against the latest version
only. To get patches for earlier versions, you need to get an
agreement with a developer of your choice - who may or not report the
issue and a suggested fix upstream (depends on the license you have
chosen).

=head2 Business support and maintenance

For business support you can contact Jens via his CPAN email
address rehsackATcpan.org. Please keep in mind that business
support is neither available for free nor are you eligible to
receive any support based on the license distributed with this
package.

=head1 AUTHOR

Tassilo von Parseval, E<lt>tassilo.von.parseval@rwth-aachen.deE<gt>

Jens Rehsack, E<lt>rehsack AT cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004-2005 by Tassilo von Parseval

Copyright (C) 2012-2013 by Jens Rehsack

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation; either version 2.1 of the License, or (at your option) any
later version.

=cut
