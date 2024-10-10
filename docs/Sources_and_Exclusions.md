# List sources and exclusions

Let's assume you have the following folder structure:
```
C:\data\
    ├── important\
    │   ├── docs\
    │   │   ├── .exclude\
    │   │   ├── file5.tmp
    │   │   └── file6.tmp
    │   ├── .exclude\
    │   ├── file1.txt
    │   └── file2.txt
    └── temp\
        ├── .exclude\
        ├── file3.tmp
        └── file4.tmp
```

> [!CAUTION]
> All paths must be full, not absolute, i.e. the path must start with a drive letter.


## List file source.txt

1. **File format**:

In the file, you can specify paths to files and folders that you want to archive, and also add comments, starting the line with `#`. Each path must be on a separate line.
For example:
```
C:\data\important\file1.txt
C:\data\important\file2.txt
# this line is ignored by 7-Zip
C:\data\important\docs\
```

> [!NOTE]
> If the path contains spaces, it must be enclosed in quotation marks:
> ```
> "C:\path with spaces\file1.txt"
> ```

2. **Templates**:

You can use wildcards (`*` and `?`) to specify file groups:
   - `*` - matches any number of characters (including zero).
     ```md
      `C:\path\to\*.txt` includes all files with the extension `.txt` in the specified folder.
     ```
   - `?` - matches any single character.
     ```md
      `C:\path\to\file?.txt` matches `file1.txt`, `file2.txt`, but not `file10.txt`.
     ```
You can use `**` to recursively search for files in all subdirectories.
   ```md
      `C:\path\to\**\*.jpg` includes all `.jpg` files in the specified folder and all its subdirectories.
   ```

## exclude.txt

To exclude individual files or folders that you do not want to save in the backup, use the `exclude.txt` file.

### Examples of exceptions:

1. **Single file exclusion**:
   ```md
   C:\data\important\file1.txt
   ```

2. **Exclude all files of a certain type**:
   ```md
   C:\data\temp\*.tmp
   ```

3. **Exclude a specific folder**:
   ```md
   C:\data\temp\
   ```

4. **Exclude all folders of a specific name**:
   ```md
   *.exclude\*
   ```

---

## Example of use

If you want to archive the entire `data` folder, excluding the `temp` folder, all `.tmp` files in all folders, as well as the `.exclude` folders, for this:
- Add a line to the `source.txt` file
   ```
   C:\data\
   ```
- Add lines to the `exclude.txt` file
   ```
   C:\data\temp\ # excludes temp folder
   *.tmp # excludes all files with the .tmp extension in all folders
   *.exclude\* # excludes all folders named .exclude and their contents in all folders
   ```

As a result, the following structure will be preserved:

```
C:\data\important\
        ├── docs\
        │   ├── file5.tmp
        │   └── file6.tmp
        ├── file1.txt
        └── file2.txt
```

[<- return to README](/README.md)

---

