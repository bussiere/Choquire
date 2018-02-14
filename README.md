# Choquire
A dependency manager for Powershell, using [Chocolatey](https://chocolatey.org/).

![](https://github.com/yoav-lavi/Choquire/blob/master/Choquire.png?raw=true)

Pronounced as *"chalk wire"*.

Choquire checks whether any given package is installed, Install it if it is missing, will install chocolatey if needed, and will refresh the current consoles environment variables if needed. 

All of the above reduces any dependency or program to:

```ps1
Choquire "Dependency"
```

## How to use
Create a folder called `Choquire` in `C:\Windows\System32\WindowsPowerShell\v1.0\Modules\`, put `Choquire.psm1` in the folder.

Import Choquire:

```ps1
Import-Module Choquire
```

Specify any packages you need for your script to run:

```ps1
Choquire "OpenSSH" "Sysinternals"
```

## Notes
You must call this module from an elevated script. 

I'll upload this module to Nuget or something similar in the future.

## TODO
- [ ]  Add cache file
- [ ]  Add config file
- [ ]  Add silent run
- [ ]  Add ability to request specific package versions
- [ ]  Add check for installed packages outside of Chocolatey
