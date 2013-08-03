#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <statgrab.h>

#include "const-c.inc"

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab

INCLUDE: const-xs.inc

BOOT:
{
    /* sg_log_init(properties_pfx, env_name, argv0) */
    sg_log_init("libstatgrab", "LIBSTATGRAB_LOG_PROPERTIES", NULL);
    sg_init(1);
}

void
get_error ()
    PROTOTYPE: 
    CODE:
    {
	sg_error_details *self = safemalloc(sizeof(sg_error_details));

	if (SG_ERROR_NONE == sg_get_error_details(self))
	{
	    XSRETURN_UNDEF;
	}

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_error_details", (void*)self);
	XSRETURN(1);
    }

int
drop_privileges ()
    PROTOTYPE:
    CODE:
	RETVAL = sg_drop_privileges() == 0;
    OUTPUT:
	RETVAL

void
get_host_info ()
    PROTOTYPE:
    CODE:
    {
	sg_host_info *self;
	if ((self = sg_get_host_info_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_host_info", (void*)self);
	XSRETURN(1);
    }

void
get_cpu_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_cpu_stats *self;
	if ((self = sg_get_cpu_stats_r(NULL)) == NULL) 
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_cpu_stats", (void*)self);
	XSRETURN(1);
    }

void
get_disk_io_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_disk_io_stats *self;
	if ((self = sg_get_disk_io_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_disk_io_stats", (void*)self);
	XSRETURN(1);
    }

void
get_fs_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_fs_stats *self;

	New(0, self, 1, sg_fs_stats);

	if ((self = sg_get_fs_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_fs_stats", (void*)self);
	XSRETURN(1);
    }

void
get_load_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_load_stats *self;
	if ((self = sg_get_load_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;
	
	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_load_stats", (void*)self);
	XSRETURN(1);
    }

void
get_mem_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_mem_stats *self;
	if ((self = sg_get_mem_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_mem_stats", (void*)self);
	XSRETURN(1);
    }

void
get_swap_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_swap_stats *self;
	if ((self = sg_get_swap_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_swap_stats", (void*)self);
	XSRETURN(1);
    }

void
get_network_io_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_network_io_stats *self;

	New(0, self, 1, sg_network_io_stats);

	if ((self = sg_get_network_io_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_network_io_stats", (void*)self);
	XSRETURN(1);
    }
	
void
get_network_iface_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_network_iface_stats *self;

	New(0, self, 1, sg_network_iface_stats);

	if ((self = sg_get_network_iface_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_network_iface_stats", (void*)self);
	XSRETURN(1);
    }

void
get_page_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_page_stats *self;
	if ((self = sg_get_page_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_page_stats", (void*)self);
	XSRETURN(1);
    }

void
get_user_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_user_stats *self;
	if ((self = sg_get_user_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_user_stats", (void*)self);
	XSRETURN(1);
    }

void
get_process_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_process_stats *self;
	
	New(0, self, 1, sg_process_stats);
	
	if ((self = sg_get_process_stats_r(NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_process_stats", (void*)self);
	XSRETURN(1);
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_error_details

UV
error (self)
	sg_error_details *self;
    CODE:
	RETVAL = self->error;
    OUTPUT:
	RETVAL

const char *
error_name(self)
	sg_error_details *self;
    CODE:
	RETVAL = sg_str_error(self->error);
    OUTPUT:
	RETVAL

IV
errno_value (self)
	sg_error_details *self;
    CODE:
	RETVAL = self->errno_value;
    OUTPUT:
	RETVAL

const char *
error_arg (self)
	sg_error_details *self;
    CODE:
	RETVAL = self->error_arg;
    OUTPUT:
	RETVAL

void
strperror (self)
	sg_error_details *self;
    CODE:
    {
	char *buf = NULL;
	if(NULL == sg_strperror(&buf, self))
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = newSVpv(buf, 0);
	free(buf);
	sv_2mortal(ST(0));
	XSRETURN(1);
    }

void
DESTROY (self)
	sg_error_details *self;
    CODE:
    {
	Safefree(self);
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_host_info

UV
entries (self)
	sg_host_info *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

char *
os_name (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].os_name;
    OUTPUT:
	RETVAL

char *
os_release (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].os_release;
    OUTPUT:
	RETVAL

char *
os_version (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].os_version;
    OUTPUT:
	RETVAL

char *
platform (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].platform;
    OUTPUT:
	RETVAL

char *
hostname (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].hostname;
    OUTPUT:
	RETVAL

UV
bitwidth (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].bitwidth;
    OUTPUT:
	RETVAL

UV
host_state (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].host_state;
    OUTPUT:
	RETVAL

UV
ncpus (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].ncpus;
    OUTPUT:
	RETVAL

UV
maxcpus (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].maxcpus;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

IV
uptime (self, num = 0)
	sg_host_info *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].uptime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_host_info *self;
    CODE:
    {
	sg_free_host_info(self);
    }

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab::sg_cpu_stats

UV
entries (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

NV
user (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].user;
    OUTPUT:
	RETVAL

NV
kernel (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].kernel;
    OUTPUT:
	RETVAL

NV
idle (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].idle;
    OUTPUT:
	RETVAL

NV
iowait (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].iowait;
    OUTPUT:
	RETVAL

NV
swap (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].swap;
    OUTPUT:
	RETVAL

NV
nice (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].nice;
    OUTPUT:
	RETVAL

NV
total (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].total;
    OUTPUT:
	RETVAL

NV
context_switches (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].context_switches;
    OUTPUT:
	RETVAL

NV
voluntary_context_switches (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].voluntary_context_switches;
    OUTPUT:
	RETVAL

NV
involuntary_context_switches (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].involuntary_context_switches;
    OUTPUT:
	RETVAL

NV
syscalls (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].syscalls;
    OUTPUT:
	RETVAL

NV
interrupts (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].interrupts;
    OUTPUT:
	RETVAL

NV
soft_interrupts (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].soft_interrupts;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_cpu_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_cpu_stats *self;
    CODE:
    {
	sg_free_cpu_stats(self);
    }

void
get_cpu_stats_diff (now, last)
	sg_cpu_stats *now;
	sg_cpu_stats *last;
    CODE:
    {
	sg_cpu_stats *self;
	if ((self = sg_get_cpu_stats_diff_between(now, last, NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_cpu_stats", (void*)self);
	XSRETURN(1);
    }

void
get_cpu_percents (of)
	sg_cpu_stats *of;
    CODE:
    {
	sg_cpu_percents *self;
	size_t entries;
	if ((self = sg_get_cpu_percents_r(of, &entries)) == NULL) 
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_cpu_percents", (void*)self);
	XSRETURN(1);
    }

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab::sg_cpu_percents

UV
entries (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

NV
user (self, num = 0)
	sg_cpu_percents *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].user;
    OUTPUT:
	RETVAL

NV
kernel (self, num = 0)
	sg_cpu_percents *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].kernel;
    OUTPUT:
	RETVAL

NV
idle (self, num = 0)
	sg_cpu_percents *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].idle;
    OUTPUT:
	RETVAL

NV
iowait (self, num = 0)
	sg_cpu_percents *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].iowait;
    OUTPUT:
	RETVAL

NV
swap (self, num = 0)
	sg_cpu_percents *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].swap;
    OUTPUT:
	RETVAL

NV
nice (self, num = 0)
	sg_cpu_percents *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].nice;
    OUTPUT:
	RETVAL

UV
time_taken (self, num = 0)
	sg_cpu_percents *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].time_taken;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_cpu_percents *self;
    CODE:
    {
	sg_free_cpu_percents(self);
    }

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab::sg_disk_io_stats

UV
entries (self)
	sg_disk_io_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

char *
disk_name (self, num = 0)
	sg_disk_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].disk_name;
    OUTPUT:
	RETVAL

NV
read_bytes (self, num = 0)
	sg_disk_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].read_bytes;
    OUTPUT:
	RETVAL

NV
write_bytes (self, num = 0)
	sg_disk_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].write_bytes;
    OUTPUT:
	RETVAL

UV
systime (self, num = 0)
	sg_disk_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_disk_io_stats *self;
    CODE:
    {
	sg_free_disk_io_stats(self);
    }

void
get_disk_io_stats_diff (now, last)
	sg_disk_io_stats *now;
	sg_disk_io_stats *last;
    CODE:
    {
	sg_disk_io_stats *self;

	if ((self = sg_get_disk_io_stats_diff_between(now, last, NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_disk_io_stats", (void*)self);
	XSRETURN(1);
    }

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab::sg_fs_stats

UV
entries (self)
	sg_fs_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

char *
device_name (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].device_name;
    OUTPUT:
	RETVAL

char *
fs_type (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].fs_type;
    OUTPUT:
	RETVAL

char *
mnt_point (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].mnt_point;
    OUTPUT:
	RETVAL

UV
device_type (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].device_type;
    OUTPUT:
	RETVAL

NV
size (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].size;
    OUTPUT:
	RETVAL

NV
used (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].used;
    OUTPUT:
	RETVAL

NV
free (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].free;
    OUTPUT:
	RETVAL

NV
avail (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].avail;
    OUTPUT:
	RETVAL

NV
total_inodes (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].total_inodes;
    OUTPUT:
	RETVAL

NV
used_inodes (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].used_inodes;
    OUTPUT:
	RETVAL

NV
free_inodes (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].free_inodes;
    OUTPUT:
	RETVAL

NV
avail_inodes (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].avail_inodes;
    OUTPUT:
	RETVAL

NV
io_size (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].io_size;
    OUTPUT:
	RETVAL

NV
block_size (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].block_size;
    OUTPUT:
	RETVAL

NV
total_blocks (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].total_blocks;
    OUTPUT:
	RETVAL

NV
free_blocks (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].free_blocks;
    OUTPUT:
	RETVAL

NV
used_blocks (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].used_blocks;
    OUTPUT:
	RETVAL

NV
avail_blocks (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].avail_blocks;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_fs_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_fs_stats *self;
    CODE:
    {
	sg_free_fs_stats(self);
    }

void
get_fs_stats_diff (now, last)
	sg_fs_stats *now;
	sg_fs_stats *last;
    CODE:
    {
	sg_fs_stats *self;

	if ((self = sg_get_fs_stats_diff_between(now, last, NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_fs_stats", (void*)self);
	XSRETURN(1);
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_load_stats

UV
entries (self)
	sg_load_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

NV
min1 (self, num = 0)
	sg_load_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].min1;
    OUTPUT:
	RETVAL

NV
min5 (self, num = 0)
	sg_load_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].min5;
    OUTPUT:
	RETVAL

NV
min15 (self, num = 0)
	sg_load_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].min15;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_load_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_load_stats *self;
    CODE:
    {
	sg_free_load_stats(self);
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_mem_stats

UV
entries (self)
	sg_mem_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

NV
total (self, num = 0)
	sg_mem_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].total;
    OUTPUT:
	RETVAL

NV
free (self, num = 0)
	sg_mem_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].free;
    OUTPUT:
	RETVAL

NV
used (self, num = 0)
	sg_mem_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].used;
    OUTPUT:
	RETVAL

NV
cache (self, num = 0)
	sg_mem_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].cache;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_mem_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_mem_stats *self;
    CODE:
    {
	sg_free_mem_stats(self);
    }

MODULE = Unix::Statgrab     PACKAGE = Unix::Statgrab::sg_swap_stats

UV
entries (self)
	sg_swap_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

NV
total (self, num = 0)
	sg_swap_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].total;
    OUTPUT:
	RETVAL

NV
free (self, num = 0)
	sg_swap_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].free;
    OUTPUT:
	RETVAL

NV
used (self, num = 0)
	sg_swap_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].used;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_swap_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_swap_stats *self;
    CODE:
    {
	sg_free_swap_stats(self);
    }

MODULE = Unix::Statgrab     PACKAGE = Unix::Statgrab::sg_network_io_stats

UV
entries (self)
	sg_network_io_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

char *
interface_name (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].interface_name;
    OUTPUT:
	RETVAL

NV
tx (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].tx;
    OUTPUT:
	RETVAL
    
NV
rx (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].rx;
    OUTPUT:
	RETVAL
   
NV
ipackets (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].ipackets;
    OUTPUT:
	RETVAL

NV
opackets (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].opackets;
    OUTPUT:
	RETVAL

NV
ierrors (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].ierrors;
    OUTPUT:
	RETVAL

NV
oerrors (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].oerrors;
    OUTPUT:
	RETVAL

NV
collisions (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].collisions;
    OUTPUT:
	RETVAL

UV
systime (self, num = 0)
	sg_network_io_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_network_io_stats *self;
    CODE:
    {
	sg_free_network_io_stats(self);
    }

void
get_network_io_stats_diff (now, last)
	sg_network_io_stats *now;
	sg_network_io_stats *last;
    CODE:
    {
	sg_network_io_stats *self;

	if ((self = sg_get_network_io_stats_diff_between(now, last, NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_network_io_stats", (void*)self);
	XSRETURN(1);
    }

MODULE = Unix::Statgrab     PACKAGE = Unix::Statgrab::sg_network_iface_stats

UV
entries (self)
	sg_network_iface_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

char *
interface_name (self, num = 0)
	sg_network_iface_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].interface_name;
    OUTPUT:
	RETVAL

NV
speed (self, num = 0)
	sg_network_iface_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].speed;
    OUTPUT:
	RETVAL

NV
factor (self, num = 0)
	sg_network_iface_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].factor;
    OUTPUT:
	RETVAL

UV
duplex (self, num = 0)
	sg_network_iface_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].duplex;
    OUTPUT:
	RETVAL

UV
up (self, num = 0)
	sg_network_iface_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].up;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_network_iface_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_network_iface_stats *self;
    CODE:
    {
	sg_free_network_iface_stats(self);
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_page_stats

UV
entries (self)
	sg_page_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

NV
pages_pagein (self, num = 0)
	sg_page_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].pages_pagein;
    OUTPUT:
	RETVAL

NV
pages_pageout (self, num = 0)
	sg_page_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].pages_pageout;
    OUTPUT:
	RETVAL

UV
systime (self, num = 0)
	sg_page_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL
	
void
DESTROY (self)
	sg_page_stats *self;
    CODE:
    {
	sg_free_page_stats(self);
    }

void
get_page_stats_diff (now, last)
	sg_page_stats *now;
	sg_page_stats *last;
    CODE:
    {
	sg_page_stats *self;
	if ((self = sg_get_page_stats_diff_between(now, last, NULL)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_page_stats", (void*)self);
	XSRETURN(1);
    }

MODULE = Unix::Statgrab     PACKAGE = Unix::Statgrab::sg_user_stats

UV
entries (self)
	sg_user_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

char *
login_name (self, num = 0)
	sg_user_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].login_name;
    OUTPUT:
	RETVAL

void
record_id (self, num = 0)
	sg_user_stats *self;
	UV num;
    CODE:
    { 
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = newSVpvn_flags(self[num].record_id, self[num].record_id_size, SVs_TEMP);
	XSRETURN(1);
    }

char *
device (self, num = 0)
	sg_user_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].device;
    OUTPUT:
	RETVAL

char *
hostname (self, num = 0)
	sg_user_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].hostname;
    OUTPUT:
	RETVAL

IV
pid (self, num = 0)
	sg_user_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].pid;
    OUTPUT:
	RETVAL

IV
login_time (self, num = 0)
	sg_user_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].login_time;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_user_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_user_stats *self;
    CODE:
    {
	sg_free_user_stats(self);
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_process_stats

UV
entries (self)
	sg_process_stats *self;
    CODE:
	RETVAL = sg_get_nelements(self);
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_process_stats *self;
    CODE:
    {
	sg_free_process_stats(self);
    }
	
char *
process_name (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].process_name;
    OUTPUT:
	RETVAL

char *
proctitle (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].proctitle;
    OUTPUT:
	RETVAL

IV
pid (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].pid;
    OUTPUT:
	RETVAL

IV
parent (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].parent;
    OUTPUT:
	RETVAL

IV
pgid (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].pgid;
    OUTPUT:
	RETVAL

IV
sessid (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].sessid;
    OUTPUT:
	RETVAL

IV
uid (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].uid;
    OUTPUT:
	RETVAL

IV 
euid (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].euid;
    OUTPUT:
	RETVAL

IV
gid (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].gid;
    OUTPUT:
	RETVAL

IV
egid (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].egid;
    OUTPUT:
	RETVAL

NV
context_switches (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].context_switches;
    OUTPUT:
	RETVAL

NV
voluntary_context_switches (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].voluntary_context_switches;
    OUTPUT:
	RETVAL

NV
involuntary_context_switches (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].involuntary_context_switches;
    OUTPUT:
	RETVAL

NV
proc_size (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].proc_size;
    OUTPUT:
	RETVAL

NV
proc_resident (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].proc_resident;
    OUTPUT:
	RETVAL

IV
start_time (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].start_time;
    OUTPUT:
	RETVAL

IV
time_spent (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].time_spent;
    OUTPUT:
	RETVAL

NV
cpu_percent (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].cpu_percent;
    OUTPUT:
	RETVAL

IV
nice (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].nice;
    OUTPUT:
	RETVAL

UV
state (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].state;
    OUTPUT:
	RETVAL

IV
systime (self, num = 0)
	sg_process_stats *self;
	UV num;
    CODE:
	if (num >= sg_get_nelements(self))
	    XSRETURN_UNDEF;
	RETVAL = self[num].systime;
    OUTPUT:
	RETVAL
