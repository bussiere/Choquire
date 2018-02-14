function Choquire {
    
    # TODO: Add switch param for cache update
    # TODO: Add switch param for specific package version
    # TODO: Add switch param / configuration for silent mode (no "Write-Output"s)
    # TODO: Add switch param / configuration to skip ChocoCheck
    # TODO: Set environment variable for cache location
    # TODO: Add configuration file
    # TODO: Set environment variable for configuration file location
    # TODO: Exit if not elevated

    ChocoCheck;

    foreach($package in $args) {     

        # TODO: Check cache and break if package found

        if (-Not (PackageCheck -package $package)) {
            AlertNotInstalled -package $package;
            InstallPackage -package $package;
            RefreshEnvironment;
            # TODO: Append package to cache file
        }
        else {
            AlertInstalled -package $package;
            # TODO: Append package to cache file if it isn't there
        }
    }
}

function RefreshEnvironment {
    RefreshEnv.cmd | out-null;
}

function UpdateCache {
    ListPackages | ForEach-Object  { 
        # TODO: Write to cache file
    }
}

function InstallPackage {
    # TODO: pipe to out-null if silent flag was used
    param ($package);
    cinst.exe $package -y;
}

function ListPackages {
    return clist.exe -l -r;
}

function SearchPackage {
    param ($package);
    return clist.exe -l -r $package;
}


function CacheCheck {
    param ($package);
    # TODO:
    #   Create cache file if doesn't exist
    #   If exists, read file line by line and return true if the package maches
    #   Finally, return false if no package mached
}

function PackageCheck {
    param ($package);
    SearchPackage -package $package | ForEach-Object { 
        $packageInfo = $_.Split('|');

        $packageName    = $packageInfo[0];
        $packageVersion = $packageInfo[1];

        # TODO: Allow checking for specific package versions
        if($packageName.ToLower() -eq $package.ToLower()) {
            return $true;
        }
    }
    return $false;
}

function ChocoCheck {
    # TODO: skip if skip choco check flag / configuration was used
    if (-Not (TestCommand -command "cinst")){
        AlertNotInstalled -package "Chocolatey";
        InstallChoco;
        RefreshEnvironment;
    } 
    else {
        AlertInstalled -package "Chocolatey";
    }
}

function InstallChoco {
    # TODO: pipe to out-null if silent flag was used
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
    Set-Variable "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin";
}

function TestCommand {
    param ($command);
    return [bool](Get-Command -Name $command -ErrorAction SilentlyContinue);
}

function AlertNotInstalled {
    # TODO: return if silent flag / configuration was used
    param ($package);
    Write-Output "$package is not installed, installing now.";
}

function AlertInstalled {
    # TODO: return if silent flag / configuration was used
    param ($package);
    Write-Output "$package is installed.";
}

export-modulemember -function Choquire;