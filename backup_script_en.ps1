#############################
### BackUp Script by WeoM ###
#############################

$version = "1.0"
$scriptName = "BackUp Script $version by WeoM"

#Load lib WinForms
Add-Type -AssemblyName System.Windows.Forms

#Create message
$result = [System.Windows.Forms.MessageBox]::Show("Need to make a backup. Click 'Ok' when you are ready.", "$scriptName", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Information)

function Get-Timestamp {
    return (Get-Date).ToString("dd.MM.yyyy HH:mm:ss")
}

if($result -eq [System.Windows.Forms.DialogResult]::OK) {
    # get the path to folder where the executable script is located: source.txt exclude.txt 7z.exe 7z.dll
    $path = $PSScriptRoot
    $7z = Join-Path -Path $path -ChildPath "7z.exe"
    # WARNING! in source.txt and exclude.txt files it is necessary to use full paths because of the -spf2 key
    # in source.txt we add folders and files that are added to the backup
    $sourceList = Join-Path -Path $path -ChildPath "source.txt"
    # exclusions are added to exclude.txt
    $excludeList = Join-Path -Path $path -ChildPath "exclude.txt"
    # the folder where the backups will be saved
    $target = "D:\BackupFolderName\"
    # current date in format 2024_01_01
    $date = Get-Date -Format "yyyy_MM_dd"
    # name of the resulting file
    $filename = "backup_$date.7z"
    # optionally you can add a password to the archive, to do this you need to enter the desired password between ""
    $pwd = ""

    $check = $true
    $counter = 0
    while($check -and $counter -le 4) {
        # verification is necessary because of the -mhe key, otherwise the archive will be without a password but with encrypted headers.
        if(-not $pwd) {
            Write-Host "`n$(Get-Timestamp) Create a backup without a password" -ForegroundColor Magenta
            & $7z a -t7z (Join-Path -Path $target -ChildPath $filename) -bt -mx5 -ssw -snh -snl -ssp -spf2 @$sourceList -xr@"$excludeList" -scrcSHA256
        } else {
            Write-Host "`n$(Get-Timestamp) Create a backup with a password" -ForegroundColor DarkGreen
            & $7z a -t7z (Join-Path -Path $target -ChildPath $filename) -bt -mx5 -ssw -snh -snl -ssp -spf2 -p"$pwd" -mhe @$sourceList -xr@"$excludeList" -scrcSHA256
        }

        # check archive and data integrity
        Write-Host "`nCheck archive and data integrity. Wait..." -ForegroundColor Blue
        $result = & $7z t (Join-Path -Path $target -ChildPath $filename) -p"$pwd"
        if ($result -like "*Everything is Ok*") {
            foreach ($line in $result) {
                 Write-Host $line -ForegroundColor DarkYellow
            }
            Write-Host "`n$(Get-Timestamp) backup successfully created! `nFile name: $filename  `nPath: $target " -ForegroundColor Green
            Write-Host "This window will close in 5 seconds..."
            Start-Sleep -Seconds 5
            $check = $false
        } else {
            Write-Host "`n$(Get-Timestamp) ERROR:" -ForegroundColor Red
            foreach ($line in $result) {
                 Write-Host $line -ForegroundColor Red
            }
        }

        $counter += 1

        # if the archive could not be created in 5 attempts, the cycle ends
        if ($counter -gt 4) {
            $errorMessage  = "`n$(Get-Timestamp) Failed to create archive after $counter attempts. Operation cancelled."
            Write-Host $errorMessage -ForegroundColor Red
            [System.Windows.Forms.MessageBox]::Show("$errorMessage", "$scriptName", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            $check = $false
        }
    }
} else {
    Write-Host "`n$(Get-Timestamp)Backup creation cancelled." -ForegroundColor Red
    Write-Host "This window will close in 5 seconds..."
    Start-Sleep -Seconds 5
}