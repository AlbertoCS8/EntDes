<#
    script control de procesos/hilos
   mostrar este menu:

        ADMIN PROCESS/THREADS
        =====================
    1.- Arrancar proceso <------------------------ pedir .exe de la aplicacion a crear proceso
    2.- Parar proceso(matarlo) <------------------ pedir nombre, matarlo
    3.- Suspender proceso  <---------------------- pedir nombre, pararlo (comprobar el nuevo estado hilos)
    4.- Ver estado de los hilos de un proceso <--- pedir nombre proceso, mostrar estado hilos
    5. --- SALIR ---
    opcion:_

    ayuda:  get-help about_switch
            get-help about_if
            get-help about_while
#>

[int]$opcion=0
while($opcion -ne 5)
{
    clear-host
    write-host -BackgroundColor Red -ForegroundColor Yellow "`t`t ADMIN PROCESS/THREADS"
    write-host -BackgroundColor Red -ForegroundColor Yellow "`t`t ====================="
    write-host "`t`t 1.- Arrancar proceso"
    write-host "`t`t 2.- Parar proceso"
    write-host "`t`t 3.- Suspender proceso"
    write-host "`t`t 4.- Ver estado hilos de un proceso"
    write-host "`t`t 5.- ---- SALIR ---"
    [int]$opcion=read-host "Opcion_"

    switch($opcion)
    {
        1 {
            [string]$aplicacion=read-host "introduce ruta y nombre del .exe a lanzar(si no pones ruta, la busca en PATH)_"
            Start-Process -FilePath $aplicacion -WindowStyle Normal
          }
        2 {
            [string]$nombre=Read-Host "Nombre del proceso..."
            Stop-Process -name $nombre        
           }
        3 {
            [string]$nombre=Read-Host "Nombre del proceso..."
             Wait-Process -Name $nombre             
           }

        4 {
            [string]$nombre=Read-Host "Nombre del proceso..."
            $cont=0
            (get-process -name $nombre).Threads.ForEach({ write-host "hilo $cont...." $_.ThreadState; $con++; })
           }
    }

    Start-Sleep -Seconds 3
}



