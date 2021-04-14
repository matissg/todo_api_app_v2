RSpec.shared_examples_for 'a resource with tags save' do |klass|
  describe '#save' do
    before { instance.params = params }

    context 'when resource title and tag passed' do
      let(:params) { { title: klass.to_s, tags: %w[Today] } }

      it 'creates resource with tag' do
        expect { save }.to change(klass, :count).by(1).and(change(Tag, :count).by(1))
      end
    end

    context 'when only resource title passed' do
      let(:params) { { title: klass.to_s, tags: [] } }

      it 'creates resource with tag' do
        expect { save }.to change(klass, :count).by(1).and(change(Tag, :count).by(0))
      end
    end

    context 'when update resource title' do
      let(:taggable) { create(klass.name.downcase.to_sym) }
      let(:new_title) { 'New Title' }
      let(:params) { { id: taggable.id, title: new_title, tags: [] } }

      it 'creates resource with tag' do
        expect { save }.to change(klass, :count).by(0).and(
          change(Tag, :count).by(0)
        ).and(change { taggable.reload.title }.to(new_title))
      end
    end

    context 'when change resource tags' do
      before { create(:tagging, taggable: taggable, tag: tag) }

      let(:taggable) { create(klass.name.downcase.to_sym) }
      let(:tag) { create(:tag) }
      let(:params) { { id: taggable.id, title: 'Title', tags: [] } }

      it 'removes resource tag' do
        expect { save }.to change(Tag, :count).by(0).and(change(Tagging, :count).by(-1))
      end

      context "when update resource tag" do
        let!(:params) { { id: taggable.id, title: 'Title', tags: %w[Changed] } }

        it 'removes previous tag and adds new tag' do
          expect { save }.to change(Tag, :count).by(1).and(change(Tagging, :count).by(0)).and(
            change { taggable.reload.tags.map(&:title) }.to(%w[Changed])
          )
        end
      end
    end

    context 'when not allowed symbols passed' do
      let(:params) { { title: 'Title', tags: %w[#something @else] } }
      let(:expected_tags) { %w[something else] }

      it 'creates resource with tags' do
        expect { save }.to change(klass, :count).by(1).and(change(Tag, :count).by(2))
        expect(Tag.all.map(&:title)).to match_array(expected_tags)
      end
    end

    context 'when invalid resource title passed' do
      let(:params) { { title: 'T', tags: [] } }

      it { is_expected.to be false }
    end

    context 'when invalid tag title passed' do
      let(:params) { { title: klass.to_s, tags: %w[T] } }

      it { is_expected.to be false }
    end
  end
end
