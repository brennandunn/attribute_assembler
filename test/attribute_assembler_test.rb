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

    should 'respond to extension methods' do
      assert @person.name.has_middle_name?
      assert_equal 'Doe', @person.name.surname
      assert @person.age.over_18?
    end
    
  end

end
