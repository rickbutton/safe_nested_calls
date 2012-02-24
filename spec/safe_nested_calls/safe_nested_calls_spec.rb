require 'spec_helper'
class A
	def do_magic(var)
		'magic ' << var
	end
end
class B
	attr_accessor :a
end
class C
	attr_accessor :b
end
class D
	attr_accessor :c
end		


describe 'SafeNestedCalls' do
	d = D.new
	d.c = C.new
	d.c.b = B.new
	d.c.b.a = A.new

	describe 'nested_respond_to?' do
		it 'should return true when the methods all exist' do
			d.nested_respond_to?(:c, :b, :a).should eq(true)
		end

		it 'should return false when a method does not exist' do
			d.nested_respond_to?(:c, :b, :LOL_DOESNT_EXIST).should eq(false)
		end
	end

	describe 'safe_nested_method' do
		it 'should return the nested object when the methods all exist (with no params)' do
			d.safe_nested_method(:c, :b, :a).should eq(d.c.b.a)
		end

		it 'should return nil when a method does not exist (with no params)' do
			d.safe_nested_method(:c, :b, :LOL_DOESNT_EXIST).should eq(nil)
		end

		it 'should return the nested object when the methods all exist (with params)' do
			d.safe_nested_method(:c=>:none, :b=>:none, :a => :none, :do_magic => ['tree house']).should eq('magic tree house')
		end

		it 'should return nil when a method does not exist (with params)' do
			d.safe_nested_method(:c=>:none, :b=>:none, :LOL_DOESNT_EXIST => ['death house']).should eq(nil)
		end

		it 'should raise an ArguementError when an incorrect parameter is sent' do
			expect { d.safe_nested_method Object.new }.should raise_error(ArgumentError)
		end
		it 'should raise an ArguementError when an incorrect parameter is sent (inside a hash)' do
			expect { d.safe_nested_method Object.new => :NOPE }.should raise_error(ArgumentError)
		end
	end
end