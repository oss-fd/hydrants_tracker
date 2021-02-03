class Hydrant < ApplicationRecord
  include Discard::Model
  self.discard_column = :deleted_at

  enum hydrant_type: {
    wet: 0,
    dry: 1,
    tank: 2,
    muni: 3,
    unknown: 4
  }

  has_many :hydrant_checks, dependent: :destroy

  validates :name, presence: true
  validates :hydrant_type, presence: true

  def latitude
    coordinates.nil? ? nil : coordinates.latitude
  end

  def longitude
    coordinates.nil? ? nil : coordinates.longitude
  end

  def to_param
    guid
  end

  def set_coordinates(lng:, lat:)
    return if lng.blank? || lat.blank?

    if self.coordinates.blank?
      self.coordinates = "POINT(#{lng} #{lat})"
    else
      new_point = self.coordinates.factory.point(lng, lat)
      self.coordinates = new_point
    end
  end

  def last_hydrant_check
    hydrant_checks.order("created_at DESC").first
  end

  def out_of_service?
    !in_service # obvious. marked out of service for some reason
  end

  def needs_testing?
    needs_follow_up.present? || # hydrant marked as needing a follow up check
      last_tested_at.blank? || # never tested so assume out of service
      last_tested_at <= 2.years.ago.utc # hydrants that go > 24 months without a test
  end
end
