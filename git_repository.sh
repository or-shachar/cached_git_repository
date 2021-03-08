#!/bin/bash

# USAGE:
# ./git_repository.sh <repo_name> <repo_url> <git_commit> <checkout_dir>
# repo_name - the repo name in bazel
# repo_url - git remote url
# git_commit - the commit we want to get
# checkout_dir - the target folder checkout the code into
# eg:
# ./git_repository.sh jvm-classpath-validator git@github.com:or-shachar/jvm-classpath-validator.git 18bc0bc06ff2773d7c661f12765d7decee79136c /tmp/a1
REPO_NAME=$1
GIT_URL=$2
GIT_COMMIT=$3
CHECKOUT_DIR=$4

CWD=$(pwd)
CACHE_FOLDER=${HOME}/.vmrcache/${REPO_NAME}

# TODO: write code that checks if the folder already exists and that it's remote is just like the GIT_URL
export GIT_DIR=${CACHE_FOLDER}/.git

set -e
if [ ! -e "${GIT_DIR}" ] # TODO: we should probably also read the .git/config and check that the remote is the same
then
    rm -rf ${CACHE_FOLDER}
    mkdir -p ${CACHE_FOLDER}
    # init the cache folder    
    git init
    git remote add origin $GIT_URL
    git fetch 
    cd $(mktemp -d)
    #git checkout $GIT_COMMIT # must perform some checkout for some reason, need to investigate why
fi

cd $CHECKOUT_DIR
export GIT_WORKING_DIR=$CHECKOUT_DIR

set +e
git reset --hard $GIT_COMMIT
retVal=$?
# if the current commit does not exist in index, fetch it
if [ $retVal -eq 128 ] 
then
    git fetch 
    git reset --hard $GIT_COMMIT
fi

cd ${CWD} # go back to current dir