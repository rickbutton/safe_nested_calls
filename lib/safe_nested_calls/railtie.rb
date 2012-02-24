module SafeNestedCalls
  class Railtie < Rails::Railtie
    initializer "my_railtie.configure_rails_initialization" do |app|
    	require 'safe_nested_calls'
  	end
  end
end