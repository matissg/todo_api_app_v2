require 'rails_helper'

describe PostWithTag do
  subject(:save) { instance.save }

  let(:instance) { described_class.new(Post) }

  include_examples 'a resource with tags save', Post

  context "when post title, content and tag is passed" do
    before { instance.params = params }

    let(:content) { 'Content' }
    let(:params) { { title: 'Title', content: content, tags: %w[Today] } }

    it 'creates record with title, content and tag' do
      expect { save }.to change(Post, :count).by(1).and(change(Tag, :count).by(1))
      expect(Post.last.content).to eq(content)
    end
  end
end
