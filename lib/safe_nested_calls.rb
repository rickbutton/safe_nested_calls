require "safe_nested_calls/version"
require "safe_nested_calls/railtie" if defined? Rails

module NestedRespondTo
	def nested_respond_to?(*methods)
	  if nil? || methods.empty?
	    true
	  else
	    method = methods.shift
	    if self.respond_to?(method)
	      self.send(method).nested_respond_to?(*methods)
	    else
	      false
	    end
	  end
	end

	def safe_nested_method(*params)
		p = params
		if params.respond_to?(:size) && params.size == 1 && params[0].is_a?(Hash)
			p = params[0]
		end

		if p.empty?
			return self
		end

		if p.is_a? Array
			name = p.shift
			if name.class != Symbol
				raise ArgumentError, 'Parameters must be symbols'
			end
			if self.respond_to?(name)
				self.send(name).safe_nested_method(*p)
			else
				return nil
			end
		elsif p.is_a? Hash
			name, args = p.shift
			if name.class != Symbol
				raise ArgumentError, 'Parameters must be symbols'
			end
			if self.respond_to?(name)
				if args == :none
					self.send(name).safe_nested_method(*[p])
				else
					self.send(name, *args).safe_nested_method(*p)
				end
			else
				return nil
			end
		end
  end
end

Object.send(:include, NestedRespondTo)
