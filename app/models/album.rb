class Album < ActiveRecord::Base
  # - Relationships - #
  has_many :pictures

  # - Validations - #
  validates_presence_of :name
end
