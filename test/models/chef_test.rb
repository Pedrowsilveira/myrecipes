require 'test_helper'

class ChefTest <ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Pedro", email: "pedro@exemplo.com")
  end
  
  test "chef should be present" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname length too long" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "chefname too short" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "email should be present" do 
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "example.com"
    assert_not @chef.valid?
  end

  test "email must be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid email" do
    valid_adresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_adresses.each do |va| 
      @chef.email = va
      assert @chef.valid? '#{va.inspect} should be valid'
    end
  end
  
  test "email validation should reject invalid email" do
    invalid_adresses = %w[user@example,com R_TDD-DS_eee.hello.org user@example. first.last@i_am_.com foo@some+monk.cm]
    invalid_adresses.each do |ia| 
      @chef.email = ia
      assert_not @chef.valid? '#{ia.inspect} should be invalid'
    end
  end
  
end