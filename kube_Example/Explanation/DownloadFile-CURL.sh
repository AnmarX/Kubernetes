# for win

wget https://raw.githubusercontent.com/torvalds/linux/master/README

# linux

curl -O https://raw.githubusercontent.com/torvalds/linux/master/README

# shortcut
# -L: Follows any redirects.
# -O: Saves the file with the same name (README).

# -L (or --location):
# Instructs curl to follow redirects.
# If the URL you request returns a 301 or 302 redirect, curl will automatically follow the new URL.
# This is useful because some URLs may redirect to a different location (e.g., GitHub raw URLs).

# -O (or --remote-name):
# Saves the file with the same name as the original file from the URL.
# For example, if you download https://raw.githubusercontent.com/torvalds/linux/master/README, it will save the file locally as README.
