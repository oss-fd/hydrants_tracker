module HydrantsDisplay
  extend ActiveSupport::Concern

  # TODO: remove this
  included do
    def display_icon
      if muni?
        "images/icons/marker--muni-hydrant.png"
      elsif out_of_service?
        "images/icons/marker--out-of-service.png"
      elsif needs_follow_up? || needs_testing?
        "images/icons/marker--needs-testing.png"
      else
        "images/icons/marker--in-service.png"
      end
    end

    def gmaps_position
      "#{latitude},#{longitude}"
    end

    def status_css_class
      if hydrant_checks.blank?
        "gray-5"
      elsif out_of_service?
        "red-5"
      elsif needs_testing?
        "yellow-5"
      else
        "green-5"
      end
    end
  end

  class_methods do
  end
end
