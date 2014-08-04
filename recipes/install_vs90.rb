::Chef::Recipe.send(:include, VisualStudio::Helper)

include_recipe 'seven_zip'

edition = node['visualstudio']['9.0']['edition']

vs90_is_installed = is_vs_installed?('9.0', edition)

install_url = win_friendly_path(File.join(node['visualstudio']['source'], node['visualstudio']['9.0'][edition]['filename']))
install_log_file = win_friendly_path(File.join(node['visualstudio']['9.0']['install_dir'], 'vsinstall.log'))
iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'visualstudio90'))
setup_exe_path = win_friendly_path(File.join(iso_extraction_dir, node['visualstudio']['9.0'][edition]['installer_file']))

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

windows_package node['visualstudio']['9.0'][edition]['package_name'] do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /unattendfile \"#{ini_path}\""
  timeout 3600 # 1 hour
  not_if { vs90_is_installed }
end
