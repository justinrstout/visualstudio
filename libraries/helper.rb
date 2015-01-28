require 'Win32API'

module VisualStudio
  module Helper
    @@key = {
      '9.0' => {
        'professional' => 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\9.0\PRO\1033'
      },
      '10.0' => {
        'premium' => 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\10.0\vstdcore\1033'
      },
      '11.0' => {
        'premium' => 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\DevDiv\vs\Servicing\11.0\premium\1033'
      }
    }
    
    def is_vs_installed?(version, edition)
      value = { name: 'Install', type: :dword, data: 1 }
      registry_key_exists?(@@key[version][edition]) and
      registry_value_exists?(@@key[version][edition], value) and
      registry_data_exists?(@@key[version][edition], value)
    end
    
    def is_vs_sp_installed?(version, edition)
      value = { name: 'SP', type: :dword, data: 1 }
      registry_key_exists?(@@key[version][edition]) and
      registry_value_exists?(@@key[version][edition], value) and
      registry_data_exists?(@@key[version][edition], value)
    end
  end
end
