::Chef::Recipe.send(:include, VisualStudio::Helper)
require 'chef/win32/version'

include_recipe 'seven_zip'

v = Chef::ReservedNames::Win32::Version.new

edition = node['visualstudio']['10.0']['edition']
  
vs100_is_installed = is_vs_installed?('10.0', edition)

install_url = win_friendly_path(File.join(node['visualstudio']['source'], node['visualstudio']['10.0'][edition]['filename']))
install_log_file = win_friendly_path(File.join(node['visualstudio']['log_dir'], 'vs100install.log'))
iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'visualstudio100'))
setup_exe_path = win_friendly_path(File.join(iso_extraction_dir, node['visualstudio']['10.0'][edition]['installer_file']))

ini_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'vs100_install.ini'))

ini_file = if v.windows_7?
  "vs100_premium.ini"
elsif v.windows_8? or v.windows_8_1? or v.windows_server_2012? or v.windows_server_2012_r2?
  "vs100_premium_8.ini"
end

cookbook_file ini_file do
  path ini_path
  only_if { edition == 'premium' }
end

seven_zip_archive 'extract_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio']['10.0'][edition]['checksum']
  not_if { vs100_is_installed }
end

windows_package node['visualstudio']['10.0'][edition]['package_name'] do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /unattendfile \"#{ini_path}\""
  timeout 3600 # 1 hour
  not_if { vs100_is_installed }
end
