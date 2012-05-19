class Album < ActiveRecord::Base
  # - Default Scope - #
  default_scope order: 'name ASC'

  # - Scopes - #
  scope :public, where(public: true)

  # - Relationships - #
  has_many :pictures

  # - Validations - #
  validates_presence_of :name

  # - Instance Methods - #
  def is_public?
    public?
  end
end
