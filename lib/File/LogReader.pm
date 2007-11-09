package File::LogReader;
use strict;
use warnings;
use YAML;

sub new {
    my $class = shift;
    my $self = {
        state_dir => "$ENV{HOME}/.logreader",
        @_,
    };

    die 'filename is mandatory!' unless $self->{filename};

    unless( -d $self->{state_dir} ) {
        mkdir $self->{state_dir} 
            or die "Can't make the state directory: $self->{state_dir}: $!";
    }

    bless $self, $class;
    return $self;
}

sub read_line {
    my $self = shift;

    if (!exists $self->{fh}) {
        open($self->{fh}, $self->{filename}) or die;
    }
    my $fh = $self->{fh};
    return <$fh>;
}

=head2 commit

Saves the read position of the current file.

=cut

sub commit {
    my $self = shift;
}

1;
