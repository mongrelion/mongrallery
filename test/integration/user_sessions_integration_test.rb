require 'minitest_helper'

describe "User sessions integration" do
  describe "Login" do
    before do
      visit new_user_session_path
    end

    describe "Fail" do
      it "shows an error message when the email is wrong" do
        user = Fabricate(:user)
        fill_in 'Email',    with: 'foo@bar.com'
        fill_in 'Password', with: user.password
        click_on 'Sign in'
        page.text.must_include 'Invalid email or password.'
      end

      it "shows an error message when the password is wrong" do
        user = Fabricate(:user)
        fill_in 'Email',    with: user.email
        fill_in 'Password', with: 'w0rngp@ssw0rd'
        click_on 'Sign in'
        page.text.must_include 'Invalid email or password.'
      end
    end

    describe "Success" do
      before do
        user = Fabricate(:user)
        fill_in 'Email',    with: user.email
        fill_in 'Password', with: user.password
        click_on 'Sign in'
      end

      it "shows a welcome message given the right credentials" do
        page.text.must_include 'Logged in successfully'
      end

      it "shows a logout link" do
        page.text.must_include 'Logout'
      end
    end
  end

  describe "Logout" do
    before do
      user = Fabricate(:user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Sign in'
    end
    it "shows a feedback message when logged out" do
      click_on 'Logout'
      page.text.must_include 'Logged out successfully.'
    end
  end
end
