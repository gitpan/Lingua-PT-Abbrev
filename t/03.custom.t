# -*- cperl -*-

use Test::More tests => 5;
use Lingua::PT::Abbrev;
use File::Copy;

copy("t/custom","custom");
my $dic = Lingua::PT::Abbrev->new("custom");

is($dic->text_expand("O Sr. Joaquim é um foo. ou um zbr."),
   "O senhor Joaquim é um fooing ou um zbr.");

$dic->add("zbr","zbring");

is($dic->text_expand("O Sr. Joaquim é um foo. ou um zbring"),
   "O senhor Joaquim é um fooing ou um zbring");

$dic->session_add("ugh","ughing");

is($dic->expand("ugh"),"ughing");

$dic->save;

my $dic2 = Lingua::PT::Abbrev->new("custom");
is($dic2->text_expand("O Sr. Joaquim é um foo. ou um zbring"),
   "O senhor Joaquim é um fooing ou um zbring");

is($dic2->expand("ugh"),undef);

unlink "custom"
