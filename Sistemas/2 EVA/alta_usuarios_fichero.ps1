clear-host

$fichero="$env:HOMEPATH\Documents\scripts\USUARIOS_NUEVOS.txt"

Get-Content -Path $fichero | ForEach-Object {

                                [string[]]$campos=([string]$_).Split(":");

                                # ¿¿ es una linea para dar de alta un grupo o un usuario ??

                                if( ([string]$_).Contains("GRUPO"))
                                {
                                    $grupo=([string]$campos[1]).Replace(" ","")
                                    New-LocalGroup -name $grupo

                                    $sidgrupo=(Get-LocalGroup -Name $grupo).SID
                                    write-host "Grupo: $grupo ... dado de alta correctamente, con SID: $sidgrupo" 
                                    

                                } else {
                                    $pass=ConvertTo-SecureString "$campos[2]" -AsPlainText -Force
                                    $user=([string]$campos[1]).Replace(" ","")

                                    New-LocalUser -Name $user `
                                                  -Description "$campos[4]" `
                                                  -Password $pass
                                    
                                    $siduser=(Get-LocalUser -Name $user).SID
                                    Add-LocalGroupMember -Group $grupo -Member $user
                                    write-host "Usuario: $user...dado de alta correctamente, en grupo: $grupo, con SID: $siduser" 

                                }

    }