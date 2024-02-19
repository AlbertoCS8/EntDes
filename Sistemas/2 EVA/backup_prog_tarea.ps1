<#
    ...script backup docs de directorio personal "Documentos" en c:\windows\temp\backup-dd_mm_yy ...
#>
[string]$destino="C:\Windows\Temp\backup-$((get-date).ToShortDateString().Replace("/","_"))"
[string]$origen="$env:USERPROFILE\Documents"

Copy-Item -Path $origen -Destination $destino -Recurse -Force 


# comandos para programar tarea que ejecute este script los L,X,V a las 23:00 ... <==OJO!!! ESTOS COMANDOS VAN
#  FUERA DEL SCRIPT!!!!

# 1º objeto ScheduledTaskAction...
$accion=New-ScheduledTaskAction -Execute "powershell.exe" -Argument "C:\Users\pmr_a\Documents\scripts\admin_tareas\backup_prog_tarea.ps1"

# 2º objeto ScheduledTaskPrincipal....
#(tb se puede poner como un string usando opcion -User en comando Register-ScheduledTask:
# con este formato:  .... "nombre_maquina\nombre_usuario" ---> "$env:COMPUTERNAME\$env:USERNAME" )
$usuario=New-ScheduledTaskPrincipal -UserId "$env:USERNAME"

# 3º objeto(s) SheduledTaskTrigger...
$trigger=New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Wednesday,Friday -At 23:00

# 4º objeto ScheduledTaskSettings (opcional)....
$settings=New-ScheduledTaskSettingsSet

# ---- registramos tarea----
Register-ScheduledTask -TaskName "backupdocs" -TaskPath "\mistareas\" -Principal $usuario -Action $accion -Settings $settings -Trigger $trigger








 