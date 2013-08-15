#!/usr/bin/perl
use strict;
use warnings;
use Box;
use Item;
use Data::Dumper;


#item 1 is valid
my $item1 = Item->new(+{
	id => 1, name => "item 1", color => "blue"
});

#item 2 is valid
my $item2 = Item->new(+{
	id => 2, name => "item 2", color => "red"
});

#item 3 is invalid color
my $item3 = Item->new(+{
	id => 3, name => "item 3", color => "yellow"
});	

#set invalid color.
$item3->color("black");

# Box

eval {
	my $box = Box->new();

	$box->add_item($item1);
	$box->add_item($item2);
	$box->add_item($item3);

	print "::: Item list :::\n";
	$box->print_item();
};

if ($@) { 
	print STDERR $@, "\n"; 
}

