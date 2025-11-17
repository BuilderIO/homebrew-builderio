# Builder.io Dev-tools

## Installation

With [HomeBrew](https://brew.sh/) Installed run:

```bash
brew install builderio/dev-tools/dev-tools
```

## Usage

At the commmand line use `builderio` in place of `npx "@builder.io/devtools@latest"`. Documentation on the CLI can be found [here](https://www.builder.io/c/docs/builder-cli-api).

## Examples

```bash
builderio code
builderio auth
builderio auth status
builderio launch
```

## About Brew

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

### Alternative Installation
You can also install by running `brew tap builderio/builderio` and then `brew install dev-tools`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "builderio/dev-tools"
brew "<formula>"
```