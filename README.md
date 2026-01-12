# SirRezi_wheels

A FiveM script that allows players to slash vehicle tires using a knife. Built with `ox_target` and `ox_lib` for optimal performance and modern UI.

## Features

*   **Target System**: Uses `ox_target` to interact specifically with vehicle wheels.
*   **Weapon Requirement**: Configurable list of weapons required to slash tires (default: Knife, Switchblade, Dagger).
*   **Animations**: Includes animations and progress bars via `ox_lib`.
*   **Localization**: Supports multiple languages (English and German included).
*   **Optimized**: Low resource usage (0.00ms idle).

## Dependencies

*   [ox_lib](https://github.com/overextended/ox_lib)
*   [ox_target](https://github.com/overextended/ox_target)

## Installation

1.  Download the script and put it in your `resources` directory.
2.  Add `ensure SirRezi_wheels` to your `server.cfg`.
3.  Ensure `ox_lib` and `ox_target` are started **before** this script.

## Configuration

You can configure the script in `config.lua`:

*   **Locale**: Change language (`'de'` or `'en'`).
*   **AllowedWeapons**: Add or remove weapons that can be used.
*   **Animation**: Adjust animation dictionary and duration.
*   **Target**: Change target icon and distance.

## Usage

1.  Equip a knife (or other configured weapon).
2.  Walk up to a vehicle tire.
3.  Use your target eye (usually Left Alt) on the wheel.
4.  Select "Slash Tire" / "Reifen zerstechen".

## License

This project is licensed under the MIT License.
