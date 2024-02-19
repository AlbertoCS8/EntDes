clear-host

[System.Diagnostics.Process]$procesopower=get-process -name powershell_ise

<# ---- con bucle for de toda la vida kk de la vaka ----------------
for([int]$a=0; $a -lt $procesopower.Threads.Count; $a++){
    write-host "hilo numero: $a ...... $procesopower.Threads[$a].Id"
}
#>

<#
[int]$contador=0;
foreach($unhilo in $procesopower.Threads){
    write-host "hilo numero: " $contador  "......" $unhilo.Id
    $contador=$contador + 1
}
#>

#...buscar: ProcessThreadCollection ForEach method example ....
#   .ForEach( $_ => { write-host $_.Id })
[int]$contador=0
$procesopower.Threads.ForEach( { write-host "hilo numero:" $contador "...." $_.Id;  $contador+=1; })

