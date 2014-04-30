json.array!(@reports) do |report|
  json.extract! report, :id, :generated_at
  json.url report_url(report, format: :json)
end
