# Add task to `Task Scheduler`

To add a task to the **Task Scheduler** in Windows, follow these steps:

To create a more advanced task in Task Scheduler, follow these detailed steps:

### 1. **Open Task Scheduler:**
   - Press `Windows + R` to open the Run dialog.
   - Type `taskschd.msc` and hit `Enter` to open Task Scheduler.

### 2. **Create a New Task:**
   - In the left pane, select **Task Scheduler Library** to see existing tasks.
   - In the **Actions** pane on the right side, click **Create Task** (not **Create Basic Task**). This gives you more control over the task's configuration.

### 3. **General Tab:**
   - **Name**: Enter a descriptive name for your task.
   - **Description**: (Optional) Provide a description for the task.
   - **Security options**:
     - Choose the user account under which the task will run.
     - If you want the task to run with elevated privileges (as administrator), check **Run with highest privileges**.
   - **Configure for**: Select the version of Windows you're using, or leave it set to **Windows 10** (default).

### 4. **Triggers Tab:**
   Triggers define when the task will run. You can set multiple triggers for one task.
   - Click **New** to create a trigger.
   - **Begin the task**: Choose when the task should trigger. Options include:
     - **On a schedule**: Daily, Weekly, Monthly, etc.
     - **At logon**: When you log into Windows.
     - **At startup**: When Windows starts.
     - **On an event**: When a specific system event occurs.
     - **On idle**: When the system is idle.
   - Once you configure the trigger, click **OK**.

### 5. **Actions Tab:**
   Actions define what the task will actually do once triggered.
   - Click **New** to define an action.
   - **Action**: Select **Start a program** (this is the most common option).
     - In the **Program/script** field, enter:
     ```cmd
     Powershell
     ```
     - In the  **`Add arguments`** field, enter:
     ```Powershell
     -ExecutionPolicy RemoteSigned -File "%userprofile%\Desktop\BackupScript\backup_script_ru.ps1"
     ```
> [!NOTE]
>I added the path to the file in the arguments as an example, but you must specify the full path to the folder with the script there! The path specified in the example leads to the `BackupScript` folder on the desktop. `%userprofile%` - macro for accessing the user folder

   - Once you're done, click **OK**.

### 6. **Conditions Tab:**
   Conditions define additional requirements for the task to run. These are optional, but helpful if you want the task to have specific conditions:
   - **Start the task only if the computer is idle for**: Specifies how long the computer must be idle before the task starts.
   - **Stop if the computer switches to battery power**: Useful for laptops to conserve battery life.
   - **Wake the computer to run this task**: Check this if you want the task to run even when the system is in sleep mode.
   - Configure these options as per your needs, then click **OK**.

### 7. **Settings Tab:**
   The Settings tab allows you to configure additional behaviors for the task.
   - **Allow task to be run on demand**: This lets you manually start the task if desired.
   - **If the task fails, restart every**: Set up a retry interval and how many attempts should be made if the task fails.
   - **Stop the task if it runs longer than**: Useful for long-running tasks to avoid hanging processes.
   - **If the task is already running, then the following rule applies**: You can specify whether to run a new instance or wait for the existing task to finish.
   - After configuring, click **OK**.

### 8. **OK and Save the Task:**
   - After completing all the tabs, click **OK** to save the task.
   - If prompted, enter your password or provide appropriate credentials if the task is set to run with elevated privileges.

### 9. **Verify the Task:**
   - Once created, your task will appear in the **Task Scheduler Library**.
   - You can **right-click** the task and select **Run** to manually trigger it or **Properties** to edit it.

[<- return to README](/README.md)

---