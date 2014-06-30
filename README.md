# VisualStudio Cookbook
This Chef cookbook installs Visual Studio and related products.

# Requirements

This cookbook requires 7-zip to be installed so it can extract the ISO. To ensure this happens this cookbook includes the [seven_zip](https://github.com/daptiv/seven_zip) default recipe.

For Windows7 SP1 and Windows Server 2008 SP1 you must first install [KB2664825](http://support.microsoft.com/kb/2664825), otherwise the VS installer will reboot in the middle of the installation. To avoid this it is recommended that you first install [SQL CE 4](http://www.microsoft.com/en-us/download/details.aspx?id=17876). You can install SQL CE 4 via Chef using the [sqlce cookbook](http://community.opscode.com/cookbooks/sqlce).

Windows 7
Windows 2008

# Usage
Obtain the ISOs for the versions of Visual Studio you want to install, and set `node['visualstudio']['source']` as explained below.

# Attributes

## Required
* `node['visualstudio']['source']` - Path to folder that contains the Visual Studio ISOs. Can be a local path or a URL.

## Optional
* `node['visualstudio']['90']['edition']`
* `node['visualstudio']['100']['edition']` - The editions of Visual Studio to install. Currently only 2008 Professional and 2010 Premium are supported.

# Recipes

## install_vs100
Installs Visual Studio 10.0 (2010)

## install_vs100sp1
Installs Visual Studio 10.0 Service Pack 1

## install_vs90
Installs Visual Studio 9.0 (2008)

## install_vs90sp1
Installs Visual Studio 9.0 Service Pack 1

## install_tfpt
Installs TFS 2010 Power Tools

# Author
Original author: Shawn Neal (sneal@daptiv.com)

Extended for Visual Studio 2008 and 2010 by: Justin R. Stout (justinrstout@justinrstout.com)
