RSpec.shared_examples_for 'a resource with tags requests' do |resources|
  let(:attributes) { { data: { id: nil, attributes: { title: title }, tags: ['Today'] } } }

  describe "GET /api/v1/#{resources}" do
    before { get public_send("api_v1_#{resources}_path") }

    it "returns #{resources} and correct status code" do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/#{resources}/:id" do
    before { get public_send("api_v1_#{resources}_path", resource.id) }

    it 'returns resource and correct status code' do
      expect(json['data'][0]['attributes']['title']).to eq(resource.title)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/#{resources}" do
    before { post public_send("api_v1_#{resources}_path"), params: attributes }
    let(:title) { 'Some Title' }

    context 'when request is valid' do
      it 'creates resource and returns correct status code' do
        expect(json['data']['attributes']['title']).to eq(title)
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is not valid' do
      let!(:title) { nil }

      it 'returns unprocessable entity status code' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /api/v1/#{resources}/:id" do
    before { patch public_send("api_v1_#{resources.singularize}_path", id), params: attributes }

    let(:title) { 'Some Title' }

    context 'when record exists' do
      let(:id) { resource.id }

      it 'updates the record with title field and returns correct status code' do
        expect(resource.reload.title).to eq(title)
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:id) { 0 }

      it 'returns unprocessable entity status code and resource not found error message' do
        expect(response).to have_http_status(422)

        expect(json['errors'][0]['detail']).to match(
          I18n.t(:not_found, scope: %i[activemodel errors models resource_with_tag attributes base])
        )
      end
    end
  end

  describe "DELETE /api/v1/#{resources}/:id" do
    before { delete public_send("api_v1_#{resources.singularize}_path", resource.id) }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
