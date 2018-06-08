## in a separate test file
use Test::More;

BEGIN
{
    $] >= 5.008 or plan skip_all => "Test::Spelling requires perl 5.8";
}
use Test::Spelling;

add_stopwords(<DATA>);
all_pod_files_spelling_ok();

__END__
AIX
AnnoCPAN
CPAN
cpan
Jens
Parseval
Rehsack
Tassilo
bitwidth
bootup
colnames
cpu
egid
eth
fxp
getter
getters
ierrors
iowait
ipackets
libstatgrab
logon
maxcpus
ncpus
nentries
oerrors
opackets
pgid
proctitle
refererred
rehsackATcpan
rx
sessid
strperror
systime
thusly
tx
uptime
userland
von
zfs
