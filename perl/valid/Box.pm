package Box;
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);;
use Carp 'croak';

use base ("Class::Accessor");

__PACKAGE__->mk_accessors(qw/items/);

sub new {
	my $class = shift;
	my $self = +{
		items => +[]
	};
	return bless($self, $class);
}

sub add_item {
	my $self = shift;
	my $item = shift;

	if (!$item->isa("Item")) {
		die("the item is not instance of Item: ". $!);
	}

	$item->validate();
	if (!_check_sum($item)) {
		die("the item is not valid: " . $!);
	}

	push(@{$self->items()}, $item);
	return scalar(@{$self->{items}});
}

sub print_item {
	my $self = shift;
	
	for my $item (@{$self->{items}}) {
		printf("[id: %s, name: %s, color: %s]\n",
			$item->id(), $item->name(), $item->color()
		);
	}
}

sub _check_sum {
	my $item = shift;
	my $md5_sum = md5_hex(
		$item->id() . $item->name() . $item->color()
	);

	if (!defined($item->_check_code()) || $md5_sum ne $item->_check_code()) {
		return 0;
	}

	return 1;
}

1;
