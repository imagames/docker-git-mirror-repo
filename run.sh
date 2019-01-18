#!/usr/bin/env sh
set -euo pipefail


# Clone the requested repo
cd /git
REPO_FOLDER=$(basename "$GIT_CLONE_URL" .git)
if [ ! -d "${REPO_FOLDER}" ] ; then
    echo "Repo not present, cloning"
    git clone ${GIT_CLONE_URL} ${REPO_FOLDER}
else
    echo "Repo present, updating"
    cd "${REPO_FOLDER}"
    git pull ${GIT_CLONE_URL}
fi

# startup
spawn-fcgi -s /run/fcgi.sock /usr/bin/fcgiwrap && \
    nginx -g "daemon off;"
