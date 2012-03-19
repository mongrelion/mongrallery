require 'minitest_helper'

describe Picture do
  it "validates presence of pic" do
    picture = Fabricate.build :picture, pic: nil # With no pic
    picture.valid?.wont_equal true
    picture = Fabricate.build :picture           # With a pic
    picture.valid?.must_equal true
  end

  it "must belong to a album" do
    album   = Fabricate(:album)
    picture = Fabricate(:picture)
    picture.must_respond_to :album
    [1, Object.new, 'foo'].each do |o|
      proc { picture.album = o }.must_raise ActiveRecord::AssociationTypeMismatch
    end
    (picture.album = album).must_be_instance_of Album
  end

  # - Scopes - #
  it "knows how to retrieve orphan a.k.a. albumless pictures" do
    orphan_pictures         = []
    pictures_from_the_house = []
    3.times { orphan_pictures << Fabricate(:picture, album: nil) }
    2.times { pictures_from_the_house << Fabricate(:picture)     }
    Picture.orphan.must_equal orphan_pictures
  end

  # - Instance Methods - #
  it "knows when it is an orphan" do
    picture = Fabricate(:picture, album: nil)
    picture.is_orphan?.must_equal true
  end
end
