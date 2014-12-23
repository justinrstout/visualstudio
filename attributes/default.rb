default['visualstudio']['9.0']['edition'] = 'professional'
default['visualstudio']['10.0']['edition'] = 'premium'

default['visualstudio']['9.0']['install_dir'] = File.join((ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)'), 'Microsoft Visual Studio 9.0')
default['visualstudio']['10.0']['install_dir'] = File.join((ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)'), 'Microsoft Visual Studio 10.0')

# Set this attribute to the folder which contains the ISOs
default['visualstudio']['source'] = 'C:\VS'

# VS 2008 Professional
default['visualstudio']['9.0']['professional']['installer_file'] = 'Setup\setup.exe'
default['visualstudio']['9.0']['professional']['filename'] = 'en_visual_studio_2008_professional_x86_dvd_x14-26326.iso'
default['visualstudio']['9.0']['professional']['package_name'] = 'Microsoft Visual Studio Professional 2008'
default['visualstudio']['9.0']['professional']['checksum'] = '52ebf5731b75ccc460384ce3fd25bc984fb2d828ae51501ebaf0cadc27a33ee9'

# VS 2008 Service Pack 1
default['visualstudio']['9.0']['sp1']['installer_file'] = 'vs90sp1\SPInstaller.exe'
default['visualstudio']['9.0']['sp1']['filename'] = 'en_visual_studio_2008_service_pack_1_x86_dvd_x15-12962.iso'
default['visualstudio']['9.0']['sp1']['package_name'] = 'Microsoft Visual Studio 2008 Service Pack 1'
default['visualstudio']['9.0']['sp1']['checksum'] = '580f717269faa10cf668140ef0a1a264cec194e20a0083cb0d0004a897cc675e'
  
# VS 2010 Premium
default['visualstudio']['10.0']['premium']['installer_file'] = 'Setup\setup.exe'
default['visualstudio']['10.0']['premium']['filename'] = 'en_visual_studio_2010_premium_x86_dvd_509357.iso'
default['visualstudio']['10.0']['premium']['package_name'] = 'Microsoft Visual Studio Premium 2010'
default['visualstudio']['10.0']['premium']['checksum'] = '477f6f71b58394e1d3abf61d0ba40adf4052c6eaec9bc6340bb1386fa6119c9a'
  
# VS 2010 Service Pack 1
default['visualstudio']['10.0']['sp1']['installer_file'] = 'Setup.exe'
default['visualstudio']['10.0']['sp1']['filename'] = 'mu_visual_studio_2010_sp1_x86_dvd_651704.iso'
default['visualstudio']['10.0']['sp1']['package_name'] = 'Microsoft Visual Studio 2010 Service Pack 1'
default['visualstudio']['10.0']['sp1']['checksum'] = 'fce24f0e3f95fdeb54b806be3266f3b61a1e6b5b78c7e6c13c36fc1a6f5ba0ad'