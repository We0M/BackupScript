#############################
### BackUp Script by WeoM ###
#############################

$version = "1.0"
$scriptName = "BackUp Script $version by WeoM"

Add-Type -AssemblyName System.Windows.Forms
$result = [System.Windows.Forms.MessageBox]::Show("Необходимо сделать резервную копию. Нажмите 'Ок' когда будете готовы.", "$scriptName", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Information)
function Get-Timestamp {
    return (Get-Date).ToString("dd.MM.yyyy HH:mm:ss")
}
if($result -eq [System.Windows.Forms.DialogResult]::OK) {
    # получение пути к папке, в которой находится текущий скрипт, в ней же должны быть файлы: source.txt exclude.txt 7z.exe 7z.dll
    $path = $PSScriptRoot
    $7z = Join-Path -Path $path -ChildPath "7z.exe"
    # WARNING! в файлах source.txt и exclude.txt необходимо использовать полные пути из-за ключа -spf2
    # в source.txt необходимо добавлять папки и файлы, которые необходимо бекапить
    $sourceList = Join-Path -Path $path -ChildPath "source.txt"
    # в exclude.txt добавляются исключения
    $excludeList = Join-Path -Path $path -ChildPath "exclude.txt"
    # папка, в которой будут сохранены архивы бекапов
    $target = "D:\BackupFolderName\"
    # текущая дата в формате 2024_01_01
    $date = Get-Date -Format "yyyy_MM_dd"
    # название результирующего файла
    $filename = "backup_$date.7z"
    # по желанию можно добавить пароль к архиву, для этого нужно ввести желаемый пароль между ""
    $pwd = ""

    $check = $true
    $counter = 0
    while($check -and $counter -le 4) {
        if(-not $pwd) {
            Write-Host "`n$(Get-Timestamp) Создание резервной копии без пароля: " -ForegroundColor Magenta
            & $7z a -t7z (Join-Path -Path $target -ChildPath $filename) -bt -mx5 -ssw -snh -snl -ssp -spf2 @$sourceList -xr@"$excludeList" -scrcSHA256
        } else {
            Write-Host "`n$(Get-Timestamp) Создание резервной копии с паролем: " -ForegroundColor DarkGreen
            & $7z a -t7z (Join-Path -Path $target -ChildPath $filename) -bt -mx5 -ssw -snh -snl -ssp -spf2 -p"$pwd" -mhe @$sourceList -xr@"$excludeList" -scrcSHA256
        }

        Write-Host "`nПроверка архива и целостности данных. Ждите..." -ForegroundColor Blue
        $result = & $7z t (Join-Path -Path $target -ChildPath $filename) -p"$pwd"
        if ($result -like "*Everything is Ok*") {
            foreach ($line in $result) {
                Write-Host $line -ForegroundColor DarkYellow
            }
            Write-Host "`n$(Get-Timestamp) резервная копия успешно создана! `nНазвание файла: $filename  `nПуть: $target " -ForegroundColor Green
            Write-Host "`nЭто окно закроется через 5 секунд..."
            Start-Sleep -Seconds 5
            $check = $false
        } else {
            Write-Host "`n$(Get-Timestamp) ОШИБКА:" -ForegroundColor Red
            foreach ($line in $result) {
                 Write-Host $line -ForegroundColor Red
            }
        }

        $counter += 1

        if ($counter -gt 4) {
            $errorMessage  = "`n$(Get-Timestamp)Не удалось создать архив за $counter попыток. Операция отменена."
            Write-Host $errorMessage -ForegroundColor Red
            [System.Windows.Forms.MessageBox]::Show("$errorMessage", "$scriptName", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            $check = $false
        }
    }
} else {
    Write-Host "`n$(Get-Timestamp)Создание резервной копии отменено." -ForegroundColor Red
    Write-Host "Это окно закроется через 5 секунд..."
    Start-Sleep -Seconds 5
}