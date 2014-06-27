::Chef::Recipe.send(:include, Visualstudio::Helper)

include_recipe 'seven_zip'

vs90sp1_is_installed = is_vs90sp1_installed?()

install_url = File.join(node['visualstudio']['source'], node['visualstudio']['90']['sp1']['filename'])
install_log_file = win_friendly_path(File.join(node['visualstudio']['90']['install_dir'], 'vsinstall.log'))

iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'visualstudio'))
setup_exe_path = File.join(iso_extraction_dir, node['visualstudio']['90']['sp1']['installer_file'])

seven_zip_archive 'extract_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio']['90']['sp1']['checksum']
  not_if { vs90sp1_is_installed }
end

windows_package node['visualstudio']['90']['sp1']['package_name'] do
  source setup_exe_path
  installer_type :custom
  options "/q /norestart /Log \"#{install_log_file}\""
  notifies :delete, "directory[#{iso_extraction_dir}]"
  timeout 3600 # 1hour
  not_if { vs90sp1_is_installed }
end

directory iso_extraction_dir do
  action :nothing
  recursive true
  not_if { node['visualstudio']['preserve_extracted_files'] }
end
