class HydrantCheck < ApplicationRecord
  include Discard::Model
  self.discard_column = :deleted_at

  enum line_used: {
    "1 1/2": 1,
    "1 3/4": 0, # 1 3/4" is the most common hand line
    "2 1/2": 2,
    "3": 3,
    "4": 4,
    "5": 5
  }

  belongs_to :hydrant
  belongs_to :apparatus
  belongs_to :pump_operator

  validates :hydrant, presence: true
  validates :line_used, presence: true, if: -> { in_service && !needs_follow_up && hydrant.tank? }
  validates :minutes_pumped, numericality: { greater_than: 0 }, allow_blank: -> { in_service && !needs_follow_up }
  validates :minutes_pumped, presence: true, if: -> { in_service && !needs_follow_up }
  validates :notes, presence: true, unless: -> { in_service && !needs_follow_up }
  validates :pump_operator_id, presence: true
  validates :apparatus_id, presence: true

  def approve!
    touch(:approved_at)

    if needs_follow_up
      hydrant.update(last_check_note: notes, needs_follow_up: 1.week.from_now, in_service: in_service) # default to 1 week
    else
      hydrant.update(last_check_note: notes, last_tested_at: created_at, in_service: in_service, needs_follow_up: nil)
    end
  end
end
