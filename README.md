# Sphe M's dotfiles & more

Introductory message
--------------------

After having *lost all* my files on my device, before, I thought it would be a great idea to have my dear files on a version control.

Intallation
-----------

Run the setup script. You can run the script without precceding variable declarations; in that case the script will prompt for the respective values interactively.

## Android (Termux) 

```
cd dotfiles

DEVICE_TYPE=android DESTINATION=$HOME ./setup-machine 
```

## Desktop

```
cd dotfiles

DEVICE_TYPE=desktop DESTINATION=$HOME ./setup-machine 
```

Don't forget to open (n)vim and run :PluginInstall!
