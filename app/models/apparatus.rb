class Apparatus < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: [:deleted_at] }

  default_scope { where(deleted_at: nil) }

  has_many :hydrant_checks

  def to_param
    guid
  end
end