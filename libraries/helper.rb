module Visualstudio
  module Helper
    def is_vs90_installed?()
      key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\9.0\PRO\1033'
      registry_key_exists?(key) and
      registry_value_exists?(key, { name: 'Install', type: :dword, data: 1 })
    end
    
    def is_vs90sp1_installed?()
      key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\9.0\PRO\1033'
      registry_key_exists?(key) and
      registry_value_exists?(key, { name: 'SP', type: :dword, data: 1 })
    end
    
    def is_vs100_installed?()
      key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\10.0\vstdcore\1033'
      registry_key_exists?(key) and
      registry_value_exists?(key, { name: 'Install', type: :dword, data: 1 })
    end

    def is_vs_installed?()
      File.exists?(File.join(node['visualstudio']['install_dir'], '\Common7\IDE\devenv.exe'))
    end

    def is_sp_installed?()
      registry_key_exists?(node['visualstudio']['update']['package_regkey'])
    end

    def is_vsto_installed?()
      registry_key_exists?(node['visualstudio']['vsto']['package_regkey'])
    end

  end
end
