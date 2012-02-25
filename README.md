# safe_nested_calls #

This gem allows you to safely call nested methods 
on an object, and not worry about whether or not
the methods are defined. It is very useful for 
managing dynamically created objects that may not
have some methods defined.

# Installation #

    gem install 'safe_nested_calls'
  
If you are using Rails, then it will automatically load 
on server start, but if not, somewhere in your code, put:

    require 'safe_nested_calls'

# Usage #

safe_nested_calls adds two extra methods to Object,
	
  `nested_respond_to?` and `safe_nested_method`.

### nested_respond_to? ###
		
	if object.nested_respond_to?(:one, :two, :three)
      
which is equivalent to

	if object.respond_to? :one
		if object.one.respond_to? :two
			object.one.two.respond_to? :three

  
### safe_nested_method ###

This method can call the actual nested method desired, with optional parameters

    object.safe_nested_method(:one, :two, :three) => returns object.one.two.three
      

#### Parameters #####

      
To use parameters, use a hash of :method => args, where args are the method arguments

    object.safe_nested_method(:one => 1, :two => [1, 2], :three => [1,2,3])
    
          
which is equivalent to (would throw NoMethodError if a method wasn't defined)

    object.one(1).two(1,2).three(1,2,3)

If you need to call of mix of methods with and without parameters, set the arguments for 
the methods without parameters to `:none`

    object.safe_nested_method(:get => :none, :increment => 4, :save => :none)
      
which is equivalent to (would throw NoMethodError if a method wasn't defined)

    object.get().increment(4).save()
