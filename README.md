# docker-git-mirror-repo

This is a small utility Docker image that clones a git repo and serves it over insecure HTTP.
To use, simply set the `GIT_CLONE_URL` env variable and `docker run` this image.

For example:

```bash
docker run -d -p 30080:80 -e GIT_CLONE_URL=http://host/repo-name.git imagames/git-mirror-repo
```

This mirror serves the repo under the `/git/` path. To clone from this mirror:

```bash
git clone http://localhost:30080/git/repo-name
```

## Cloning over SSH

This image comes with a SSH client so you can clone a SSH repo too. You should put your SSH keys in the `/root/.ssh/` folder. For example:

```bash
docker run -d \
    -p 30080:80 \
    -e GIT_CLONE_URL=git@host:your-repo/url.git \
    -v /path/to/id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v /path/to/id_rsa:/root/.ssh/id_rsa \
     imagames/git-mirror-repo
```

You can also do this with `docker secret` if running inside a swarm.

## Persistence

Repos are cloned in the container's `/git` folder. Feel free to mount this as a volume to avoid unneeded clones: if the folder is present, this image will run `git pull` instead of `git clone` on startup.

## Why

This was originally built as a way to provide access to secured git repos inside swarm stacks without having to put the SSH keys in the client containers.

Another use of this mirror is reducing bandwidth usage since you could use the same mirror for all clients on your local network, thus having to download the repo from the internet only once.