# VisualStudio Cookbook
This Chef cookbook installs Visual Studio and related products.

# Requirements

This cookbook requires 7-zip to be installed so it can extract the ISO. To ensure this happens this cookbook includes the [seven_zip](https://github.com/daptiv/seven_zip) default recipe.

For Windows7 SP1 and Windows Server 2008 SP1 you must first install [KB2664825](http://support.microsoft.com/kb/2664825), otherwise the VS installer will reboot in the middle of the installation. To avoid this it is recommended that you first install [SQL CE 4](http://www.microsoft.com/en-us/download/details.aspx?id=17876). You can install SQL CE 4 via Chef using the [sqlce cookbook](http://community.opscode.com/cookbooks/sqlce).

Windows 7
Windows 2008

# Attributes

## Required
* `node['visualstudio']['source']` - Path to folder that contains the Visual Studio ISOs. Can be a local path or a URL.

## Optional
* `node['visualstudio']['enable_nuget_package_restore']` - true or false. Sets the system wide environment variable to enable MSBuild/VisualStudio package restore on build. This defaults to true.
* `node['visualstudio']['90']['edition']`
* `node['visualstudio']['100']['edition']` - The editions of Visual Studio to install. Currently only 2008 Professional and 2010 Premium are supported.

# Recipes

## default
Ensures all VisualStudio prereqs are installed first and then only runs the install recipe if they are met. You should add this recipe to your run list.

## install
Installs VisualStudio 2012 using the included AdminDeployment.xml. Ensures 7-zip is installed so the ISO can be extracted via the seven_zip cookbook. Included by the default recipe.

## nuget
Configures the enable_nuget_package_restore environment variable. Included by the default recipe.

## dotnet_prereq
Logs a warning if .NET 4.5 is not installed. This is included in the default recipe.

# Optional Recipes

## install_update
Installs VS 2012 SP4 from the VS2012.4.iso. Add this to your runlist to update to the latest VS2012 SP. By default you must place the iso in the same folder as the VS 2012 iso.

## install_updateweb
Same as above but it uses the web downloader.

## install_vsto
Installs the Microsoft Office Developer Tools for VS2012. Add this to your runlist if you need Office development tools for Office plugin development.

# Author
Original author: Shawn Neal (sneal@daptiv.com)

Extended for Visual Studio 2008 and 2010 by: Justin R. Stout (justinrstout@justinrstout.com)
