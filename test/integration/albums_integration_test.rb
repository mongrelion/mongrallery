require 'minitest_helper'

describe 'Albums integration' do

  describe 'List' do
    it "does not show the 'New Album' button when the user is not logged in" do
      visit root_path
      click_on 'Albums'
      page.text.wont_include 'New Album'
    end

    it "does not show the 'New Album' button when the logged in user is not an admin" do
      login
      visit root_path
      click_on 'Albums'
      page.text.wont_include 'New Album'
    end

    it "shows the 'New Album' button when the logged in user is an admin" do
      login Fabricate(:admin)
      visit root_path
      click_on 'Albums'
      page.text.must_include 'New Album'
    end

    it 'shows public albums' do
      5.times { Fabricate(:album) }
      click_on 'Albums'
      Album.public.each { |album| page.text.must_include album.name }
    end

    it 'does not show private albums to guest users' do
      5.times { Fabricate(:album)         }
      3.times { Fabricate(:private_album) }
      visit root_path
      click_on 'Albums'
      page.has_css?('ul.albums li', count: 5).must_equal true
    end

    it 'shows all albums, public and private, when there is a logged in user' do
      5.times { Fabricate(:album)         }
      3.times { Fabricate(:private_album) }
      login
      visit root_path
      click_on 'Albums'
      page.has_css?('ul.albums li', count: 8).must_equal true
    end
  end

  describe 'Show an album' do
    it 'does not allow to access a private album to a guest user by any meanings' do
      private_album = Fabricate(:private_album)
      visit album_path private_album
      page.text.must_include "The page you were looking for doesn't exist"
    end

    it 'does not show the action buttons when the user is not logged in' do
      Fabricate(:album)
      visit root_path
      click_on 'Albums'
      page.text.wont_include 'Edit'
      page.text.wont_include 'Destroy'
    end

    it 'does not show the action buttons when the logged in user is not an admin' do
      album = Fabricate(:album, name: 'Summer 2012')
      login
      click_on 'Albums'
      page.text.wont_include 'Edit'
      page.text.wont_include 'Destroy'
      page.find('ul.albums li a:first').click
      current_path.must_equal album_path(album)
      page.text.wont_include 'Edit'
      page.text.wont_include 'Destroy'
    end

    it 'shows the action buttons when the logged in user is an admin' do
      Fabricate(:album)
      login Fabricate(:admin)
      click_on 'Albums'
      page.text.must_include 'Edit'
      page.text.must_include 'Destroy'
      page.find('ul.albums li a:first').click
      page.text.must_include 'Edit'
      page.text.must_include 'Destroy'
    end
  end

  describe 'Create a new album' do
    before do
      login Fabricate(:admin)
      visit new_album_path
    end

    it 'is created by giving the proper information' do
      fill_in  'Name',        with: 'Woodstock'
      fill_in  'Description', with: 'Kick-arse music festival'
      click_on 'Save'
      page.text.must_include 'Album was successfully created.'
      page.text.must_include 'Woodstock'
    end

    it 'is not created when no name is given' do
      fill_in 'Name',        with: ''
      fill_in 'Description', with: 'Some description'
      click_on 'Save'
      page.text.must_include 'prohibited this album from being saved'
      page.text.must_include "Name can't be blank"
    end
  end

  describe 'Edit an album' do
    it "can't be accessed if the user is not logged in" do
      album = Fabricate(:album)
      visit edit_album_path(album)
      page.text.must_include 'You need to sign in or sign up before continuing.'
    end

    it "can't be accessed if the logged in user is not an admin" do
      login
      album = Fabricate(:album)
      visit edit_album_path(album)
    end

    it 'can be accessed when the user is logged in' do
      login Fabricate(:admin)
      album = Fabricate(:album)
      visit edit_album_path(album)
      page.text.must_include 'Editing album'
    end
  end

  describe 'Delete an album' do
    before do
      login Fabricate(:admin)
      album = Fabricate(:album)
      visit album_path(album)
      click_on 'Destroy'
    end

    it 'takes the user to the albums list' do
      page.text.must_include 'Album was successfully destroyed.'
    end

    it 'shows a feedback message' do
      page.text.must_include 'Album was successfully destroyed.'
    end
  end
end
