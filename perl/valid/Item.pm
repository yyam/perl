package Item;

use strict;
use warnings;
use Digest::MD5 'md5_hex';
use Data::Dumper;
use Carp 'croak';
use base ('Class::Accessor');

my @accessors = qw/id name color/;
my @ro_accessors = qw/_errors _check_code/;

Item->mk_accessors(@accessors);
Item->mk_ro_accessors(@ro_accessors);

my @VALID_COLORS = qw/red blue yellow/;

sub new {
	my $class = shift;
	my $args = shift;
	my $self = $class->SUPER::new({
		_errors => +[],
		_check_code => +[],
		%$args
	});
	bless($self, $class);

	if ($self->validate()->has_error()) {
		croak("validation failed.");
	}

	return $self;
}

sub validate {
	my $self = shift;

	$self->{_errors} = +[];
	$self->{_check_code} = +[];

	unless ($self->id() =~ /^\d{1,10}$/ ) {
		push(@{$self->_errors()}, "validation error: id");
	}

	unless ($self->name() =~ /^.{1,10}$/ ) {
		push(@{$self->_errors()}, "validation error: name");
	}

	unless (grep {$self->color() eq $_} @VALID_COLORS) {
		push(@{$self->_errors()}, "validation error: color");
	}

	if (!scalar(@{$self->_errors()})) {
		my $values;
		for my $accessor (@accessors) {
			$values .= $self->$accessor;
		}
		$self->{_check_code} = md5_hex($values);
	}
	return $self;
}

sub has_error {
	my $self = shift;	
	return scalar(@{$self->{_errors}});
}

1;
