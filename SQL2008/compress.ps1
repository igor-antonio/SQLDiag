#Start-Sleep -Seconds 30

param(
    [string]$output_name
)

$date_startup = $null
$date_shutdown = $null
$filename = $null
$full_path_zip_file = $null

$folder_pattern = 'SQLDiag_Output_'
$location = [System.IO.Path]::Combine($PSScriptRoot,"Output")
$location_zip = [System.IO.Path]::Combine($PSScriptRoot,"Outcab")

$folders_path = "$location\SQLDiag_Output_"

$folders = Get-ChildItem -Path "$filesPath*"

$folders | ForEach-Object{
  
    $directory = $_.FullName

    if((Get-ChildItem -Path "$directory").Count -ne 0){

        if(Test-Path -Path "$directory\TOOLS-2012_A_get_action_time_Shutdown.OUT"){
            $date_startup = Get-Content -Path "$directory\TOOLS-2012_A_get_action_time_Startup.OUT"      
        }

        if(Test-Path -Path "$directory\TOOLS-2012_A_get_action_time_Shutdown.OUT"){
            $date_shutdown = Get-Content -Path "$directory\TOOLS-2012_A_get_action_time_Shutdown.OUT"      
        }

        if($date_startup -eq $null -or $date_startup -eq $null){
            $date_startup = [guid]::NewGuid().Guid
            $filename = [string]$folders_pattern + [string]$date_startup
            $full_path_zip_file = "$location_zip\$filename.zip"
        }
        else{
            $filename = [string]$folders_pattern + [string]$date_startup + '_to_' + [string]$date_shutdown
            $full_path_zip_file = "$location_zip\$filename.zip"
        }

        ..\7za.exe a "$full_path_zip_file" "$directory\*" -r -mmt1 -bd -bt -sdel > "$location_zip\$filename.log"
    }

    if((Get-ChildItem -Path "$directory").Count -eq 0){
        rmdir "$directory"
    }

}

<#
Set-Location $location_zip

$dateLimit = ((Get-Date).AddDays(-15)).ToShortDateString()

$files = Get-ChildItem -File -Path 'Output_*.zip' | Where-Object {($_.LastWriteTime).ToShortDateString() -lt $dateLimit}

$files | ForEach-Object{
    Remove-Item -Path "$_"
}
#>