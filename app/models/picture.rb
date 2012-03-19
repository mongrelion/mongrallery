class Picture < ActiveRecord::Base
  # - Relationships - #
  belongs_to :album

  # - Validations - #
  validates_presence_of :pic

  # - Scopes - #
  scope :orphan, where(album_id: nil)

  # - CarrierWave - #
  mount_uploader :pic, PictureUploader

  # - Instance Methods - #
  def is_orphan?
    album_id.blank?
  end
end
