require 'minitest_helper'

describe Album do
  # - Relationships - #
  it 'must have many pictures' do
    pic   = Fabricate(:picture)
    album = Album.new
    album.must_respond_to :pictures
    [1, Object.new, false, ''].each do |o|
      proc { album.pictures << o }.must_raise ActiveRecord::AssociationTypeMismatch
      (album.pictures << pic).must_be_instance_of Array
    end
  end

  # - Validations - #
  it 'requires name to be set' do
    album = Fabricate.build :album, name: nil
    album.valid?.wont_equal true
    album.name = 'Some Album Name'
    album.valid?.must_equal true
  end

  it 'is public by default' do
    album = Album.new
    album.public.must_equal true
  end
end
