<#
    ...script lanza apps mas usadas por usuario: firefox, visual studio code, notepad...
    ...programarlo para que se ejecute cada vez que inicie sesion...
#>

(
 "c:\archivos de programa\firefox\firefox.exe",
 "c:\windows\system32\notepad.exe",
 "c:\archivos de programa\vscode\code.exe" ) | ForEach-Object {
    Start-process -FilePath $_ 
}
#-----------------------------------------------------------
#comandos prog.tarea:
# 1º objeto ScheduledTaskAction...
$accion=New-ScheduledTaskAction -Execute "powershell.exe" -Argument "C:\Users\pmr_a\Documents\scripts\admin_tareas\logonApps_prog_tarea.ps1"

# 2º objeto ScheduledTaskPrincipal....
#(tb se puede poner como un string usando opcion -User en comando Register-ScheduledTask:
# con este formato:  .... "nombre_maquina\nombre_usuario" ---> "$env:COMPUTERNAME\$env:USERNAME" )
$usuario=New-ScheduledTaskPrincipal -UserId "$env:USERNAME"

# 3º objeto(s) SheduledTaskTrigger...
$trigger=New-ScheduledTaskTrigger -AtLogOn

# 4º objeto ScheduledTaskSettings (opcional)....
$settings=New-ScheduledTaskSettingsSet

# ---- registramos tarea----
Register-ScheduledTask -TaskName "logonApps" -TaskPath "\mistareas\" -Principal $usuario -Action $accion -Settings $settings -Trigger $trigger
