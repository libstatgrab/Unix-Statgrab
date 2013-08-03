use 5.00803;

use strict;
use warnings;

use lib qw(inc);
use Statgrab::Builder;

my $builder = Statgrab::Builder->new(
    module_name => 'Unix::Statgrab',
    license     => 'perl',
    dist_author => [
                     'Tassilo von Parseval <tassilo.von.parseval@rwth-aachen.de>',
                     'Jens Rehsack <sno@NetBSD.org>'
                   ],
    needs_compiler     => 1,
    configure_requires => {
                            'File::Copy'       => '0',
                            'Module::Build'    => '0.4000',
                            'Config::AutoConf' => '0.19',
                          },
    build_requires => {
                        'Config::AutoConf'   => '0.19',
                        'Capture::Tiny'      => '0.06',
                        'ExtUtils::CBuilder' => '0.27',
                        'Module::Build'      => '0.4000',
                      },
    add_to_cleanup => [ 'Unix-Statgrab-*', '*.o', 'config.h', 'config.log', ],
    test_files => [ "t/*.t", "xt/*.t" ],
                                    );

$builder->create_build_script();
