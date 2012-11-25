# phpenv

Sets up a separate rbenv environment for PHP

[man page](https://github.com/CHH/phpenv/blob/master/man/phpenv-install.1.ronn)


## SYNOPSIS

    phpenv-install.sh
    UPDATE=yes phpenv-install.sh

## DESCRIPTION

The `phpenv-install.sh` command sets up a separate rbenv 
environment for usage with PHP. This environment is 
stored in the `$HOME/.phpenv` directory and contains
a `phpenv` executable which sets the `RBENV_ROOT` 
environment variable to `$HOME/.phpenv`.

To install PHP versions, just put them to the `$HOME/.phpenv/versions`
directory. You can use [php-build](http://github.com/chh/php-build)
to do this with one command:

    $ php-build -i development 5.4.9 $HOME/.phpenv/versions/5.4.9
    $ phpenv versions
      5.4.9
    $ phpenv rehash
    $ phpenv global 5.4.9
    $ php --version
      PHP 5.4.9 (cli) (built: Nov 25 2012 17:27:10) 
      Copyright (c) 1997-2012 The PHP Group
      Zend Engine v2.4.0, Copyright (c) 1998-2012 Zend Technologies
          with Xdebug v2.2.1, Copyright (c) 2002-2012, by Derick Rethans

The `phpenv-install.sh` command has an optional 
"update" mode which updates the `$HOME/.phpenv` to 
the latest source code from the rbenv repository 
and creates a new `phpenv` executable.

This mode is triggered by setting the 
`UPDATE` environment variable before 
calling `phpenv-install.sh`, for example:

    $ UPDATE=yes phpenv-install.sh

Finally, enable phpenv in your shell by adding `$HOME/.phpenv/bin` and
`$HOME/.phpenv/shims` to your `PATH` and adding `eval "$(phpenv init -)"`
to your `$HOME/.bash_profile` or `$HOME/.bashrc` (or your shell's 
respective file) and restart your shell.

## IMPORTANT NOTES

- **For rbenv users**: Make sure that `~/.rbenv/bin` takes precedence
  in the `PATH` over `~/.phpenv/bin` by placing it before, so `rbenv` gets
  used from `~/.rbenv`.

-  You need to have `git` installed to run the `phpenv-install.sh` command.

## LICENSE
#
The MIT License

Copyright (c) 2011 Christoph Hochstrasser

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## SEE ALSO

[rbenv](http://github.com/sstephenson/rbenv)


[SYNOPSIS]: #SYNOPSIS "SYNOPSIS"
[DESCRIPTION]: #DESCRIPTION "DESCRIPTION"
[IMPORTANT NOTES]: #IMPORTANT-NOTES "IMPORTANT NOTES"
[LICENSE]: #LICENSE "LICENSE"
[SEE ALSO]: #SEE-ALSO "SEE ALSO"
