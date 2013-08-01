package Config::AutoConf::SG;

use strict;
use warnings;

use parent qw(Config::AutoConf);

sub new
{
    my ($class, %args) = @_;
    my $self = $class->SUPER::new(%args);
    # XXX might add c++ if required for some operating systems
    return $self;
}

sub check_libstatgrab
{
    my ($self) = @_;
    ref($self) or $self = $self->_get_instance();

    return $self->search_libs( "sg_get_process_stats_r", ["statgrab"] );
}

1;
