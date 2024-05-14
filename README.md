
# My Personal NixOS config
This is my personal nixos configuration. It is an attempt at a modular nix config structure to support multiple machines and even users. I've taken a fair amount of inspiration from [EmergentMind's config](https://github.com/EmergentMind/nix-config), as well as a heap of others I can't recall.
However, this config is separated from the home configuration; **it is only a system config!** I use it in conjunction with my home manager config found in my dotfiles repo.

**This config**:
- Is _just_ a NixOS system config, very barebones and no user config (apart from initial setup)
- Uses flakes
- Is meant to be used with home manager as a standalone, non-root utility

> [!TIP]
> Feel free to take inspiration from this config as I have from others.

## Bootstrapping
As a reminder to myself and as a resource to anyone seeking inspiration, here is the bootstrapping process:

1. Get an ISO from [here](https://nixos.org/download/#)
2. Follow the installation steps, with or without a desktop environment (we'll install our own in a moment anyway)
3. If it wasn't in your ISO of choice, fetch git using nixpkgs, like so:
    ```sh
    $ nix-shell -p git
    ```
    
    ...or add it to the default nixos config and rebuild
4. Move to where you want your config. It can be anywhere, I currently have it in `~/nixos-config` (meaning I would run git clone in `~/`)
5. Clone the repo:
   ```sh
   $ git clone git@github.com:otytlandsvik/nixos-config.git
   ```
6. Create a host specific config to bootstrap the new host under `nixos-config/hosts`. Simply copy another config as a template and setup specifics accordingly
7. If you need another user, create one by using `nixos/config/users/ole` as a template
8. Add the new host as an output in the flake
9. Rebuild referencing this new output (as an example, if the new output was `hostname`:
   ```sh
   $ sudo nixos-rebuild switch --flake .#hostname
   ```
> [!NOTE]
> The `.` here specifies the cwd. It must be a path to the directory containing the `flake.nix` file, followed by `#hostname`


#### Now, if you opted for sway as the window manager, run
```sh
$ exec sway
```
to start it. That's it for the system config!

### Home manager config
To bootrap the home configuration for my user, follow the steps in my dotfiles repo.
