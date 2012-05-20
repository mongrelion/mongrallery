require 'minitest_helper'

describe User do
  it "requires name to be set" do
    user = Fabricate.build :user, :name => nil
    user.valid?.wont_equal true
  end

  it "knows if he is an admin" do
    user = Fabricate(:admin)
    user.is_admin?.must_equal true
  end

  it "knows if he is not an admin" do
    user = Fabricate(:user)
    user.is_admin?.must_equal false
  end
end
