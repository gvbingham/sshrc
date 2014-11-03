#!perl

=pod 
=head1 Usage
Best practice is to have the following text already in your local .bashrc

if echo "$-" | grep i > /dev/null; then
   exec zsh;
fi

Modify the config object to include each file you want sent to the remote server.
=cut

use strict;
use warnings;

my $config = {
    local_locations => [
        '~/.vimrc',         
        '~/.vim',
        '~/.oh-my-zsh',
        '~/.zshrc',
        '~/.bashrc',
    ],
};

# get the full ARGV as one single string for easier regexing
my $ssh_string = 'ssh ' . join(' ', @ARGV);
#print "\nmy ssh_string = $ssh_string\n";

# get user and hostname together like user@hostname
my $userhost = $ARGV[-1];
#print "\nmy userhost = $userhost\n";

# get list of files in one space seperated string
my $files_string = '';
foreach my $item (@{$config->{'local_locations'}}) {
    $files_string .= $item . ' ';
}

# get port string if port even exists
my $port_string;
my $port = $1 if $ssh_string =~ /p\s*(\d*)/;
$port_string = ($port) ? "--port=$port" : "";
#print "\nport string = $port_string\n";

# do the secure copy
print "\ncopying your configuration files; depending upon connection this may be a few moments";
print "\nrunning the following command... rsync -rpzq --progress $port_string $files_string ${userhost}:~/";
`rsync -rpz --progress $port_string $files_string ${userhost}:~/`;
