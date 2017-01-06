use strict;
use warnings;
use Test::More tests => 3;
use FFI::TinyCC;
use FFI::Platypus;

my $tcc = FFI::TinyCC->new;

eval { $tcc->compile_string(q{int foo() { return 42; }}) };
is $@, '', 'tcc.compile_string';

my $ptr = eval { $tcc->get_symbol('foo') };
ok $ptr, "tcc.get_symbol('foo') == $ptr";

my $ffi = FFI::Platypus->new;
$ffi->attach([$ptr => 'foo'] => [] => 'int');
is foo(), 42, 'foo.call';
