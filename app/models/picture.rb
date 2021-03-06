class Picture < ActiveRecord::Base
  # - Relationships - #
  belongs_to :album

  # - Validations - #
  validates_presence_of :pic

  # - Scopes - #
  scope :orphan, where(:album_id => nil)
  scope :public_pics, joins(:album).where('albums.public = ?', true)

  # - Callbacks - #
  before_create :generate_slug

  # - CarrierWave - #
  mount_uploader :pic, PictureUploader

  # - Mass-assignment protected attributes
  attr_protected :slug

  # - Instance Methods - #
  def is_orphan?
    album_id.blank?
  end

  def is_public?
    album ? album.is_public? : true
  end

  private

    def generate_slug
      self.slug = Digest::MD5.hexdigest Time.now.to_i.to_s
    end
end
