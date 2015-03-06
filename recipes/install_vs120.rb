::Chef::Recipe.send(:include, VisualStudio::Helper)

include_recipe 'seven_zip'

edition = node['visualstudio']['12.0']['edition']
  
vs120_is_installed = is_vs_installed?('12.0', edition)

install_url = win_friendly_path(File.join(node['visualstudio']['source'], node['visualstudio']['12.0'][edition]['filename']))
install_log_file = win_friendly_path(File.join(node['visualstudio']['log_dir'], 'vs120install.log'))
iso_extraction_dir = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'visualstudio120'))
setup_exe_path = win_friendly_path(File.join(iso_extraction_dir, node['visualstudio']['12.0'][edition]['installer_file']))

xml_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'vs120_admindeployment.xml'))
  
cookbook_file 'vs120_admindeployment.xml' do
  path xml_path
  only_if { edition == 'premium' }
end

seven_zip_archive 'extract_iso' do
  path iso_extraction_dir
  source install_url
  overwrite true
  checksum node['visualstudio']['12.0'][edition]['checksum']
  not_if { vs120_is_installed }
end

# Workaround for https://github.com/chef/knife-windows/issues/172
ruby_block 'keep alive' do
  block do
    Thread.new {
      counter = 0
      while counter < 60
        Chef::Log.info("keep alive")
        sleep 60
        counter += 1
      end
    }
  end
end

windows_package node['visualstudio']['12.0'][edition]['package_name'] do
  source setup_exe_path
  installer_type :custom
  options "/Q /norestart /Log \"#{install_log_file}\" /AdminFile \"#{xml_path}\""
  timeout 4000 # 1 hour and change
  not_if { vs120_is_installed }
end
