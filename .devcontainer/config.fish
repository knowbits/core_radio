# Fish shell configuration
set -g fish_greeting "" # Disable greeting

# Path additions

# Set PATH to include "/workspace"
# fish_add_path /workspace
# NOT NEEDED: fish_add_path /usr/local/bin

# Set US language and locale
# set -x LANG en_US.UTF-8
# set -x LC_ALL en_US.UTF-8

# Set GB locale (British English)
set -gx LANG en_GB.UTF-8
set -gx LANGUAGE en_GB:en
set -gx LC_ALL en_GB.UTF-8

# Set the timezone (if you want to configure it in the shell as well)
set -x TZ Europe/London

set -x TERM xterm-256color

# Fish automatically enables colorized output for commands like ls, grep, and others
# set -x LS_COLORS 'di=34:ln=36:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=37;41:sg=37;45:tw=30;42:ow=30;43'

# Check if the shell is interactive
if status --is-interactive
    # Only run the following commands in interactive shells

    # Configure the "Tide" prompt according to my prefrences (from running the "tide configure" interactive tool)
    # NOTE: For now, we set the "Dracula" theme in the "Dockerfile"
    # tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Light --show_time='24-hour format' --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Few icons' --transient=No
    
    # Load the "Dracula" theme for Fish shell
    # NOTE: For now, we set the "Dracula" theme in the "Dockerfile"
    # fish_config theme choose "Dracula Official"

    # Source Fisher plugin manager if available
    if test -f ~/.config/fish/functions/fisher.fish
        # NOT NEEDED: source ~/.config/fish/functions/fisher.fish
    end
      
    # Source Fisher if it is installed
    if type -q fisher
        # Update Fisher plugins (if Fisher is installed):
        # NOT NEEEDED: fisher update
    end
    
    # Define Aliases
    abbr ll 'ls -alF'
    abbr la 'ls -A'
    abbr l 'ls -CF'
    // abbr --add ls 'eza --icons --group-directories-first'
    // abbr --add ll 'eza --icons --group-directories-first -l'

    # Define custom Fish functions (if needed)
    
    # function ll
    #     ls -lh $argv
    # end
    
end  # END: --is-interactive
