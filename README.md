# Command Unit
Lightweight test runner, primarily written to support development of [Righteous Git Hooks](http://github.com/samsalisbury/righteous-git-hooks).

Written in Ruby, designed to test command line apps, whether they're written in Ruby, Shell, Bash, C#, Java, whatever ;)

## Design goals:
* As few dependencies as possible
* Should be self-testing
* Suitable for testing command line tools

Tests are written in Command Unit itself, so no need for any external dependencies yet. I might make this a fundamental requirement of future development, but I'll see how far the project can go on basic Ruby first.

## This is alpha software
So far I've only tested this on Ruby 1.9.3, others may work but I'm not considering support on any other platforms until I've got a stable/useful release out. The code itself is very rough-and ready, and could benefit from quite a lot of refactoring, especially in [scenario.rb](/samsalisbury/command-unit/blob/master/lib/command-unit/scenario.rb).

## Features
- No dependencies apart from Ruby itself
- Assertion helpers (these need work)
- Clear, readable, colour console output
- All command-unit tests written using command-unit itself
- Expectations require a description, making test more useful as documentation
- Hooks, you can inject your own code easily to respond to tests running/passing/failing.
- 

## Minimalist usage example
 ```ruby
require 'command-unit'
include CommandUnit
scenario 'Writing tests in Command Unit' do
	
	when_i 'do something wacky' do |context|
		context[:data] = 'call a method or something here'
	end

	i_expect "to receive a string containing 'or' do |context|
		expect context[:data], &contains('or')
	end

	i_expect "the string to exactly equal 'or'" do |context|
		expect context[:data], &is_equal_to('or')
	end

end

run
```
Output:
```
Running 1 scenarios...

Running scenario 1: Writing tests in Command Unit
	When I do something wacky
		I expect to receive a string containing 'or'...Success! 
		I expect the string to exactly equal 'or'...Failure!
Expecting exactly 'or', but got 'call a method or something here'
Scenario 1 finished, 1 tests, 2 expectations with 1 successful and 1 failures.

Ran 1 scenarios, 0 passed, 1 failed (tests passed: 0, failed: 1) (expectations passed: 1, failed: 1)
```

## Installation
`gem install command-unit`

## Development
Unpack the gem with `gem unpack command-unit`
Run tests:
```
    $ cd command-unit-0.0.3
    $ ruby test/test.rb
```

## More?
This is fairly experimental, and I know a lot of people probably won't like it, or will think it needless (why not just use rspec?!), but it satisfies a need I have right now, and I'm happy so far.

I'd really love to hear any constructive criticism on both the code and the conventions in test-writing that command-unit enforces, you can email me at samsalisbury@gmail.com