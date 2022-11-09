# NAME

Experian::IDAuth - Experian's ID Authenticate service

# DESCRIPTION

This module provides an interface to Experian's Identity Authenticate service.
[http://www.experian.co.uk/identity-and-fraud/products/authenticate.html](http://www.experian.co.uk/identity-and-fraud/products/authenticate.html)

First create a subclass of this module to override the defaults method
with your own data.

    package My::Experian;
    use strict;
    use warnings;
    use base 'Experian::IDAuth';

    sub defaults {
        my $self = shift;

        return (
            $self->SUPER::defaults,
            username      => 'my_user',
            password      => 'my_pass',
            residence     => $residence,
            postcode      => $postcode || '',
            date_of_birth => $date_of_birth || '',
            first_name    => $first_name || '',
            last_name     => $last_name || '',
            phone         => $phone || '',
            email         => $email || '',
        );
    }

    1;

Then use this module.

    use My::Experian;

    # search_option can either be ProveID_KYC or CheckID
    my $prove_id = My::Experian->new(
        search_option => 'ProveID_KYC',
    );

    my $prove_id_result = $prove_id->get_result();

    if (!$prove_id->has_done_request) {
        # connection problems
        die;
    }

    if ($prove_id_result->{deceased} || $prove_id_result->{fraud}) {
        # client flagged as deceased or fraud
    }
    if ($prove_id_result->{deny}) {
        # client on any of PEP, OFAC, or BOE list
        # you can check $prove_id_result->{PEP} etc if you want more detail
    }
    if ($prove_id_result->{fully_authenticated}) {
        # client successfully authenticated,
        # DOES NOT MEAN NO CONCERNS

        # check number of credit verifications done
        print "Number of credit verifications: " . $prove_id_result->{num_verifications} . "\n";
    }

    # CheckID is a more simpler version and can be used if ProveID_KYC fails
    my $check_id = My::Experian->new(
        search_option => 'CheckID',
    );

    if (!$check_id->has_done_request) {
        # connection problems
        die;
    }

    if ($check_id->get_result()) {
        # client successfully authenticated
    }

# METHODS

## new()

    Creates a new object of your derived class. The parent class should contain most of the attributes required for new(). But you can set search_option to either ProveID_KYC or CheckID

## get\_result()

    Return the Experian results as a hashref

## save\_pdf\_result()

    Save the Experian credentials as a PDF

## defaults()

    Return default value

## get\_192\_xml\_report()

    Return 192 xml report

## has\_done\_request()

    Check the request finished or not

## has\_downloaded\_pdf

    Check the file is downloaded an is a pdf file

## set

    set attributes of object

## valid\_country

    Check a country is valid

# AUTHOR

binary.com, `perl at binary.com`

# BUGS

Please report any bugs or feature requests to `bug-experian-idauth at rt.cpan.org`,
or through the web interface at
[http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Experian-IDAuth](http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Experian-IDAuth).
We will be notified, and then you'll automatically be notified of progress
on your bug as we make changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Experian::IDAuth

You can also look for information at:

- RT: CPAN's request tracker (report bugs here)

    [http://rt.cpan.org/NoAuth/Bugs.html?Dist=Experian-IDAuth](http://rt.cpan.org/NoAuth/Bugs.html?Dist=Experian-IDAuth)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/Experian-IDAuth](http://annocpan.org/dist/Experian-IDAuth)

- CPAN Ratings

    [http://cpanratings.perl.org/d/Experian-IDAuth](http://cpanratings.perl.org/d/Experian-IDAuth)

- Search CPAN

    [http://search.cpan.org/dist/Experian-IDAuth/](http://search.cpan.org/dist/Experian-IDAuth/)

# DEPENDENCIES

    Locale::Country
    Path::Tiny
    WWW::Mechanize
    XML::Simple
    XML::Twig
    SOAP::Lite
    IO::Socket
    File::MimeInfo::Magic
    Syntax::Keyword::Try
