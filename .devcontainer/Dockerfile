FROM mcr.microsoft.com/vscode/devcontainers/universal:1-linux

USER root

# Update args in docker-compose.yaml to set the UID/GID of the "codespace" user.
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN if [ "$USER_GID" != "1000" ] || [ "$USER_UID" != "1000" ]; then \
        groupmod --gid $USER_GID codespace \
        && usermod --uid $USER_UID --gid $USER_GID codespace \
        && chown -R $USER_UID:$USER_GID /home/codespace \
        && chown -R $USER_UID:root /usr/local/share/nvm /usr/local/share/npm-global; \
    fi

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends awscli aws-shell

USER codespace

RUN npm install -g tldr
