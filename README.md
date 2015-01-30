# VisualStudio Cookbook
This Chef cookbook installs Visual Studio and related products.

# Requirements

This cookbook requires 7-zip to be installed so it can extract the ISO. To ensure this happens this cookbook includes the [seven_zip](https://github.com/daptiv/seven_zip) default recipe.

For Windows7 SP1 and Windows Server 2008 SP1 you must first install [KB2664825](http://support.microsoft.com/kb/2664825), otherwise the VS installer will reboot in the middle of the installation. To avoid this it is recommended that you first install [SQL CE 4](http://www.microsoft.com/en-us/download/details.aspx?id=17876). You can install SQL CE 4 via Chef using the [sqlce cookbook](http://community.opscode.com/cookbooks/sqlce).

# Platforms

Windows 7
Windows Server 2008
Windows 8
Windows Server 2012

Using the 2008 and 2010 recipes on other versions of Windows may require generating a new unattended .ini file. See https://msdn.microsoft.com/en-us/library/ee225237(v=vs.100).aspx

# Usage
Obtain the ISOs for the versions of Visual Studio you want to install, and set `node['visualstudio']['source']` as explained below.

# Attributes

## Required
* `node['visualstudio']['source']` - Path to folder that contains the Visual Studio ISOs. Can be a local path or a URL.

## Optional
* `node['visualstudio']['9.0']['edition']`
* `node['visualstudio']['10.0']['edition']` 
* `node['visualstudio']['11.0']['edition']`
* `node['visualstudio']['12.0']['edition']`  - The editions of Visual Studio to install. Currently only 2008 Professional, 2010 Premium, 2012 Premium, and 2013 Premium are supported.

# Recipes

## install_vs120
Installs Visual Studio 12.0 (2013)

## install_vs110
Installs Visual Studio 11.0 (2012)

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
