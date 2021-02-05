json.hydrants(@hydrants) do |hydrant|
  json.(hydrant, :id, :name, :hydrant_type, :staff_notes, :last_check_note, :needs_follow_up)
  json.position do
    json.lat hydrant.latitude
    json.lng hydrant.longitude
  end
  json.tank_capacity hydrant.tank_capacity if hydrant.tank?
  json.last_tested_at  hydrant.last_tested_at&.in_time_zone("Eastern Time (US & Canada)")
  json.out_of_service hydrant.out_of_service?
  json.needs_testing hydrant.needs_testing?
  json.icon hydrant.display_icon
end
json.hydrant_checks @hydrant_checks do |hydrant_check|
  json.partial! 'api/hydrant_checks/show', hydrant_check: hydrant_check
end
json.pump_operators(@pump_operators) do |pump_operator|
  json.(pump_operator, :id, :name, :email_address, :phone_number)
end
json.apparatus(@apparatus) do |apparatus|
  json.(apparatus, :id, :name)
end
