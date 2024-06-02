# some useful variables to set:
#
# For gnome and `systemctl --user enable gcr-ssh-agent.socket`
# set -Ux SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
#
# For kde and `systemctl --user enable ssh-agent`
# set -Ux SSH_AUTH_SOCK /run/user/1000/ssh-agent.socket
#
# set -Ux EDITOR nvim
# set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
# set -Ux MANROFFOPT -c


if status is-interactive
  # Commands to run in interactive sessions can go here
end
