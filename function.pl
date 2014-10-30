#!perl

use strict;
use warnings;

my $config = {
    local_locations => [
        '~/.vimrc',         
        '~/.vim',
        '~/.oh-my-zsh',
        '~/.zshrc',
    ],
};

# get the full ARGV as one single string for easier regexing
my $ssh_string = join(' ', @ARGV);

# get user and hostname together like user@hostname
my $userhost = $ARGV[-1];

# get list of files in one space seperated string
my $files_string = '';
foreach my $item (@{$config->{'local_locations'}}) {
    $files_string .= $item . ' ';
}

# get port string if port even exists
my $port_string;
my $port = $1 if $ssh_string =~ /p\s*(\d*)/;
$port_string = ($port) ? "P $port" : "";

# do the secure copy
print "running the following command... scp -r$port_string $files_string ${userhost}:~/";
`scp -r $port_string $files_string ${userhost}:~/`;

# get string to append to .bashrc 
# my $bashrc_string = '[-z "$PS1"] && return\nexec zsh;';
# return @ARGV; Need to ssh in perl if perl allows me to continue on in ssh without the perl script anymore
my $bashrc_string = 'case "$-" in\n*i*) exec zsh ;;\n*) echo "" ;;\nesac';
print "ssh string = M $ssh_string\n";
`$ssh_string if grep "\$-" ~/.bashrc then print "all good in da hood" else echo $bashrc_string >> ~/.bashrc fi`;
# depricated?
    #my $at_symbol_index = index($ARGV[-1], '@') ;
    #$hostname = substr($userhost, $at_symbol_index + 1); 
    #$username = $1 if $userhost =~ /(\w*)@/;
