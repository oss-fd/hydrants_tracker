class Api::HydrantChecksController < ApiController
  def create
    @hydrant_check = hydrant.hydrant_checks.build(create_params)

    if @hydrant_check.save && true # TODO: make auto-approval a configurable setting
      @hydrant_check.approve!
    end

    render status: (@hydrant_check.persisted? ? 200 : 422)
  end

  private

  def format_errors(check)
    check.errors.reduce({}) do |hash, error_pair|
      hash[error_pair[0].to_s.camelize(:lower)] = error_pair[1]
      hash
    end
  end

  def create_params
    params.require(:hydrant_check).permit(
      :vegetation_overgrown,
      :tank_locked,
      :lock_operable,
      :prime_pulled,
      :circulated,
      :line_used,
      :minutes_pumped,
      :in_service,
      :notes,
      :pump_operator_id,
      :apparatus_id,
      :needs_follow_up
    )
  end

  def hydrant
    Hydrant.find(params[:hydrant_id])
  end
  helper_method :hydrant
end
