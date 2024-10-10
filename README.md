# BackUp Script

**English | [Русский](docs/ru/Readme_ru.md)**

Latest version: **[Download](https://github.com/We0M/BackupScript/releases/download/1.0.0/En_BackUp_Script.zip)**

## Actions after downloading

1. Unzip to a convenient location.
2. Open **`backup_script_en.ps1`** and customize it for yourself. Almost all parameters have a description, **[below are some aspects](#additional-information)** that may not be entirely obvious.
3. In **`Task Scheduler`** create a new task with the action **`Start a program`**, in the **`Program/script`** field, enter:
```cmd
Powershell
```
- In the  **`Add arguments`** field, enter:
```Powershell
-ExecutionPolicy RemoteSigned -File "%userprofile%\Desktop\BackupScript\backup_script_ru.ps1"
```
> [!NOTE]
>I added the path to the file in the arguments as an example, but you must specify the full path to the folder with the script there! The path specified in the example leads to the `BackupScript` folder on the desktop. **`%userprofile%`** - macro for accessing the user folder

> [!CAUTION]
> Check if everything was done correctly by forcing the task. To do this, in the task scheduler, select the task you created and click `Run`, or right-click on this task and click `Run`.

---

## Additional information

- ### Date
  To use backup more often than once a day, there are 2 options:
  - update the data in the archive, no action is required for this. In this case, only the data that has changed since the previous backup of the same day will be added;
  - if separate archives are required, you need to change the date format in the variable `$date = Get-Date -Format "yyyy_MM_dd"` to `$date = Get-Date -Format "yyyy_MM_dd_HH_mm"` i.e. add hours and minutes.

- ### [List sources and exclusions](docs/Sources_and_Exclusions.md)
- ### [Add task to `Task Scheduler`](docs/Task_Scheduler.md)

---