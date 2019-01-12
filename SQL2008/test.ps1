#Start-Sleep -Seconds 30

param(
    [string]$output_name
)

$output_name | Out-File -FilePath "W:\iantonio\Downloads\DiagManager13.0.1600.32\DiagManager13.0.1600..32\Models\SQL2008\expanded\output_name.txt" -Append