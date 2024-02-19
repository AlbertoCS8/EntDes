<#
    script info procesos....
    (lo ampliaremos para manejar hilos)
    cambiar politica de ejecucion: Set-ExecutionPolicy -ExecutionPolicy Unrestricted
#>
clear-host

write-host -BackgroundColor red -ForegroundColor White "----------------------------------"
write-host -BackgroundColor red -ForegroundColor White "`t`t LISTA DE PROCESOS `t"
write-host -BackgroundColor red -ForegroundColor White "----------------------------------"

get-process

