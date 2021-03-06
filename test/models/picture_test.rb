require 'minitest_helper'

describe Picture do
  it "validates presence of pic" do
    picture = Fabricate.build :picture, :pic => nil # With no pic
    picture.valid?.wont_equal true
    picture = Fabricate.build :picture              # With a pic
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
    3.times { orphan_pictures << Fabricate(:picture, :album => nil) }
    2.times { pictures_from_the_house << Fabricate(:picture)     }
    Picture.orphan.must_equal orphan_pictures
  end

  # - Callbacks - #
  it 'generates its 32 characters length slug when being created' do
    picture = Fabricate.build :picture
    picture.slug.blank?.must_equal true
    picture.save!
    picture.slug.blank?.must_equal false
    picture.slug.must_be_instance_of String
    picture.slug.length.must_equal 32
  end

  # - Scopes - #
  it 'knows how to retrieve public pictures' do
    public_picture1, public_picture2 = Fabricate(:picture), Fabricate(:picture)
    private_picture = Fabricate(:picture, :album => Fabricate(:private_album))
    Picture.public_pics.must_include public_picture1
    Picture.public_pics.must_include public_picture2
    Picture.public_pics.wont_include private_picture
  end

  # - Instance Methods - #
  it "knows when it is an orphan" do
    picture = Fabricate(:picture, :album => nil)
    picture.is_orphan?.must_equal true
  end

  it 'knows when it is a public picture' do
    picture = Picture.new
    picture.is_public?.must_equal true

    picture = Fabricate(:picture, :album => Fabricate(:album))
    picture.is_public?.must_equal true

    picture = Fabricate(:picture, :album => Fabricate(:private_album))
    picture.is_public?.must_equal false
  end

end
