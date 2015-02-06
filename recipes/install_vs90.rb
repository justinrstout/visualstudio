::Chef::Recipe.send(:include, VisualStudio::Helper)

include_recipe 'seven_zip'

edition = node['visualstudio']['9.0']['edition']

vs90_is_installed = is_vs_installed?('9.0', edition)

install_url = win_friendly_path(File.join(node['visualstudio']['source'], node['visualstudio']['9.0'][edition]['filename']))
install_log_file = win_friendly_path(File.join(node['visualstudio']['log_dir'], 'vs90install.log'))
iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'visualstudio90'))

ini_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'vs90_install.ini'))
  
cookbook_file 'vs90_professional_x64_nosqlserver.ini' do
  path ini_path
  only_if { edition == 'professional' }
end

seven_zip_archive 'extract_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio']['9.0'][edition]['checksum']
  not_if { vs90_is_installed }
end

vs_bsln_path = win_friendly_path(File.join(iso_extraction_dir, 'WCU\64bitPrereq\x64\vs_bsln.exe'))
windows_package 'Visual Studio .NET Prerequisites - English' do
  source vs_bsln_path
  installer_type :custom
  options '/Q USING_EXUIH=1'
  not_if { vs90_is_installed }
end

dexplore_path = win_friendly_path(File.join(iso_extraction_dir, 'WCU\DExplore\DExplore.exe'))
windows_package 'Microsoft Document Explorer 2008' do
  source dexplore_path
  installer_type :custom
  options '/q'
  not_if { vs90_is_installed }
end

web_designer_core_path = win_friendly_path(File.join(iso_extraction_dir, 'WCU\WebDesignerCore\WebDesignerCore.EXE'))
windows_package 'Microsoft Visual Studio Web Authoring Component' do
  source web_designer_core_path
  installer_type :custom
  options '/Q /install'
  not_if { vs90_is_installed }
end

setup_path = win_friendly_path(File.join(iso_extraction_dir, 'Setup\setup.exe'))
windows_package node['visualstudio']['9.0'][edition]['package_name'] do
  source setup_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /unattendfile \"#{ini_path}\""
  timeout 3600 # 1 hour
  not_if { vs90_is_installed }
end
