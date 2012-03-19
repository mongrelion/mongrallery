require 'minitest_helper'

describe 'Albums integration' do

  describe 'Create a new album' do
    before do
      login
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

    it 'can be accessed when the user is logged in' do
      login
      album = Fabricate(:album)
      visit edit_album_path(album)
      page.text.must_include 'Editing album'
    end
  end

  describe 'Delete an album' do
    before do
      login
      album = Fabricate(:album)
      visit album_path(album)
      click_on 'Delete'
    end

    it 'takes the user to the albums list' do
      page.text.must_include 'Album was successfully destroyed.'
    end

    it 'shows a feedback message' do
      page.text.must_include 'Album was successfully destroyed.'
    end
  end

  describe 'List albums' do
    it 'shows a list of albums' do
      login
      5.times { Fabricate(:album) }
      click_on 'Albums'
      Album.all.each { |a| page.text.must_include a.name }
    end
  end
end
