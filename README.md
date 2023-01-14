# `tar-backup.sh`

Last updated: `Thu 12 Jan 2023 20:15:17 IST`

## Description

This bash script creates a gzip tarball archive backup of specified directories and files, that can be scheduled automatically using `crontab` by running it as a command.

## Usage

```bash
./tar-backup.sh -a <archive-name> -i <input-directory> -o <output-directory>
```

- `-a`: The name of the archive file (e.g. "backup").
- `-i`: The path of the directory that you want to backup.
- `-o`: The path of the directory where you want to save the backup file. If not specified, the backup file will be saved in `$HOME/backups/` by default.

## Example usage

Here are some examples of how to use the `tar-backup.sh` script:

### Automatic mode

```bash
./tar-backup.sh -a "my-project" -i "/path/to/my-project-folder" -o "/path/to/backup/folder"
```

This command will create a backup file named `my-project-2023.01.12.171530.tar.gz` in the directory `/path/to/backup/folder` containing the contents of the directory `/path/to/my-project-folder`.

Example output:

```bash
Compressing...

Created /path/to/backup/folder/my-project-2023.01.12.171530.tar.gz
Completed in 0 hour(s), 0 minute(s), and 5 second(s).
```

### Manual mode

```bash
./tar-backup.sh
```

In manual mode, the user is prompted to enter the path of the directory to backup, the name of the archive file, and the option to change the output directory. If not changing the output directory, the backup file will be saved in `$HOME/backups/` by default.

Example output:

```bash
Enter full path of target input dir: /path/to/my-project-folder
Enter archive name: my-project
Change output directory? [y/n] (default: $HOME/backups/) n

Compressing...

Created /path/to/backup/folder/my-project-2023.01.12.171530.tar.gz
Completed in 0 hour(s), 0 minute(s), and 5 second(s).
```

## Adding to `crontab` for automatic scheduling

To schedule this script to run daily at 21:00 using `crontab`, you can follow these steps:

1. Open the terminal and type `crontab -e` to open the editor.
2. Add the following line:
    ```bash
    0 21 * * * /bin/bash /path/to/tar-backup.sh -a <archive-name> -i <input-directory> -o <output-directory>
    ```
    - Replace `<archive-name>`, `<input-directory>`, and `<output-directory>` with the appropriate values.
    - Make sure to use the full path to the script file.
3. Save and exit the editor.