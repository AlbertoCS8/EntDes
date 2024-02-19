<#
 hacer script q te pida el nombre de un almacen y  muestre solo las props de abajo
   despues te tiene q preguntar si lo quieres vaciar de mensajes, si es asi vaciarlo y comprobarlo en el visor:  EventVwr.msc

						- prop. tamaño total del almacen total: 			MaximumSizeInBytes
						- prop. tamaño actual del almacen: 				FileSize
						- prop. fecha ultima modificacion (registro del ultimo evento): LastWriteTime
						- prop. numero de eventos registrados:  			RecordCount
						- prop. proveedores de eventos q mandan aqui mensajes: 		ProviderNames
						- prop. ruta donde se encuentra el almacen: 			LogFilePath

#>
clear-host
write-host -BackgroundColor Red -ForegroundColor Yellow "`t`t`t LISTA DE ALMACENES"
write-host -BackgroundColor Red -ForegroundColor Yellow "`t`t`t ------------------"
Get-WinEvent -ListLog * | Select-Object -Property logname 

[string]$nombre=read-host "nombre del almacen(consumidor).evtx __"

#...buscamos si existe o no el almacen...
[string]$busqueda=Get-WinEvent -ListLog * | Select-Object -Property logname | Where-object { $_.Logname -ieq "security" }

if( $busqueda -ieq ""){

    write-host "...no existe ese almacen de datos de eventos..."

} else {

    $log=get-winevent -ListLog $nombre
    $log | Select-Object -Property MaximumSizeInBytes,FileSize,LastWriteTime,RecordCount,ProviderNames,LogFilePath

    [string]$resp=read-host "quieres vaciar de eventos el log [s/n]? __"
    if( $resp -ieq "s" ){
        Clear-EventLog -LogName $nombre
    }

}
