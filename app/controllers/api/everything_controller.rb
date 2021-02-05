class Api::EverythingController < ApiController
  def show
    @hydrants = Hydrant.kept
    @hydrant_checks = HydrantCheck.kept
    @pump_operators = PumpOperator.kept
    @apparatus = Apparatus.kept
  end
end
