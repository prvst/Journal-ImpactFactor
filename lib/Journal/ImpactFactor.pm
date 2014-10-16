package Journal::ImpactFactor;

use v5.12;
use strict;
use warnings;
use Moose;
use namespace::autoclean;
use Storable;
use Journal::JournalEntry;

=head1 NAME

Journal::ImpactFactor - A list of updated scientiffic journal impact factor.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

    use Journal::ImpactFactor;

    # instantiate the journal list
    my $if = Journal::ImpactFactor->new();

    # search a jounal by name
    my $result = $if->search_by_name("Animal");
    
    # search a journal by issn
    my $resul = $if->search_by_issn('0718-7106'); 
    
    # print the impact factor for the year 2010
    say $result->year_2010;
    ...

=head1 DESCRIPTION

This module provides access to impact factor information of 1100 different scientific journals. You can access data from 2008 to 2013/2014. All data compiled here is from public domain. 

=head2 Methods

=head3 search by name

This method sreturns a JournalEntry object (see methods below).

    my $result = $if->search_by_name("name");

=head3 search by issn

This method sreturns a JournalEntry object (see methods below).

    my $resul = $if->search_by_issn("issn");

=head3 name

    say $result->name;

=head3 issn

    say $result->issn;

=head3 year_2008

    say $result->year_2008;

=head3 year_2009

    say $result->year_2009;

=head3 year_2010

    say $result->year_2010;

=head3 year_2011

    say $result->year_2011;

=head3 year_2012

    say $result->year_2012;

=head3 year_2013_2014

    say $result->year_2013_2014;

=cut

has 'journal_list' => (
    is  =>  'rw',
    isa =>  'ArrayRef[Journal::JournalEntry]',
    );


sub BUILD {
    my $self = shift;

    my $hashref = retrieve('journals') or die "[Error]: Could not find journal list";
    my %journals = %{$hashref};

    my $j;
    my @list;

    for my $key ( keys %journals ) {
        
        $j = Journal::JournalEntry->new();

        my @line = split(/\t/, $journals{$key});
        
        $j->name($line[0]) if defined ($line[0]);        
        $j->issn($line[1]) if defined ($line[1]);
        $j->year_2008($line[2]) if defined ($line[2]);
        $j->year_2009($line[3]) if defined ($line[3]);
        $j->year_2010($line[4]) if defined ($line[4]);
        $j->year_2011($line[5]) if defined ($line[5]);
        $j->year_2012($line[6]) if defined ($line[6]);
        $j->year_2013_2014($line[7]) if defined ($line[7]);

        push(@list, $j);
    }

    $self->journal_list(\@list);
}

sub search_by_name {
    my $self = shift;
    my $name = shift;

    my @list = @{$self->journal_list};

    my $result;

    for my $j ( @list ) {

        if ( $j->name =~ m/^$name$/ig ) {
            
            $result = $j;
        }
    }

    if ($result) {
        
        return $result;

    } else {
        
        say "Journal not found";
        return undef;

    }

}


sub search_by_issn {
    my $self = shift;
    my $issn = shift;

    my @list = @{$self->journal_list};

    my $result;

    for my $j ( @list ) {

        if ( $j->issn =~ m/^$issn$/ig ) {
            
            $result = $j;
        }
    }

    if ($result) {
        
        return $result;

    } else {
        
        say "Journal not found";
        return undef;

    }

}




=head1 AUTHOR

Felipe da Veiga Leprevost, C<< <leprevost at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-journal-impactfactor at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Journal-ImpactFactor>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Journal::ImpactFactor


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Journal-ImpactFactor>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Journal-ImpactFactor>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Journal-ImpactFactor>

=item * Search CPAN

L<http://search.cpan.org/dist/Journal-ImpactFactor/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Felipe da Veiga Leprevost.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Journal::ImpactFactor
