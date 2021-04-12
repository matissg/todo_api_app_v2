require 'rails_helper'

describe ResourceWithTag do
  subject(:save) { instance.save }

  let(:instance) { described_class.new(resource) }
  let(:resource) { Task }

  describe '#save' do
    before { instance.params = params }

    context 'when resource title and tag passed' do
      let(:params) { { title: 'Task', tags: %w[Today] } }

      it 'creates resource with tag' do
        expect { save }.to change(Task, :count).by(1).and(change(Tag, :count).by(1))
      end
    end

    context 'when only resource title passed' do
      let(:params) { { title: 'Task', tags: [] } }

      it 'creates resource with tag' do
        expect { save }.to change(Task, :count).by(1).and(change(Tag, :count).by(0))
      end
    end

    context 'when update resource title' do
      let(:task) { create(:task) }
      let(:new_title) { 'New Title' }
      let(:params) { { id: task.id, title: new_title, tags: [] } }

      it 'creates resource with tag' do
        expect { save }.to change(Task, :count).by(0).and(
          change(Tag, :count).by(0)
        ).and(change { task.reload.title }.to(new_title))
      end
    end

    context 'when change resource tags' do
      before { create(:tagging, taggable: task, tag: tag) }

      let(:task) { create(:task) }
      let(:tag) { create(:tag) }
      let(:params) { { id: task.id, title: 'Title', tags: [] } }

      it 'removes resource tag' do
        expect { save }.to change(Tag, :count).by(0).and(change(Tagging, :count).by(-1))
      end

      context "when update resource tag" do
        let!(:params) { { id: task.id, title: 'Title', tags: %w[Changed] } }

        it 'removes previous tag and adds new tag' do
          expect { save }.to change(Tag, :count).by(1).and(change(Tagging, :count).by(0)).and(
            change { task.reload.tags.map(&:title) }.to(%w[Changed])
          )
        end
      end
    end

    context 'when invalid resource title passed' do
      let(:params) { { title: 'T', tags: [] } }

      it { is_expected.to be false }
    end

    context 'when invalid tag title passed' do
      let(:params) { { title: 'Task', tags: %w[T] } }

      it { is_expected.to be false }
    end
  end
end
