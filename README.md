# `tar-backup.sh`

## Description

This bash script creates a gzip tarball archive backup of specified directories and files.

## Usage

```bash
./tar-backup.sh -a <archive-name> -i <input-directory> -o <output-directory>
```

- `-a`: The name of the archive file (e.g. "backup").
- `-i`: The path of the directory that you want to backup.
- `-o`: The path of the directory where you want to save the backup file. If not specified, the backup file will be saved in `$HOME/backups/` by default.

## Example

```bash
./tar-backup.sh -a "my-project" -i "/path/to/my-project-folder" -o "/path/to/backup/folder"
```

This command will create a backup file named `my-project-2023.01.12.171530.tar.gz` in the directory `/path/to/backup/folder` containing the contents of the directory `/path/to/my-project-folder`.
