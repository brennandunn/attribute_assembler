require 'test_helper'

class AttributeAssemblerTest < AttributeAssembler::TestCase

  def setup
    setup_environment
    @person = Person.create :name => 'John C. Doe', :age => 30
  end

  context 'Applying the proxy class to attributes' do
    
    should 'act like the overwritten field' do
      assert @person.name.is_a?(String)
    end
    
    should 'be transparent' do
      assert_equal 'John C. Doe', @person.name
    end

    should 'respond to extension methods' do
      assert @person.name.has_middle_name?
      assert_equal 'Doe', @person.name.surname
      assert @person.age.over_18?
    end
    
  end
  
  should 'not break if the attribute changes for the instance' do
    assert_equal 'Doe', @person.name.surname
    
    @person.name = 'John Smith'
    assert_equal 'Smith', @person.name.surname
    assert ! @person.name.has_middle_name?
  end

end
