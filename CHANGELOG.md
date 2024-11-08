# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.3] - 2024-11-07
### Added

- Validation check that the `config.json` file exists before running the script
- Validation check if the user inputs an invalid connection and thus the `$index` is empty

### Changed

- Updated `README.md` with additional details and setup instructions
- Minor styling changes to how the `fzf` dialog box is presented

## [0.0.2] - 2024-11-05
### Changed

- Changed how `config.json` is read and contained in the variable

### Fixed

- Issue with retrieving key for selected value in `fzf`
- Issue related to index errors in pulling data from the config file

### Removed

- `echo` commands that displayed various variable data points
- Removed the need to `cat` the file out and piping to `jq`

## [0.0.1] - 2024-11-04
### Added

- Initial commit
