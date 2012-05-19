class Album < ActiveRecord::Base
  # - Default Scope - #
  default_scope order: 'name ASC'
  # - Relationships - #
  has_many :pictures

  # - Validations - #
  validates_presence_of :name
end
