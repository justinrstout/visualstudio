::Chef::Recipe.send(:include, VisualStudio::Helper)

include_recipe 'seven_zip'

vs90sp1_is_installed = is_vs_sp_installed?('9.0', node['visualstudio']['9.0']['edition'])

install_url = win_friendly_path(File.join(node['visualstudio']['source'], node['visualstudio']['9.0']['sp1']['filename']))
install_log_file = win_friendly_path(File.join(node['visualstudio']['log_dir'], 'vs90sp1install.log'))
iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'visualstudio90sp1'))
setup_exe_path = win_friendly_path(File.join(iso_extraction_dir, node['visualstudio']['9.0']['sp1']['installer_file']))

seven_zip_archive 'extract_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio']['9.0']['sp1']['checksum']
  not_if { vs90sp1_is_installed }
end

windows_package node['visualstudio']['9.0']['sp1']['package_name'] do
  source setup_exe_path
  installer_type :custom
  options "/q /norestart /Log \"#{install_log_file}\""
  timeout 3600 # 1 hour
  not_if { vs90sp1_is_installed }
end