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

    should 'work correctly with #respond_to?' do
      assert @person.name.respond_to?(:has_middle_name?)
    end

    should 'have extension methods do the right thing' do
      assert @person.name.has_middle_name?
      assert_equal 'Doe', @person.name.surname
      assert @person.age.over_18?
    end
    
  end
  
  context 'applying to multiple attributes' do
    
    setup do
      @credit_card = CreditCard.create :cc_type => 'Visa', :cc_number => '1234567890', :alt_cc_number => '0987654321'
    end
    
    should 'have #mask on both cc_number fields' do
      assert @credit_card.cc_number.respond_to?(:mask)
      assert @credit_card.alt_cc_number.respond_to?(:mask)
    end
    
    should 'have #mask work correctly on both attributes' do
      assert_equal '******7890', @credit_card.cc_number.mask
      assert_equal '******4321', @credit_card.alt_cc_number.mask
    end
    
  end
  
  should 'not break if the attribute changes for the instance' do
    assert_equal 'Doe', @person.name.surname
    
    @person.name = 'John Smith'
    assert_equal 'Smith', @person.name.surname
    assert ! @person.name.has_middle_name?
  end

end
