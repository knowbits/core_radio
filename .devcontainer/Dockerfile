# Use Alpine as the base image
FROM alpine:latest

# Install dependencies and configure locale and timezone
RUN apk add --no-cache \
    fish \
    curl \
    bash \
    sudo \
    git \
    exa \
    ripgrep \
    tig \
    lazygit \
    fd \
    fzf \
    util-linux \
    musl \
    tzdata \
    zoxide \
    && cp /usr/share/zoneinfo/Europe/Oslo /etc/localtime \
    && echo "Europe/Oslo" > /etc/timezone \
    && echo "en_GB.UTF-8 UTF-8" >> /etc/locale.conf \
    && export LANG=en_GB.UTF-8 \
    && rm -rf /var/cache/apk/*

# Set locale and timezone environment variables
ENV LANG=en_GB.UTF-8 \
    LC_ALL=en_GB.UTF-8 \
    TZ=Europe/Oslo

# Switch to the vscode user
RUN adduser -D vscode
USER vscode

# Install Fisher plugin manager and plugins (Tide, Dracula theme)
RUN fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
RUN fish -c "fisher install IlanCosman/tide@v6 dracula/fish"

# Run Tide auto-configuration with predefined settings
RUN fish -c "tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Light --show_time='24-hour format' --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Few icons' --transient=No"

# Set the Dracula theme for Fish shell 
RUN fish -c "fish_config theme choose 'Dracula Official'"

# Temporarily switch to root to modify /etc/shells
USER root
RUN echo /usr/bin/fish | tee -a /etc/shells

# Revert back to vscode user
USER vscode

# Make sure config.fish is always available for the vscode user
RUN touch /home/vscode/.config/fish/config.fish

# Set work directory
WORKDIR /workspace

# Command to run the container and open VSCode (or make it interactive)
CMD ["fish"]
