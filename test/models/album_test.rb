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
    album = Fabricate.build :album, :name => nil
    album.valid?.wont_equal true
    album.name = 'Some Album Name'
    album.valid?.must_equal true
  end

  it 'is public by default' do
    album = Album.new
    album.public.must_equal true
  end

  it 'sorts albums by name in ascendent order by default' do
    %w[ Oranges Strawberries Lemons Kiwis ].each do |name|
      Album.create :name => name
    end
    Album.all.map(&:name).must_equal %w[ Kiwis Lemons Oranges Strawberries ]
  end

  it 'knows how to retrieve public albums' do
    public_album  = Fabricate(:album)
    private_album = Fabricate(:private_album)
    Album.public.must_include public_album
    Album.public.wont_include private_album
  end

  it 'knows when it is public' do
    public_album  = Album.new :public => true
    private_album = Album.new :public => false
    public_album.is_public?.must_equal true
    private_album.is_public?.must_equal false
  end
end
