ENV["RAILS_ENV"] = 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require "minitest/pride"
require "capybara/rails"

# Clean that database before each step is run
DatabaseCleaner.strategy = :truncation
class MiniTest::Spec
  before :each do
    DatabaseCleaner.clean
  end
end

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  register_spec_type /integration$/, self

  def smtp
    save_and_open_page
  end

  def login(user = nil)
    user ||= Fabricate(:user)
    visit destroy_user_session_path
    visit new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
    page.text.must_include 'Logged in successfully.'
  end

  def menu_click_on(link)
    within('ul.nav.menu') { click_link link }
  end
end
