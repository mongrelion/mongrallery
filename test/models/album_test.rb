require 'minitest_helper'

describe Album do
  it "requires name to be set" do
    album = Fabricate.build :album, name: nil
    album.valid?.wont_equal true
    album.name = 'Some Album Name'
    album.valid?.must_equal true
  end

  it "is public by default" do
    album = Album.new
    album.public.must_equal true
  end
end
