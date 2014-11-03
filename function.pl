#!perl

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
$port_string = ($port) ? "P $port" : "";
#print "\nport string = $port_string\n";

# do the secure copy
print "\ncopying your configuration files; depending upon connection this may be a few moments\n";
print "\nrunning the following command... scp -r$port_string $files_string ${userhost}:~/\n";
`sudo scp -r$port_string $files_string ${userhost}:~/`;

# Depricated
# get string to append to .bashrc 
# my $bashrc_string = '[-z "$PS1"] && return\nexec zsh;';
# return @ARGV; Need to ssh in perl if perl allows me to continue on in ssh without the perl script anymore
#my $bashrc_string = 'case "$-" in\n*i*) exec zsh ;;\n*) echo "" ;;\nesac';
# print "\nappending a configuration line to your .bashrc file";
#`$ssh_string if grep "\$-" ~/.bashrc then print "all good in da hood" else echo "$bashrc_string" >> ~/.bashrc fi`;
#`$ssh_string if grep "\$-" ~/.bashrc then print "all good in da hood" else printf '%s\n' 'case "$-" in' '*i*) exec zsh ;;' '*) echo "" ;;' 'esac" >> ~/.bashrc fi'`;
