# Command Unit
Lightweight test runner, primarily written to support development of [Righteous Git Hooks](http://github.com/samsalisbury/righteous-git-hooks).

Written in Ruby, designed to test command line apps, whether they're written in Ruby, Shell, Bash, C#, Java, whatever ;)

## Design goals:
* As few dependencies as possible
* Should be self-testing
* Suitable for testing command line tools

Tests are written in Command Unit itself, so no need for any external dependencies yet. I might make this a fundamental requirement of future development, but I'll see how far the project can go on basic Ruby first.

## This is alpha software
So far I've only tested this on Ruby 1.9.3, others may work but I'm not considering support on any other platforms until I've got a stable/useful release out.

## Installation
`gem install command-unit`

## Development
Unpack the gem with `gem unpack command-unit`
Run tests:
    $ cd command-unit-0.0.1
    $ ruby test/test.rb