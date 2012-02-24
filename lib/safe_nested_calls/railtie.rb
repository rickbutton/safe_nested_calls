module SafeNestedCalls
  class Railtie < Rails::Railtie
    initializer "SafeNestedCalls" do |app|
    	require 'safe_nested_calls'
  	end
  end
end