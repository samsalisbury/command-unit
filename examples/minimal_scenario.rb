require_relative '../lib/command-unit'
include CommandUnit

scenario 'Writing tests in Command Unit' do
	
	when_i 'do something wacky' do |context|
		context[:data] = 'call a method or something here'
	end

	i_expect "to receive a string containing 'or'" do |context|
		expect context[:data], &contains('or')
	end

	i_expect "the string to exactly equal 'or'" do |context|
		expect context[:data], &is_equal_to('or')
	end

end

run