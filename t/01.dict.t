# -*- cperl -*-

use Test::More tests => 5;
use Lingua::PT::Abbrev;


my $dic = Lingua::PT::Abbrev->new;

is($dic->expand("foo."), undef);

is($dic->expand("sr."), "senhor");
is($dic->expand("sr"), "senhor");
is($dic->expand("SR."), "senhor");
is($dic->expand("SR"), "senhor");


