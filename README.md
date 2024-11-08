# sshc
This is a lightweight shell script wrapper that uses `jq` and `fzf` to manage known SSH hosts and keys.

# But why?
I'm fully aware that this can already be achieved using the SSH `config` file, where all the variables can be defined such as the `host`, `port` and `identityfile`. I'm even aware of a solution to use a simple function with `grep` and `fzf` to do the same thing as documented in [Andrés Villarreal's](https://dev.to/kaeruct/fzf-ssh-config-hosts-23dj) post.

However a few thoughts that lead me to creating this script:

- I have various git connections setup in the SSH config file that I wouldn't necessarily wish to list. I would now have to modify the file and the simple wrapper to exclude those
- I had wanted to play around with `jq` a bit to achieve my end goal
- I like the idea of storing the configuration in a JSON file

# Setup
Clone this repo to your local environment and rename `sample_config.json` to `config.json`. The file should be prepoulated with some dummy data, which can be used as a template to setuip your own configuration.

The `identityfile` is optional. If the user does not define it, the script will assume authentication is done via username and password and the user will be prompted to enter their credential.
