if @hydrant_check.persisted?
  json.status "ok"
  json.hydrant_check do
    json.(@hydrant_check, :id, :hydrant_id, :vegetation_overgrown, :tank_locked, :lock_operable, :prime_pulled, :circulated, :line_used, :minutes_pumped, :in_service, :notes, :approved_at, :created_at, :updated_at, :pump_operator_id, :apparatus_id, :needs_follow_up)
  end
  json.flash do
    json.success "Hydrant updated!"
  end
else
  json.status "error"
  json.flash do
    json.error @hydrant_check.errors.full_messages.join(", ")
  end
end
