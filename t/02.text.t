# -*- cperl -*-

use Test::More tests => 1;
use Lingua::PT::Abbrev;


my $dic = Lingua::PT::Abbrev->new;

is($dic->text_expand("O Sr. Joaquim é um foo."),
   "O senhor Joaquim é um foo.");


