class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :ignore_non_json

  private

  def ignore_non_json
    return if request.format.to_s.match(/json/)

    head 404, "content_type": "text/plain"
  end
end
