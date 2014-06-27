::Chef::Recipe.send(:include, Visualstudio::Helper)

include_recipe 'seven_zip'

vs100_is_installed = is_vs100_installed?()

edition = node['visualstudio']['100']['edition']
install_url = File.join(node['visualstudio']['source'], node['visualstudio']['100'][edition]['filename'])
install_log_file = win_friendly_path(File.join(node['visualstudio']['100']['install_dir'], 'vsinstall.log'))

iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'visualstudio'))
setup_exe_path = File.join(iso_extraction_dir, node['visualstudio']['100'][edition]['installer_file'])

ini_path = File.join(Chef::Config[:file_cache_path], 'vs100_premium.ini')
  
cookbook_file 'vs100_premium.ini' do
  path ini_path
end

seven_zip_archive 'extract_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio']['100'][edition]['checksum']
  not_if { vs100_is_installed }
end

windows_package node['visualstudio']['100'][edition]['package_name'] do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /unattendfile \"#{ini_path}\""
  notifies :delete, "directory[#{iso_extraction_dir}]"
  timeout 3600 # 1hour
  not_if { vs100_is_installed }
end

directory iso_extraction_dir do
  action :nothing
  recursive true
  not_if { node['visualstudio']['preserve_extracted_files'] }
end
