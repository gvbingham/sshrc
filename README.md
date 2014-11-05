sshrc
=====

For use with ssh to copy all files wanted into a new environment

Setup
=====

1. Run the following to find your terminal's path location: ```echo $PATH```.
2. From that list (they will be separated by ":"), choose one of the paths.
3. Copy the ```sshrc``` file to your chosen path.
4. Add to the end of your ```.bashrc``` file (whether you use bash or not):
```
if echo "$-" | grep i > /dev/null; then
    exec zsh;
fi
```

Usage
=====

When connecting to a server for the first time, use ```sshrc``` instead of ```ssh```.
e.g. ```sshrc user@domain.com```.

After you connect initially with ```sshrc```, you can continue as normal to use ```ssh``` to connect to your servers.

If you have made a change to your ```.vimrc```, ```.bashrc```, ```.zshrc```, etc. you can run ```sshrc``` again as a way to update your servers with the new settings.
