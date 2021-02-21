# [Choice] Ruby version: 2, 2.7, 2.6, 2.5
ARG VARIANT=2
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT}

# Install Rails
RUN gem install rails webdrivers 

ARG NODE_VERSION="lts/*"
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install additional gems.
RUN gem install bundler rake standardrb \
    && bundle config path vendor/bundle \
    && curl https://cli-assets.heroku.com/install.sh | sh \

# Git aliases
RUN wget -O /etc/profile.d/git_aliases.sh https://github.com/athackst/workstation_setup/raw/main/user/.aliases/git_aliases.sh \
    && echo "source /etc/profile.d/git_aliases.sh" >> /home/vscode/.bashrc

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
