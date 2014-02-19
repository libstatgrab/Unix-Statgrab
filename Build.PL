use 5.008003;

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
                                                  'parent'           => 0,
                                                },
                          build_requires => {
                                              'Config::AutoConf'   => '0.19',
                                              'Capture::Tiny'      => '0.06',
                                              'ExtUtils::CBuilder' => '0.27',
                                              'Module::Build'      => '0.4000',
                                            },
                          meta_merge => {
                                         'meta-spec' => { version => 2 },
                                         resources   => {
                                             repository => {
                                                 web => 'https://github.com/i-scream/Unix-Statgrab',
                                                 type => 'git',
                                             },
                                         },
                                         prereqs => {
                                                 develop => {
                                                     requires => {
                                                         'Test::CPAN::Changes'                 => 0,
                                                         'Test::CheckManifest'                 => 0,
                                                         'Test::Pod'                           => 0,
                                                         'Test::Pod::Coverage'                 => 0,
                                                         'Test::Pod::Spelling::CommonMistakes' => 0,
                                                     },
                                                 },
                                         },
                                        },
                          add_to_cleanup => [ 'Unix-Statgrab-*', '*.o', 'config.h', 'config.log', ],
                          test_files => [ "t/*.t", "xt/*.t" ],
);
eval { $builder->dispatch("configure"); };
$@ and warn $@ and exit 0;
$builder->create_build_script();
