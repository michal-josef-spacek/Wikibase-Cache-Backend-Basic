package Wikibase::Cache::Backend::Basic;

use base qw(Wikibase::Cache::Backend);
use strict;
use warnings;

use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Text::DSV;

our $VERSION = 0.01;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Process parameters.
	set_params($self, @params);

	$self->_load_data;

	return $self;
}

sub _get {
	my ($self, $type, $key) = @_;

	if (exists $self->{static}->{$key}) {
		if (exists $self->{static}->{$key}->{$type}) {
			return $self->{static}->{$key}->{$type};
		} else {
			return;
		}
	} else {
		return;
	}	
}

sub _load_data {
	my $self = shift;

	# Read data.
	my $kramerius_data;
	my $dsv = Text::DSV->new;
	while (my $data = <DATA>) {
		chomp $data;
		my ($qid, $label, $description) = $dsv->parse_line($data);
		$self->{'static'}->{$qid}->{'property_label'} = $label;
		$self->{'static'}->{$qid}->{'property_description'} = $description;
	}

	return;
}

sub _save {
	my ($self, $type, $key, $value) = @_;

	err "__PACKAGE__ doesn't implement save() method.";
}

1;

__DATA__
# Basic properties
P31:instance of:that class of which this subject is a particular example and member
P279:subclass of:next higher class or type; all instances of these items are instances of those items; this item is a class (subset) of that item. Not to be confused with P31 (instance of)
# Some basic quantities
Q174728:centimetre:unit of length equal to 1/100 of a metre
Q11573:metre:SI unit of length
Q828224:kilometre:unit of length equal to 1,000 meters
Q3710:foot:unit of length
Q174789:millimetre:unit of length 1/1000th of a metre
Q218593:inch:unit of length
Q253276:mile:unit of length
Q200323:decimetre:unit of length
Q844338:hectometre:unit of length equal to 100m
Q848856:decametre:length unit equal to 10 metres
Q355198:pixel:physical point in a raster image
Q178674:nanometre:unit of length
Q7673190:table cell:grouping within a chart table used for storing information or data
Q70280567:Prussian foot:unit of length
# Time precision
Q12138:Gregorian calendar:arithmetic solar calendar system, with a 365-day year, plus one day intercalated into one of the 12 month during some years; internationally the most widely accepted civil calendar
Q1985727:proleptic Gregorian calendar:extension of the Gregorian calendar before its introduction
Q11184:Julian calendar:Calendar introduced by Julius Caesar in 45 BC
Q1985786:proleptic Julian calendar:extension of the regular Julian calendar
