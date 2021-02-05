class Apparatus < ApplicationRecord
  include Discard::Model
  self.discard_column = :deleted_at

  validates :name, presence: true, uniqueness: { scope: [:deleted_at] }

  has_many :hydrant_checks

  def to_param
    guid
  end
end
