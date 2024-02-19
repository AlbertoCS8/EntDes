<#  ------------- CON WMIC ----------------------------------------
 hacer script q te pida el nombre de un almacen y  muestre solo las props de abajo
   despues te tiene q preguntar si lo quieres vaciar de mensajes, si es asi vaciarlo y comprobarlo en el visor:  EventVwr.msc

						- prop. tamaño total del almacen total:                         MaxFileSize			
						- prop. tamaño actual del almacen: 		                        FileSize		
						- prop. fecha ultima modificacion (registro del ultimo evento): LastModfied
						- prop. numero de eventos registrados:  			            NumberOfRecords
						- prop. proveedores de eventos q mandan aqui mensajes: 		    Sources
						- prop. ruta donde se encuentra el almacen: 			        Path


 para borrar el fich.de eventos hay q invocar metodo de clase wmic:  .ClearEventLog("ruta/nombre_fichero.evtx")
                                                                                     -------------------------
                                                                                       te lo da propiedad .Name

#>
clear-host
write-host -BackgroundColor Red -ForegroundColor Yellow "`t`t`t LISTA DE ALMACENES"
write-host -BackgroundColor Red -ForegroundColor Yellow "`t`t`t ------------------"

#...lo metemos en una variable el listado pq es op.asincrona y tarda en ejecutarse...si pones directamente
#el comando muestra antes el read-host de mostrar el listado. Write-Host obliga a esperar su resultado

$listalogs=Get-CimInstance -ClassName Win32_NtEventLogFile | Select-Object -Property FileName

write-host $listalogs
[string]$nombre=read-host "nombre del almacen(consumidor).evtx __"


# ¿¿ QUE ES MAS EFICAZ ??
# nooooooooo hacer esto...
#$log=Get-CimInstance -ClassName Win32_NtEventLogFile | Where-Object { $_.FileName -ieq $nombre }

# esto es mas eficaz:
$log=Get-CimInstance -ClassName Win32_NtEventLogFile -Filter "FileName='$nombre'"
#$log=Get-CimInstance -Query "SELECT * FROM Win32_NtEventLogFile WHERE FileName='$nombre'"

$log |  Select-Object -Property MaxFileSize,FileSize,LastModified,NumberOfRecords,Sources,Paty

#para borrar log desde wmic:
# wmic nteventlog where 'FileName="Security"' call ClearEventLog 
Invoke-CimMethod -InputObject $log -MethodName "ClearEventLog"

#si no quieres recuperar antes en la varible $log el objeto consumidor sobre el q quieres actuar
#puedes seleccionarlo directamente antes de ejecutar el metodo con parametro -Query, asi:
# Invoke-CimMethod  -Query "SELECT * FROM Win32_NtEventLogFile WHERE FileName='$nombre'" -MethodName "ClearEventLog"









