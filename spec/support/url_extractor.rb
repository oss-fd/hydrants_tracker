def extract_url_from_email_with_text(email:, text:)
  html = Nokogiri::HTML(email.body.to_s)
  html.at("a:contains('#{text}')")['href']
end
