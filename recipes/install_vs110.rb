::Chef::Recipe.send(:include, VisualStudio::Helper)

include_recipe 'seven_zip'

edition = node['visualstudio']['11.0']['edition']
  
vs110_is_installed = is_vs_installed?('11.0', edition)

install_url = win_friendly_path(File.join(node['visualstudio']['source'], node['visualstudio']['11.0'][edition]['filename']))
install_log_file = win_friendly_path(File.join(node['visualstudio']['log_dir'], 'vs110install.log'))
iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'visualstudio110'))
setup_exe_path = win_friendly_path(File.join(iso_extraction_dir, node['visualstudio']['11.0'][edition]['installer_file']))

xml_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'vs110_admindeployment.xwl'))
  
cookbook_file 'vs110_admindeployment.xml' do
  path xml_path
  only_if { edition == 'premium' }
end

seven_zip_archive 'extract_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio']['11.0'][edition]['checksum']
  not_if { vs110_is_installed }
end

windows_package node['visualstudio']['11.0'][edition]['package_name'] do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /AdminFile \"#{xml_path}\""
  timeout 3600 # 1 hour
  not_if { vs110_is_installed }
end
