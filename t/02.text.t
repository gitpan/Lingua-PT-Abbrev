# -*- cperl -*-

use Test::More tests => 1;
use Lingua::PT::Abbrev;


my $dic = Lingua::PT::Abbrev->new;

is($dic->text_expand("O Sr. Joaquim � um foo."),
   "O senhor Joaquim � um foo.");


