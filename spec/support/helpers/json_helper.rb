module JsonHelper
  def json
    JSON.parse(response.body)
  end

  def expect_json_response_with_status(status_key)
    expect(response).to have_http_status(status_key)
    expect(response.content_type).to eq('application/vnd.api+json; charset=utf-8')
  end

  def expect_json_response_keys
    expect(json.keys).to match_array(%w[data jsonapi])
  end
end
