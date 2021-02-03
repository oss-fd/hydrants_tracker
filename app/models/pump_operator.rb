class PumpOperator < ApplicationRecord
  include Discard::Model
  self.discard_column = :deleted_at

  validates :name, presence: true, uniqueness: { scope: [:deleted_at] }
  validates :email_address, uniqueness: { allow_nil: true, allow_blank: true, scope: [:deleted_at] }

  self.default_scope { where(deleted_at: nil) }

  has_many :hydrant_checks

  def to_param
    guid
  end
end
