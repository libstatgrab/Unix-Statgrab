#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <statgrab.h>

#include "const-c.inc"

typedef struct {
    sg_disk_io_stats *stats;
    int ndisks;
} sg_disk_io_stats_my;

typedef struct {
    sg_fs_stats *stats;
    int nmounts;
} sg_fs_stats_my;

typedef struct {
    sg_network_io_stats *stats;
    int nifs;
} sg_network_io_stats_my;

typedef struct {
    sg_network_iface_stats *stats;
    int nifs;
} sg_network_iface_stats_my;

typedef struct {
    sg_process_stats *stats;
    int nprocs;
} sg_process_stats_my;

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab

INCLUDE: const-xs.inc

BOOT:
{
    sg_init();
}

void
get_error ()
    PROTOTYPE: 
    CODE:
    {
	SV *sv = sv_newmortal();
	int ec = sg_get_error();

	SvUPGRADE(sv, SVt_PVIV);
	sv_setpv(sv, sg_str_error(ec));
	SvIVX(sv) = ec;
	SvIOK_on(sv);

	EXTEND(SP, 1);
	ST(0) = sv;
	
	if (GIMME == G_ARRAY) {
	    EXTEND(SP, 2);
	    ST(1) = sv_newmortal();
	    sv_setpv(ST(1), sg_get_error_arg());
	    XSRETURN(2);
	}
	
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
	if ((self = sg_get_host_info()) == NULL)
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
	if ((self = sg_get_cpu_stats()) == NULL) 
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_cpu_stats", (void*)self);
	XSRETURN(1);
    }

void
get_cpu_stats_diff ()
    PROTOTYPE:
    CODE:
    {
	sg_cpu_stats *self;
	if ((self = sg_get_cpu_stats_diff()) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_cpu_stats", (void*)self);
	XSRETURN(1);
    }

void
get_cpu_percents ()
    PROTOTYPE:
    CODE:
    {
	sg_cpu_percents *self;
	if ((self = sg_get_cpu_percents()) == NULL) 
	    XSRETURN_UNDEF;
	
	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_cpu_percents", (void*)self);
	XSRETURN(1);
    }

void
get_disk_io_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_disk_io_stats_my *self;
	
	New(0, self, 1, sg_disk_io_stats_my);
	
	if ((self->stats = sg_get_disk_io_stats(&self->ndisks)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_disk_io_stats_my", (void*)self);
	XSRETURN(1);
    }

void
get_disk_io_stats_diff ()
    PROTOTYPE:
    CODE:
    {
	sg_disk_io_stats_my *self;

	New(0, self, 1, sg_disk_io_stats_my);

	if ((self->stats = sg_get_disk_io_stats_diff(&self->ndisks)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_disk_io_stats_my", (void*)self);
	XSRETURN(1);
    }

void
get_fs_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_fs_stats_my *self;

	New(0, self, 1, sg_fs_stats_my);

	if ((self->stats = sg_get_fs_stats(&self->nmounts)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_fs_stats_my", (void*)self);
	XSRETURN(1);
    }

void
get_load_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_load_stats *self;
	if ((self = sg_get_load_stats()) == NULL)
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
	if ((self = sg_get_mem_stats()) == NULL)
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
	if ((self = sg_get_swap_stats()) == NULL)
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
	sg_network_io_stats_my *self;

	New(0, self, 1, sg_network_io_stats_my);

	if ((self->stats = sg_get_network_io_stats(&self->nifs)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_network_io_stats_my", (void*)self);
	XSRETURN(1);
    }
	
void
get_network_io_stats_diff ()
    PROTOTYPE:
    CODE:
    {
	sg_network_io_stats_my *self;

	New(0, self, 1, sg_network_io_stats_my);

	if ((self->stats = sg_get_network_io_stats_diff(&self->nifs)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_network_io_stats_my", (void*)self);
	XSRETURN(1);
    }

void
get_network_iface_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_network_iface_stats_my *self;

	New(0, self, 1, sg_network_iface_stats_my);

	if ((self->stats = sg_get_network_iface_stats(&self->nifs)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_network_iface_stats_my", (void*)self);
	XSRETURN(1);
    }

void
get_page_stats ()
    PROTOTYPE:
    CODE:
    {
	sg_page_stats *self;
	if ((self = sg_get_page_stats()) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_page_stats", (void*)self);
	XSRETURN(1);
    }

void
get_page_stats_diff ()
    PROTOTYPE:
    CODE:
    {
	sg_page_stats *self;
	if ((self = sg_get_page_stats_diff()) == NULL)
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
	if ((self = sg_get_user_stats()) == NULL)
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
	sg_process_stats_my *self;
	
	New(0, self, 1, sg_process_stats_my);
	
	if ((self->stats = sg_get_process_stats(&self->nprocs)) == NULL)
	    XSRETURN_UNDEF;

	EXTEND(SP, 1);

	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "Unix::Statgrab::sg_process_stats_my", (void*)self);
	XSRETURN(1);
    }

int
_sort_procs_by_name (a, b)
	sg_process_stats *a;
	sg_process_stats *b;
    PROTOTYPE: $$
    CODE:
    {
	RETVAL = sg_process_compare_name(a, b);
    }
    OUTPUT:
	RETVAL
   
int
_sort_procs_by_pid (a, b)
	sg_process_stats *a;
	sg_process_stats *b;
    PROTOTYPE: $$
    CODE:
    {
	RETVAL = sg_process_compare_pid(a, b);
    }
    OUTPUT:
	RETVAL

int
_sort_procs_by_uid (a, b)
	sg_process_stats *a;
	sg_process_stats *b;
    PROTOTYPE: $$
    CODE:
    {
	RETVAL = sg_process_compare_uid(a, b);
    }
    OUTPUT:
	RETVAL

int
_sort_procs_by_gid (a, b)
	sg_process_stats *a;
	sg_process_stats *b;
    PROTOTYPE: $$
    CODE:
    {
	RETVAL = sg_process_compare_gid(a, b);
    }
    OUTPUT:
	RETVAL

int
_sort_procs_by_size (a, b)
	sg_process_stats *a;
	sg_process_stats *b;
    PROTOTYPE: $$
    CODE:
    {
	RETVAL = sg_process_compare_size(a, b);
    }
    OUTPUT:
	RETVAL
	
int
_sort_procs_by_res (a, b)
	sg_process_stats *a;
	sg_process_stats *b;
    PROTOTYPE: $$
    CODE:
    {
	RETVAL = sg_process_compare_res(a, b);
    }
    OUTPUT:
	RETVAL

int
_sort_procs_by_cpu (a, b)
	sg_process_stats *a;
	sg_process_stats *b;
    PROTOTYPE: $$
    CODE:
    {
	RETVAL = sg_process_compare_time(a, b);
    }
    OUTPUT:
	RETVAL

int
_sort_procs_by_time (a, b)
	sg_process_stats *a;
	sg_process_stats *b;
    PROTOTYPE: $$
    CODE:
    {
	RETVAL = sg_process_compare_time (a, b);
    }
    OUTPUT:
	RETVAL
	
MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_host_info

char *
os_name (self)
	sg_host_info *self;
    CODE:
	RETVAL = self->os_name;
    OUTPUT:
	RETVAL

char *
os_release (self)
	sg_host_info *self;
    CODE:
	RETVAL = self->os_release;
    OUTPUT:
	RETVAL

char *
os_version (self)
	sg_host_info *self;
    CODE:
	RETVAL = self->os_version;
    OUTPUT:
	RETVAL

char *
platform (self)
	sg_host_info *self;
    CODE:
	RETVAL = self->platform;
    OUTPUT:
	RETVAL

char *
hostname (self)
	sg_host_info *self;
    CODE:
	RETVAL = self->hostname;
    OUTPUT:
	RETVAL

UV
uptime (self)
	sg_host_info *self;
    CODE:
	RETVAL = self->uptime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_host_info *self;
    CODE:
    {
	/* self points to a static buffer */
    }

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab::sg_cpu_stats

NV
user (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = self->user;
    OUTPUT:
	RETVAL

NV
kernel (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = self->kernel;
    OUTPUT:
	RETVAL

NV
idle (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = self->idle;
    OUTPUT:
	RETVAL

NV
iowait (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = self->iowait;
    OUTPUT:
	RETVAL

NV
swap (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = self->swap;
    OUTPUT:
	RETVAL

NV
nice (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = self->nice;
    OUTPUT:
	RETVAL

NV
total (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = self->total;
    OUTPUT:
	RETVAL

UV
systime (self)
	sg_cpu_stats *self;
    CODE:
	RETVAL = self->systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_cpu_stats *self;
    CODE:
    {
	/* self points to a static buffer */
    }
	
MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab::sg_cpu_percents

NV
user (self)
	sg_cpu_percents *self;
    CODE:
	RETVAL = self->user;
    OUTPUT:
	RETVAL

NV
kernel (self)
	sg_cpu_percents *self;
    CODE:
	RETVAL = self->kernel;
    OUTPUT:
	RETVAL

NV
idle (self)
	sg_cpu_percents *self;
    CODE:
	RETVAL = self->idle;
    OUTPUT:
	RETVAL

NV
iowait (self)
	sg_cpu_percents *self;
    CODE:
	RETVAL = self->iowait;
    OUTPUT:
	RETVAL

NV
swap (self)
	sg_cpu_percents *self;
    CODE:
	RETVAL = self->swap;
    OUTPUT:
	RETVAL

NV
nice (self)
	sg_cpu_percents *self;
    CODE:
	RETVAL = self->nice;
    OUTPUT:
	RETVAL

UV
systime (self)
	sg_cpu_percents *self;
    CODE:
	RETVAL = self->time_taken;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_cpu_percents *self;
    CODE:
    {
	/* self points to a static buffer */
    }

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab::sg_disk_io_stats_my

#define DISK(n)	(self->stats + n)

int
num_disks (self)
	sg_disk_io_stats_my *self;
    CODE:
	RETVAL = self->ndisks;
    OUTPUT:
	RETVAL

char *
disk_name (self, num = 0)
	sg_disk_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->ndisks)
	    XSRETURN_UNDEF;
	RETVAL = DISK(num)->disk_name;
    OUTPUT:
	RETVAL

NV
read_bytes (self, num = 0)
	sg_disk_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->ndisks)
	    XSRETURN_UNDEF;
	RETVAL = DISK(num)->read_bytes;
    OUTPUT:
	RETVAL

NV
write_bytes (self, num = 0)
	sg_disk_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->ndisks)
	    XSRETURN_UNDEF;
	RETVAL = DISK(num)->write_bytes;
    OUTPUT:
	RETVAL

UV
systime (self, num = 0)
	sg_disk_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->ndisks)
	    XSRETURN_UNDEF;
	RETVAL = DISK(num)->systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_disk_io_stats_my *self;
    CODE:
    {
	Safefree(self);
    }

MODULE = Unix::Statgrab		PACKAGE = Unix::Statgrab::sg_fs_stats_my

#define MOUNT(n)    (self->stats + n)

IV
num_fs (self)
	sg_fs_stats_my *self;
    CODE:
	RETVAL = self->nmounts;
    OUTPUT:
	RETVAL

char *
device_name (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->device_name;
    OUTPUT:
	RETVAL

char *
fs_type (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->fs_type;
    OUTPUT:
	RETVAL

char *
mnt_point (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->mnt_point;
    OUTPUT:
	RETVAL

NV
size (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->size;
    OUTPUT:
	RETVAL

NV
used (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->used;
    OUTPUT:
	RETVAL

NV
avail (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->avail;
    OUTPUT:
	RETVAL

NV
total_inodes (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->total_inodes;
    OUTPUT:
	RETVAL

NV
used_inodes (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->used_inodes;
    OUTPUT:
	RETVAL

NV
free_inodes (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->free_inodes;
    OUTPUT:
	RETVAL

NV
avail_inodes (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->avail_inodes;
    OUTPUT:
	RETVAL

NV
io_size (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->io_size;
    OUTPUT:
	RETVAL

NV
block_size (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->block_size;
    OUTPUT:
	RETVAL

NV
total_blocks (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->total_blocks;
    OUTPUT:
	RETVAL

NV
free_blocks (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->free_blocks;
    OUTPUT:
	RETVAL

NV
used_blocks (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->used_blocks;
    OUTPUT:
	RETVAL

NV
avail_blocks (self, num = 0)
	sg_fs_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nmounts)
	    XSRETURN_UNDEF;
	RETVAL = MOUNT(num)->avail_blocks;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_fs_stats_my *self;
    CODE:
    {
	Safefree(self);
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_load_stats

NV
min1 (self)
	sg_load_stats *self;
    CODE:
	RETVAL = self->min1;
    OUTPUT:
	RETVAL

NV
min5 (self)
	sg_load_stats *self;
    CODE:
	RETVAL = self->min5;
    OUTPUT:
	RETVAL

NV
min15 (self)
	sg_load_stats *self;
    CODE:
	RETVAL = self->min15;
    OUTPUT:
	RETVAL
	
void
DESTROY (self)
	sg_load_stats *self;
    CODE:
    {
	/* self points to a static buffer */
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_mem_stats

NV
total (self)
	sg_mem_stats *self;
    CODE:
	RETVAL = self->total;
    OUTPUT:
	RETVAL

NV
free (self)
	sg_mem_stats *self;
    CODE:
	RETVAL = self->free;
    OUTPUT:
	RETVAL

NV
used (self)
	sg_mem_stats *self;
    CODE:
	RETVAL = self->used;
    OUTPUT:
	RETVAL

NV
cache (self)
	sg_mem_stats *self;
    CODE:
	RETVAL = self->cache;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_mem_stats *self;
    CODE:
    {
	/* self points to a static buffer */
    }

MODULE = Unix::Statgrab     PACKAGE = Unix::Statgrab::sg_swap_stats

NV
total (self)
	sg_swap_stats *self;
    CODE:
	RETVAL = self->total;
    OUTPUT:
	RETVAL

NV
free (self)
	sg_swap_stats *self;
    CODE:
	RETVAL = self->free;
    OUTPUT:
	RETVAL

NV
used (self)
	sg_swap_stats *self;
    CODE:
	RETVAL = self->used;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_swap_stats *self;
    CODE:
    {
	/* self points to a static buffer */
    }

MODULE = Unix::Statgrab     PACKAGE = Unix::Statgrab::sg_network_io_stats_my

# some perls have IF defined already

#ifdef IF
# undef IF
#endif
#define IF(n)	(self->stats + n)

IV
num_ifaces (self)
	sg_network_io_stats_my *self;
    CODE:
	RETVAL = self->nifs;
    OUTPUT:
	RETVAL

char *
interface_name (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->interface_name;
    OUTPUT:
	RETVAL

NV
tx (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->tx;
    OUTPUT:
	RETVAL
    
NV
rx (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->rx;
    OUTPUT:
	RETVAL
   
NV
ipackets (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->ipackets;
    OUTPUT:
	RETVAL

NV
opackets (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->opackets;
    OUTPUT:
	RETVAL

NV
ierrors (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->ierrors;
    OUTPUT:
	RETVAL

NV
oerrors (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->oerrors;
    OUTPUT:
	RETVAL

NV
collisions (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->collisions;
    OUTPUT:
	RETVAL

UV
systime (self, num = 0)
	sg_network_io_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->systime;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_network_io_stats_my *self;
    CODE:
    {
	Safefree(self);
    }

MODULE = Unix::Statgrab     PACKAGE = Unix::Statgrab::sg_network_iface_stats_my

IV
num_ifaces (self)
	sg_network_iface_stats_my *self;
    CODE:
	RETVAL = self->nifs;
    OUTPUT:
	RETVAL

char *
interface_name (self, num = 0)
	sg_network_iface_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->interface_name;
    OUTPUT:
	RETVAL

IV
speed (self, num = 0)
	sg_network_iface_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->speed;
    OUTPUT:
	RETVAL

IV
dup (self, num = 0)
	sg_network_iface_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->duplex;
    OUTPUT:
	RETVAL

IV
up (self, num = 0)
	sg_network_iface_stats_my *self;
	int num;
    CODE:
	if (num < 0 || num >= self->nifs)
	    XSRETURN_UNDEF;
	RETVAL = IF(num)->up;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_network_iface_stats_my *self;
    CODE:
    {
	Safefree(self);
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_page_stats

NV
pages_pagein (self)
	sg_page_stats *self;
    CODE:
	RETVAL = self->pages_pagein;
    OUTPUT:
	RETVAL

NV
pages_pageout (self)
	sg_page_stats *self;
    CODE:
	RETVAL = self->pages_pageout;
    OUTPUT:
	RETVAL

UV
systime (self)
	sg_page_stats *self;
    CODE:
	RETVAL = self->systime;
    OUTPUT:
	RETVAL
	
void
DESTROY (self)
	sg_page_stats *self;
    CODE:
    {
	/* self points to a static buffer */
    }

MODULE = Unix::Statgrab     PACKAGE = Unix::Statgrab::sg_user_stats

void
name_list (self)
	sg_user_stats *self;
    CODE:
    {	
	register char *c = self->name_list;
	register char *last = self->name_list;
	register unsigned int i = 0;
	
	EXTEND(SP, self->num_entries);

	while (*c) {
	    if (*c++ == ' ' || !*c) {
		ST(i) = sv_newmortal();
		sv_setpvn(ST(i), last, *c ? c - last - 1 : c - last);
		last = c;
		i++;
	    }
	}
	XSRETURN(i);
    }

IV
num_entries (self)
	sg_user_stats *self;
    CODE:
	RETVAL = self->num_entries;
    OUTPUT:
	RETVAL

void
DESTROY (self)
	sg_user_stats *self;
    CODE:
    {
	/* self points to a static buffer */
    }

MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_process_stats_my

#define PROC(n)    (self->stats + n)

void
all_procs (self)
	sg_process_stats_my *self;
    PPCODE:
    {
	register int i = 0;
	EXTEND(SP, self->nprocs);
	
	for (i = 0; i < self->nprocs; i++) {
	    SV *proc = sv_newmortal();
	    sv_setref_pv(proc, "Unix::Statgrab::sg_process_stats", (void*)PROC(i));
	    XPUSHs(proc);
	}

	XSRETURN(self->nprocs);
    }

void
sort_by (obj, meth)
	SV *obj;
	char *meth;
    PPCODE:
    {
	sg_process_stats_my *self = (sg_process_stats_my*)SvIV(SvRV(obj));

	if (strEQ(meth, "name")) 
	    qsort(self->stats, self->nprocs, sizeof(*self->stats), sg_process_compare_name);
	else if (strEQ(meth, "pid")) 
	    qsort(self->stats, self->nprocs, sizeof(*self->stats), sg_process_compare_pid);
	else if (strEQ(meth, "uid")) 
	    qsort(self->stats, self->nprocs, sizeof(*self->stats), sg_process_compare_uid);
	else if (strEQ(meth, "gid")) 
	    qsort(self->stats, self->nprocs, sizeof(*self->stats), sg_process_compare_gid);
	else if (strEQ(meth, "size")) 
	    qsort(self->stats, self->nprocs, sizeof(*self->stats), sg_process_compare_size);
	else if (strEQ(meth, "res")) 
	    qsort(self->stats, self->nprocs, sizeof(*self->stats), sg_process_compare_res);
	else if (strEQ(meth, "cpu")) 
	    qsort(self->stats, self->nprocs, sizeof(*self->stats), sg_process_compare_cpu);
	else if (strEQ(meth, "time")) 
	    qsort(self->stats, self->nprocs, sizeof(*self->stats), sg_process_compare_time);
	
	XPUSHs(obj);
	XSRETURN(1);
    }

void
DESTROY (self)
	sg_process_stats_my *self;
    CODE:
    {
	Safefree(self);
    }
	
MODULE = Unix::Statgrab	    PACKAGE = Unix::Statgrab::sg_process_stats

char *
proc_name (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->process_name;
    OUTPUT:
	RETVAL

char *
proc_title (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->proctitle;
    OUTPUT:
	RETVAL

int
pid (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->pid;
    OUTPUT:
	RETVAL

int
parent_pid (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->parent;
    OUTPUT:
	RETVAL

int
pgid (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->pgid;
    OUTPUT:
	RETVAL

int
uid (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->uid;
    OUTPUT:
	RETVAL

int 
euid (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->euid;
    OUTPUT:
	RETVAL

int
gid (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->gid;
    OUTPUT:
	RETVAL

int
egid (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->egid;
    OUTPUT:
	RETVAL

NV
proc_size (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->proc_size;
    OUTPUT:
	RETVAL

NV
proc_resident (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->proc_resident;
    OUTPUT:
	RETVAL

int
time_spent (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->time_spent;
    OUTPUT:
	RETVAL

double
cpu_percent (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->cpu_percent;
    OUTPUT:
	RETVAL

int
nice (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->nice;
    OUTPUT:
	RETVAL

int
state (self)
	sg_process_stats *self;
    CODE:
	RETVAL = self->state;
    OUTPUT:
	RETVAL
	
void
DESTROY (self)
	sg_process_stats *self;
    CODE:
    {
	/* self points to a static buffer */
    }
