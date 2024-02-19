<#
    script administracion servicios 1º usando comandos powershell, 2º usando comandos wmic
        
        ADMINISTRACION SERVICIOS
        ========================
        1.- Listar servicios por estado <----- pedir estado servicio(running,stopped,...) y mostrar servicios de ese estado
        2.- Mostrar detalles de servicio <---- pedir el nombre del servicio y mostrar: Nombre, Estado, Dependencias
        3.- Parar Servicio <------------------ pedir el nombre del servicio y pararlo (comprobar si esta parado)
        4.- Arrancar Servicio <--------------- pedir el nombre del servicio y arrancarlo (comprobar si esta arrancado)
        5.- Crear servicio <------------------ pedir: nombre, ejecutable del servicio, forma de arrancar 
        6.- Borrar servicio <----------------- pedir nombre servicio a borrar (comprobar q existe el servicio)
        7. ----SALIR----
        Opcion:_

#>

do
{
    clear-host
    write-host -BackgroundColor Red -ForegroundColor Yellow "`t`t ADMINISTRACION SERVICIOS"
    write-host -BackgroundColor Red -ForegroundColor Yellow "`t`t ========================"
    write-host "`t`t 1.- Listar servicios por estado"
    write-host "`t`t 2.- Mostrar detalles servicio"
    write-host "`t`t 3.- Parar servicio"
    write-host "`t`t 4.- Arrancar servicio"
    write-host "`t`t 5.- Crear servicio"
    write-host "`t`t 6.- Borrar servicio"
    write-host "`t`t 7.- ----SALIR----"
    [int]$opcion=read-host "`t`t`tOpcion_"
    
    switch($opcion){
        1{
        # ...el estado de un servicio pertenece a: System.ServiceProcess.ServiceControllerStatus
            write-host "valores posibles...."
            [System.Enum]::GetValues([System.ServiceProcess.ServiceControllerStatus])

            [string]$estado=read-host "estado de los servicios q quieres filtrar_"
            get-service | Where-Object { $_.Status -eq $estado }
        }
        2{}
        3{}
        4{}
        5{}
        6{}               
    }
    Start-Sleep -Seconds 5

} while($opcion -ne 7)






