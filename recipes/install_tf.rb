execute "setx PATH \"%PATH%;#{node['visualstudio']['10.0']['install_dir']}\\Common7\\IDE\" /M" do
  not_if 'where tf'
end