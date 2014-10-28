#!perl

use strict;
use warnings;

my $config = {
    local_locations => [
        '~/.vimrc',         
        '~/.vim',
        '~/.oh-my-zsh',
    ],
};

my $sshrc_string = '[-z "$PS1"] && return\nexec zsh;';
my $port = $1 if $ARGV =~ /p\s*(\d*)/;
my $at_symbol_index = index($ARGV[-1], '@') ;
my $userhost = $ARGV[-1];

if ($at_symbol_index != -1) {
    #$hostname = substr($userhost, $at_symbol_index + 1); 
    #$username = $1 if $userhost =~ /(\w*)@/;
    foreach my $item ($config->{'local_locations'}) {
        print @{$item};
        #if (-d $item) {
            #add port in scp
            `scp -r @{$item} ${userhost}:~/`
        #}
    }
}
else {
    print 'didn\'t make it';
    $hostname = $ARGV[-1];
}

# send files to remote;
# put together an ssh string; 
## first ssh
## with perliminary arguments
## user@hostNAME;
