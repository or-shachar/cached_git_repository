# cached_git_repository

This is an attempt to test using single git repository local index in global space and checking out different commits in diffent folders

The script will:
1. Create / upsert local `.git` cache folder per given `<repo_name>` under `~/.vmrcache/<repo_name>`. This folder will be shared.
2. Reset the target folder to specified commit given
3. Multiple target folders can exist, each of them would be reset to different folder.

The example below shows work on relatively small public repository https://github.com/or-shachar/jvm-classpath-validator 

Preparation for the script run:
Create the target folders
```sh
mkdir -p /tmp/a1
mkdir -p /tmp/a2
mkdir -p /tmp/a3
```

Running the script:
```
# checkout commit 18bc0bc to folder /tmp/a1, first time so it creates the cache under ~/.vmrcache/jvm-classpath-validator
./git_repository.sh jvm-classpath-validator git@github.com:or-shachar/jvm-classpath-validator.git 18bc0bc06ff2773d7c661f12765d7decee79136c /tmp/a1

# checkout out commit 0acf4bd2 to folder /tmp/a2, using the same cache
./git_repository.sh jvm-classpath-validator git@github.com:or-shachar/jvm-classpath-validator.git 0acf4bd2fc103ac9989ced2b6fa38b37aa191a8c /tmp/a2

# checkout out commit b5e0aae to folder /tmp/a3, using the same cache
./git_repository.sh jvm-classpath-validator git@github.com:or-shachar/jvm-classpath-validator.git b5e0aae491b9dd685991f381e92d43781da06a1f /tmp/a3
```
