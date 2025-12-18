# zen-mode-hyprland

is a small crystal cli tool that modificates hyprland config;
it does turn off: wallpapers(swww), borders, gaps, animations, borders, blur,
shadows, waybar

removing visual distractions while working and returning them when needed

!for now very unstable with large and complicated configs and does not
support modular configs.!

## Installation

for now if you want to use it, clone the repo, compile src/cli.cr;

```crystal
crystal build src/cli.cr --release -o zen-mode-hyprland
```

## Example

<div align="center">
     <img alt="showcase.gif" src="./showcase/showcase.gif" width="1184" height="666">
</div>

## Usage

```rust
./cli [-h | --help] [-i | --initiate] [-o | --off]

    -h, --help                       Print out this text
    -i, --initiate                   Initiate hyprland zen mode
    -o, --off                        Restore default hyprland config
```

## Development

TODO: Write development instructions here

## Contributing

 1. Fork it (<https://github.com/your-github-user/zen-mode-hyprland/fork>) -->
 2. Create your feature branch (`git checkout -b my-new-feature`) -->
 3. Commit your changes (`git commit -am 'Add some feature'`) -->
 4. Push to the branch (`git push origin my-new-feature`)
 5. Create a new Pull Request

## Contributors

- [zedddie](https://github.com/zedddie) - creator and maintainer
