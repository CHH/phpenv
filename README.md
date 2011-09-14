# phpenv

[rbenv](https://github.com/sstephenson/rbenv) based version managment for PHP.

This is a small install script which sets up rbenv in a separate
directory for PHP versioning.

## Requirements

Git.

## Install

Clone this repository and run the `install.sh` on your shell.
Then add `~/.phpenv/bin` to your `PATH` and add `eval $(phpenv init -)`
to your `.bashrc`.

After that, the `phpenv` command should be available.
The `phpenv` command is exactly the same as `rbenv` except it operates
on the `~/.phpenv` directory.

To install versions just drop them to the `~/.phpenv/versions`
directory, just like in `rbenv`.

For convenienve you can use [php-build](https://github.com/CHH/php-build)
to do this with one command:

```
$ php-build 5.3.8 ~/.phpenv/versions/5.3.8
```

## Documentation

Please see the [rbenv](https://github.com/sstephenson/rbenv) Project
for documentation.

## Thanks

Thank you [Sam Stephenson](https://github.com/sstephenson) for creating
the awesome `rbenv`!
