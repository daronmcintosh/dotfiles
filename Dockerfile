# syntax=docker/dockerfile:1

FROM ubuntu:latest

RUN apt update && apt install -y \
    curl \
    gpg \
    wget \
    git \
    sudo \
    nano
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg;
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null;
RUN apt update && apt install -y gh;

COPY linux-setup.sh ./
RUN chmod +x linux-setup.sh
ARG CACHE_DATE=2023-01-01
RUN ./linux-setup.sh

ENTRYPOINT [ "/bin/zsh" ]
