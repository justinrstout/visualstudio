module Visualstudio
  module Helper
    def is_vs90_installed?()
      key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\9.0\IDE\1033'
      value = { name: 'Install', type: :dword, data: 1 }
      registry_key_exists?(key) and
      registry_value_exists?(key, value) and
      registry_data_exists?(key, value)
    end
    
    def is_vs90sp1_installed?()
      key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\9.0\IDE\1033'
      value = { name: 'SP', type: :dword, data: 1 }
      registry_key_exists?(key) and
      registry_value_exists?(key, value) and
      registry_data_exists?(key, value)
    end
    
    def is_vs100_installed?()
      key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\10.0\vstdcore\1033'
      value = { name: 'Install', type: :dword, data: 1 }
      registry_key_exists?(key) and
      registry_value_exists?(key, value) and
      registry_data_exists?(key, value)
    end
    
    def is_vs100sp1_installed?()
      key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\10.0\vstdcore\1033'
      value = { name: 'SP', type: :dword, data: 1 }
      registry_key_exists?(key) and
      registry_value_exists?(key, value) and
      registry_data_exists?(key, value)
    end
  end
end
