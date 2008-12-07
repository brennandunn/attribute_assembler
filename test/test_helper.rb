require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require 'shoulda'
require 'quietbacktrace'

require 'attribute_assembler'

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__)+'/debug.log')
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'

class AttributeAssembler::TestCase < ActiveSupport::TestCase
  
  def setup_environment
    setup_database
  end
  
  
  protected
  
  def setup_database
    ActiveRecord::Base.class_eval do
      silence do
        connection.create_table :people, :force => true do |t|
          t.string    :name
          t.integer   :age
        end
      end
    end
  end
  
end

class Person < ActiveRecord::Base
  
  with_attribute :name do
    
    def has_middle_name?
      self.split(' ').size == 3
    end
    
    def surname
      self.split(' ').last
    end
    
  end
  
  
  with_attribute :age do
    
    def over_18?
      self >= 18
    end
    
  end
  
end