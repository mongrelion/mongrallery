require 'minitest_helper'

describe 'Pictures integration' do

  describe 'Show a picture' do
    it 'shows a link to the parent album if present' do
      album = Fabricate(:album, :name => 'Summer 2012')
      Fabricate(:picture, :album => album)
      visit root_path
      click_on 'Pictures'
      page.find('ul.pictures li a:first').click
      page.text.must_include 'Summer 2012'
      click_on 'Summer 2012'
      current_path.must_equal album_path(album)
    end

    it 'does not allow to access a private picture to a guest user by any meanings' do
      picture = Fabricate(:picture, :album => Fabricate(:private_album))
      visit picture_path picture
      page.text.must_include "The page you were looking for doesn't exist"
    end
  end

  describe 'List' do
    it 'does not show pictures from private albums for guest users' do
      2.times { Fabricate(:picture) }
      Fabricate(:picture, :album => Fabricate(:private_album))
      click_on 'Pictures'
      page.has_selector?('ul.pictures li', :count => 2).must_equal true
    end

    it 'shows a list of all the pictures for logged in users' do
      3.times { Fabricate(:picture)                                      }
      3.times { Fabricate(:picture, :album => Fabricate(:private_album)) }
      login
      click_on 'Pictures'
      page.has_selector?('ul.pictures li', :count => 6).must_equal true
    end

    it 'does not show "New Picture" button when no user is signed in' do
      menu_click_on 'Pictures'
      page.text.wont_include 'New Picture'
    end

    it 'does not show the "New Picture" button when the current user is not admin' do
      login
      menu_click_on 'Pictures'
      page.text.wont_include 'New Picture'
    end

    it 'shows the "New Picture" button when the current user is admin' do
      login Fabricate(:admin)
      menu_click_on 'Pictures'
      page.text.must_include 'New Picture'
    end

    it 'does not show action links for pictures when there is no logged in user' do
      Fabricate(:picture)
      click_on 'Pictures'
      page.text.wont_include 'Edit'
      page.text.wont_include 'Destroy'
      page.find('ul.pictures li a:first').click
      page.text.wont_include 'Edit'
      page.text.wont_include 'Destroy'
    end

    it 'does not show action links for pictures when the logged in user is not an admin' do
      Fabricate(:picture)
      login
      click_on 'Pictures'
      page.text.wont_include 'Edit'
      page.text.wont_include 'Destroy'
      page.find('ul.pictures li a:first').click
      page.text.wont_include 'Edit'
      page.text.wont_include 'Destroy'
    end

    it 'shows action links for pictures when the logged in user is an admin' do
      Fabricate(:picture)
      login Fabricate(:admin)
      click_on 'Pictures'
      page.text.must_include 'Edit'
      page.text.must_include 'Destroy'
      page.find('ul.pictures li a:first').click
      page.text.must_include 'Edit'
      page.text.must_include 'Destroy'
    end
  end

  describe 'Create a new picture' do
    before do
      login Fabricate(:admin)
      Fabricate(:album, :name => 'Puerto Colombia')
      menu_click_on 'Pictures'
      click_on 'New Picture'
    end

    it 'is created given the required information' do
      image = File.join Rails.root, 'test', 'support', 'files', 'sunset.jpg'
      attach_file 'Picture', image
      select 'Puerto Colombia', :from => 'Album'
      fill_in 'Caption', :with => 'Sunset'
      click_on 'Save'
      page.text.must_include 'Picture was successfully created.'
      page.text.must_include 'Puerto Colombia'
      page.text.must_include 'Sunset'
    end

    it 'is not created when no picture is set' do
      fill_in 'Caption', :with => 'Some caption'
      click_on 'Save'
      page.text.must_include "Picture can't be blank"
    end
  end

  describe 'Edit a picture' do
    before do
      login Fabricate(:admin)
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
      fill_in 'Caption', :with => 'Taken in some random spot in the city'
      click_on 'Save'
      page.text.must_include 'Taken in some random spot in the city'
    end
  end

  describe 'Delete a picture' do
    before do
      login Fabricate(:admin)
      visit picture_path(Fabricate(:picture))
      click_on 'Destroy'
    end

    it 'shows a feedback message' do
      page.text.must_include 'Picture was successfully destroyed.'
    end

    it 'takes the user to the pictures page' do
      current_path.must_equal pictures_path
    end
  end
end
