require 'minitest_helper'

describe 'Pictures integration' do
  describe 'Create a new picture' do
    before do
      login
      Fabricate(:album, name: 'Puerto Colombia')
      click_on 'Pictures'
      click_on 'New Picture'
    end

    it 'is created by giving the required fields' do
      image = File.join Rails.root, 'test', 'support', 'files', 'sunset.jpg'
      attach_file 'Picture', image
      select 'Puerto Colombia', from: 'Album'
      fill_in 'Caption', with: 'Sunset'
      click_on 'Save'
      page.text.must_include 'Picture was successfully created.'
      page.text.must_include 'Puerto Colombia'
      page.text.must_include 'Sunset'
    end

    it 'is not created when no picture is set' do
      fill_in 'Caption', with: 'Some caption'
      click_on 'Save'
      page.text.must_include "Picture can't be blank"
    end
  end

  describe 'Edit a picture' do
    before do
      login
      visit edit_picture_path(Fabricate(:picture))
    end

    it 'hides the Picture file field' do
      page.has_selector?('input#picture_pic').must_equal false
    end

    it 'shows a feedback message' do
      click_on 'Save'
      page.text.must_include 'Picture was successfully updated.'
    end

    it 'updates its information' do
      fill_in 'Caption', with: 'Taken in some random spot in the city'
      click_on 'Save'
      page.text.must_include 'Taken in some random spot in the city'
    end
  end

  describe 'Delete a picture' do
    before do
      login
      visit picture_path(Fabricate(:picture))
      click_on 'Delete'
    end

    it 'shows a feedback message' do
      page.text.must_include 'Picture was successfully destroyed.'
    end

    it 'takes the user to the pictures page' do
      current_path.must_equal pictures_path
    end
  end
end
