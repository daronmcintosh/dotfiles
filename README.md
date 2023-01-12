# dotfiles

## how to use

```sh
bash <(curl -s https://raw.githubusercontent.com/daronmcintosh/dotfiles/main/linux-setup.sh)
```

## test by running (requires docker)

1. clone repo
2. run:

```sh
docker build --progress=plain -t foo . && docker run --rm -it foo
```
