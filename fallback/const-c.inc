#define PERL_constant_NOTFOUND	1
#define PERL_constant_NOTDEF	2
#define PERL_constant_ISIV	3
#define PERL_constant_ISNO	4
#define PERL_constant_ISNV	5
#define PERL_constant_ISPV	6
#define PERL_constant_ISPVN	7
#define PERL_constant_ISSV	8
#define PERL_constant_ISUNDEF	9
#define PERL_constant_ISUV	10
#define PERL_constant_ISYES	11

#ifndef NVTYPE
typedef double NV; /* 5.6 and later define NVTYPE, and typedef NV to it.  */
#endif
#ifndef aTHX_
#define aTHX_ /* 5.6 or later define this for threading support.  */
#endif
#ifndef pTHX_
#define pTHX_ /* 5.6 or later define this for threading support.  */
#endif

static int
constant_15 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     SG_ERROR_ENOENT SG_ERROR_MALLOC SG_ERROR_SOCKET SG_ERROR_SYSCTL */
  /* Offset 12 gives the best switch position.  */
  switch (name[12]) {
  case 'C':
    if (memEQ(name, "SG_ERROR_SYSCTL", 15)) {
    /*                           ^         */
#ifdef SG_ERROR_SYSCTL
      *iv_return = SG_ERROR_SYSCTL;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'E':
    if (memEQ(name, "SG_ERROR_ENOENT", 15)) {
    /*                           ^         */
#ifdef SG_ERROR_ENOENT
      *iv_return = SG_ERROR_ENOENT;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'K':
    if (memEQ(name, "SG_ERROR_SOCKET", 15)) {
    /*                           ^         */
#ifdef SG_ERROR_SOCKET
      *iv_return = SG_ERROR_SOCKET;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'L':
    if (memEQ(name, "SG_ERROR_MALLOC", 15)) {
    /*                           ^         */
#ifdef SG_ERROR_MALLOC
      *iv_return = SG_ERROR_MALLOC;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_16 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     SG_ERROR_OPENDIR SG_ERROR_SETEGID SG_ERROR_SETEUID SG_ERROR_SWAPCTL
     SG_ERROR_SYSCONF */
  /* Offset 13 gives the best switch position.  */
  switch (name[13]) {
  case 'C':
    if (memEQ(name, "SG_ERROR_SWAPCTL", 16)) {
    /*                            ^         */
#ifdef SG_ERROR_SWAPCTL
      *iv_return = SG_ERROR_SWAPCTL;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'D':
    if (memEQ(name, "SG_ERROR_OPENDIR", 16)) {
    /*                            ^         */
#ifdef SG_ERROR_OPENDIR
      *iv_return = SG_ERROR_OPENDIR;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'G':
    if (memEQ(name, "SG_ERROR_SETEGID", 16)) {
    /*                            ^         */
#ifdef SG_ERROR_SETEGID
      *iv_return = SG_ERROR_SETEGID;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'O':
    if (memEQ(name, "SG_ERROR_SYSCONF", 16)) {
    /*                            ^         */
#ifdef SG_ERROR_SYSCONF
      *iv_return = SG_ERROR_SYSCONF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'U':
    if (memEQ(name, "SG_ERROR_SETEUID", 16)) {
    /*                            ^         */
#ifdef SG_ERROR_SETEUID
      *iv_return = SG_ERROR_SETEUID;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_19 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     SG_ERROR_GETIFADDRS SG_ERROR_GETMNTINFO SG_ERROR_KSTAT_OPEN
     SG_ERROR_KSTAT_READ */
  /* Offset 16 gives the best switch position.  */
  switch (name[16]) {
  case 'D':
    if (memEQ(name, "SG_ERROR_GETIFADDRS", 19)) {
    /*                               ^         */
#ifdef SG_ERROR_GETIFADDRS
      *iv_return = SG_ERROR_GETIFADDRS;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'E':
    if (memEQ(name, "SG_ERROR_KSTAT_READ", 19)) {
    /*                               ^         */
#ifdef SG_ERROR_KSTAT_READ
      *iv_return = SG_ERROR_KSTAT_READ;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'N':
    if (memEQ(name, "SG_ERROR_GETMNTINFO", 19)) {
    /*                               ^         */
#ifdef SG_ERROR_GETMNTINFO
      *iv_return = SG_ERROR_GETMNTINFO;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'P':
    if (memEQ(name, "SG_ERROR_KSTAT_OPEN", 19)) {
    /*                               ^         */
#ifdef SG_ERROR_KSTAT_OPEN
      *iv_return = SG_ERROR_KSTAT_OPEN;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_20 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     SG_ERROR_GETPAGESIZE SG_ERROR_UNSUPPORTED SG_IFACE_DUPLEX_FULL
     SG_IFACE_DUPLEX_HALF */
  /* Offset 19 gives the best switch position.  */
  switch (name[19]) {
  case 'D':
    if (memEQ(name, "SG_ERROR_UNSUPPORTE", 19)) {
    /*                                  D      */
#ifdef SG_ERROR_UNSUPPORTED
      *iv_return = SG_ERROR_UNSUPPORTED;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'E':
    if (memEQ(name, "SG_ERROR_GETPAGESIZ", 19)) {
    /*                                  E      */
#ifdef SG_ERROR_GETPAGESIZE
      *iv_return = SG_ERROR_GETPAGESIZE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'F':
    if (memEQ(name, "SG_IFACE_DUPLEX_HAL", 19)) {
    /*                                  F      */
#ifdef SG_IFACE_DUPLEX_HALF
      *iv_return = SG_IFACE_DUPLEX_HALF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'L':
    if (memEQ(name, "SG_IFACE_DUPLEX_FUL", 19)) {
    /*                                  L      */
#ifdef SG_IFACE_DUPLEX_FULL
      *iv_return = SG_IFACE_DUPLEX_FULL;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_24 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     SG_ERROR_DEVSTAT_GETDEVS SG_ERROR_KVM_GETSWAPINFO SG_ERROR_SYSCTLNAMETOMIB
     SG_PROCESS_STATE_RUNNING SG_PROCESS_STATE_STOPPED SG_PROCESS_STATE_UNKNOWN
     */
  /* Offset 21 gives the best switch position.  */
  switch (name[21]) {
  case 'E':
    if (memEQ(name, "SG_ERROR_DEVSTAT_GETDEVS", 24)) {
    /*                                    ^         */
#ifdef SG_ERROR_DEVSTAT_GETDEVS
      *iv_return = SG_ERROR_DEVSTAT_GETDEVS;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'I':
    if (memEQ(name, "SG_PROCESS_STATE_RUNNING", 24)) {
    /*                                    ^         */
#ifdef SG_PROCESS_STATE_RUNNING
      *iv_return = SG_PROCESS_STATE_RUNNING;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'M':
    if (memEQ(name, "SG_ERROR_SYSCTLNAMETOMIB", 24)) {
    /*                                    ^         */
#ifdef SG_ERROR_SYSCTLNAMETOMIB
      *iv_return = SG_ERROR_SYSCTLNAMETOMIB;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'N':
    if (memEQ(name, "SG_ERROR_KVM_GETSWAPINFO", 24)) {
    /*                                    ^         */
#ifdef SG_ERROR_KVM_GETSWAPINFO
      *iv_return = SG_ERROR_KVM_GETSWAPINFO;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'O':
    if (memEQ(name, "SG_PROCESS_STATE_UNKNOWN", 24)) {
    /*                                    ^         */
#ifdef SG_PROCESS_STATE_UNKNOWN
      *iv_return = SG_PROCESS_STATE_UNKNOWN;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'P':
    if (memEQ(name, "SG_PROCESS_STATE_STOPPED", 24)) {
    /*                                    ^         */
#ifdef SG_PROCESS_STATE_STOPPED
      *iv_return = SG_PROCESS_STATE_STOPPED;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant (pTHX_ const char *name, STRLEN len, IV *iv_return) {
  /* Initially switch on the length of the name.  */
  /* When generated this function returned values for the list of names given
     in this section of perl code.  Rather than manually editing these functions
     to add or remove constants, which would result in this comment and section
     of code becoming inaccurate, we recommend that you edit this section of
     code, and use it to regenerate a new set of constant functions which you
     then use to replace the originals.

     Regenerate these constant functions by feeding this entire source file to
     perl -x

#!/usr/bin/perl -w
use ExtUtils::Constant qw (constant_types C_constant XS_constant);

my $types = {map {($_, 1)} qw(IV)};
my @names = (qw(SG_ERROR_ASPRINTF SG_ERROR_DEVSTAT_GETDEVS
	       SG_ERROR_DEVSTAT_SELECTDEVS SG_ERROR_ENOENT SG_ERROR_GETIFADDRS
	       SG_ERROR_GETMNTINFO SG_ERROR_GETPAGESIZE
	       SG_ERROR_KSTAT_DATA_LOOKUP SG_ERROR_KSTAT_LOOKUP
	       SG_ERROR_KSTAT_OPEN SG_ERROR_KSTAT_READ SG_ERROR_KVM_GETSWAPINFO
	       SG_ERROR_KVM_OPENFILES SG_ERROR_MALLOC SG_ERROR_NONE
	       SG_ERROR_OPEN SG_ERROR_OPENDIR SG_ERROR_PARSE SG_ERROR_SETEGID
	       SG_ERROR_SETEUID SG_ERROR_SETMNTENT SG_ERROR_SOCKET
	       SG_ERROR_SWAPCTL SG_ERROR_SYSCONF SG_ERROR_SYSCTL
	       SG_ERROR_SYSCTLBYNAME SG_ERROR_SYSCTLNAMETOMIB SG_ERROR_UNAME
	       SG_ERROR_UNSUPPORTED SG_ERROR_XSW_VER_MISMATCH
	       SG_IFACE_DUPLEX_FULL SG_IFACE_DUPLEX_HALF
	       SG_IFACE_DUPLEX_UNKNOWN SG_PROCESS_STATE_RUNNING
	       SG_PROCESS_STATE_SLEEPING SG_PROCESS_STATE_STOPPED
	       SG_PROCESS_STATE_UNKNOWN SG_PROCESS_STATE_ZOMBIE));

print constant_types(); # macro defs
foreach (C_constant ("Unix::Statgrab", 'constant', 'IV', $types, undef, 3, @names) ) {
    print $_, "\n"; # C constant subs
}
print "#### XS Section:\n";
print XS_constant ("Unix::Statgrab", $types);
__END__
   */

  switch (len) {
  case 13:
    /* Names all of length 13.  */
    /* SG_ERROR_NONE SG_ERROR_OPEN */
    /* Offset 9 gives the best switch position.  */
    switch (name[9]) {
    case 'N':
      if (memEQ(name, "SG_ERROR_NONE", 13)) {
      /*                        ^          */
#ifdef SG_ERROR_NONE
        *iv_return = SG_ERROR_NONE;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'O':
      if (memEQ(name, "SG_ERROR_OPEN", 13)) {
      /*                        ^          */
#ifdef SG_ERROR_OPEN
        *iv_return = SG_ERROR_OPEN;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 14:
    /* Names all of length 14.  */
    /* SG_ERROR_PARSE SG_ERROR_UNAME */
    /* Offset 9 gives the best switch position.  */
    switch (name[9]) {
    case 'P':
      if (memEQ(name, "SG_ERROR_PARSE", 14)) {
      /*                        ^           */
#ifdef SG_ERROR_PARSE
        *iv_return = SG_ERROR_PARSE;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'U':
      if (memEQ(name, "SG_ERROR_UNAME", 14)) {
      /*                        ^           */
#ifdef SG_ERROR_UNAME
        *iv_return = SG_ERROR_UNAME;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 15:
    return constant_15 (aTHX_ name, iv_return);
    break;
  case 16:
    return constant_16 (aTHX_ name, iv_return);
    break;
  case 17:
    if (memEQ(name, "SG_ERROR_ASPRINTF", 17)) {
#ifdef SG_ERROR_ASPRINTF
      *iv_return = SG_ERROR_ASPRINTF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 18:
    if (memEQ(name, "SG_ERROR_SETMNTENT", 18)) {
#ifdef SG_ERROR_SETMNTENT
      *iv_return = SG_ERROR_SETMNTENT;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 19:
    return constant_19 (aTHX_ name, iv_return);
    break;
  case 20:
    return constant_20 (aTHX_ name, iv_return);
    break;
  case 21:
    /* Names all of length 21.  */
    /* SG_ERROR_KSTAT_LOOKUP SG_ERROR_SYSCTLBYNAME */
    /* Offset 11 gives the best switch position.  */
    switch (name[11]) {
    case 'S':
      if (memEQ(name, "SG_ERROR_SYSCTLBYNAME", 21)) {
      /*                          ^                */
#ifdef SG_ERROR_SYSCTLBYNAME
        *iv_return = SG_ERROR_SYSCTLBYNAME;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'T':
      if (memEQ(name, "SG_ERROR_KSTAT_LOOKUP", 21)) {
      /*                          ^                */
#ifdef SG_ERROR_KSTAT_LOOKUP
        *iv_return = SG_ERROR_KSTAT_LOOKUP;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 22:
    if (memEQ(name, "SG_ERROR_KVM_OPENFILES", 22)) {
#ifdef SG_ERROR_KVM_OPENFILES
      *iv_return = SG_ERROR_KVM_OPENFILES;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 23:
    /* Names all of length 23.  */
    /* SG_IFACE_DUPLEX_UNKNOWN SG_PROCESS_STATE_ZOMBIE */
    /* Offset 19 gives the best switch position.  */
    switch (name[19]) {
    case 'M':
      if (memEQ(name, "SG_PROCESS_STATE_ZOMBIE", 23)) {
      /*                                  ^          */
#ifdef SG_PROCESS_STATE_ZOMBIE
        *iv_return = SG_PROCESS_STATE_ZOMBIE;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'N':
      if (memEQ(name, "SG_IFACE_DUPLEX_UNKNOWN", 23)) {
      /*                                  ^          */
#ifdef SG_IFACE_DUPLEX_UNKNOWN
        *iv_return = SG_IFACE_DUPLEX_UNKNOWN;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 24:
    return constant_24 (aTHX_ name, iv_return);
    break;
  case 25:
    /* Names all of length 25.  */
    /* SG_ERROR_XSW_VER_MISMATCH SG_PROCESS_STATE_SLEEPING */
    /* Offset 24 gives the best switch position.  */
    switch (name[24]) {
    case 'G':
      if (memEQ(name, "SG_PROCESS_STATE_SLEEPIN", 24)) {
      /*                                       G      */
#ifdef SG_PROCESS_STATE_SLEEPING
        *iv_return = SG_PROCESS_STATE_SLEEPING;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'H':
      if (memEQ(name, "SG_ERROR_XSW_VER_MISMATC", 24)) {
      /*                                       H      */
#ifdef SG_ERROR_XSW_VER_MISMATCH
        *iv_return = SG_ERROR_XSW_VER_MISMATCH;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 26:
    if (memEQ(name, "SG_ERROR_KSTAT_DATA_LOOKUP", 26)) {
#ifdef SG_ERROR_KSTAT_DATA_LOOKUP
      *iv_return = SG_ERROR_KSTAT_DATA_LOOKUP;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 27:
    if (memEQ(name, "SG_ERROR_DEVSTAT_SELECTDEVS", 27)) {
#ifdef SG_ERROR_DEVSTAT_SELECTDEVS
      *iv_return = SG_ERROR_DEVSTAT_SELECTDEVS;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

