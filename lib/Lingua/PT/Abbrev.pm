package Lingua::PT::Abbrev;

use warnings;
use strict;

=head1 NAME

Lingua::PT::Abbrev - An abbreviations dictionary manager for NLP

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

This module handles a built-in abbreviations dictionary, and a user
customized abbreviations dictionary. It provides handy functions for
NLP processing.

   use Lingua::PT::Abbrev;

   my $dic = Lingua::PT::Abbrev->new;

   my $exp = $dic -> expand("sr");

   $text = $dic -> text_expand($text);

=head1 FUNCTIONS

=head2 new

This is the Lingua::PT::Abbrev dictionaries constructor. You don't
need to pass it any parameter, unless you want to maintain a personal
dictionary. In that case, pass the path to your personal dictionary
file.

The dictionary file is a text file, one abbreviation by line, as:

  sr senhor
  sra senhora
  dr doutor

=cut

sub new {
  my $class = shift;
  my $custom = shift || undef;
  my $self = bless { custom => $custom }, $class;

  $self->_load_dictionary;
  $self->_load_dictionary($custom) if ($custom);

  return $self;
}

sub _load_dictionary {
  my $self = shift;
  my $file = shift || undef;

  if ($file) {
    open C, $file or die;
    while(<C>) {
      chomp;
      ($a,$b) = split /\s+/, lc;
      $self->{cdic}{$a} = $b;
    }
    close C;
  } else {
    seek DATA, 0, 0;
    while(<DATA>) {
      chomp;
      next if m!^\s*$!;
      ($a,$b) = split /\s+/, lc;
      $self->{dic}{$a} = $b;
    }
  }
}

=head2 expand

Given an abbreviation, this method expands it. For expanding
abbreviations in a text use C<<text_expand>>, a lot faster.

Returns undef if the abbreviation is not known.

=cut

sub expand {
  my $self = shift;
  my $abbrev = lc(shift);
  $abbrev =~ s!\.$!!;
  return $self->_expand($abbrev) || undef;
}

sub _exists {
  my $self = shift;
  my $word = shift;
  return exists($self->{dic}{$word}) or
    exists($self->{cdic}{$word}) or
      exists($self->{sdic}{$word})
}

sub _expand {
  my $self = shift;
  my $word = shift;
  return $self->{sdic}{$word} ||
    $self->{cdic}{$word} ||
      $self->{dic}{$word};
}

=head2 text_expand

Given a text, this method expands all known abbreviations

=cut

sub text_expand {
  my $self = shift;
  my $text = shift;

  $text =~ s{((\w+)\.)}{
    $self->_expand(lc($2))||$1
  }eg;

  return $text;
}

=head2 add

Use this method to add an abbreviation to your current dictionary.

=cut

sub add {
  my ($self,$abr,$exp) = @_;
  return undef unless $abr and $exp;
  $self->{cdic}{lc($abr)} = lc($exp);
}

=head2 session_add

Use this method to add an abbreviation to your session dictionary.

=cut

sub session_add {
  my ($self,$abr,$exp) = @_;
  return undef unless $abr and $exp;
  $self->{sdic}{lc($abr)} = lc($exp);
}

=head2 save

This method saves the custom dictionary

=cut

sub save {
  my $self = shift;
  open DIC, ">$self->{custom}" or die;
  for (keys %{$self->{cdic}}) {
    print DIC "$_ $self->{cdic}{$_}\n";
  }
  close DIC;
}

=head1 AUTHOR

Alberto Simões, C<< <ambs@cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-lingua-pt-abbrev@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2004 Alberto Simões, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Lingua::PT::Abbrev

__DATA__
dr doutor
dra doutora
drs doutores
dras doutoras
etc etc.
prof professor
profa professora
profs professores
profas professoras
séc século
av avenida
sr senhor
sra senhora
