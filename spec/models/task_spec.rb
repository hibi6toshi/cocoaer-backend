require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }
  let(:task_cre) { create(:task) }
  describe 'validation' do
    context "name validation" do
      it 'name not null is valid' do
        expect(task).to be_valid
      end
    end

    context "name validation" do
      before { task.name = nil }
      it 'name null is invalid' do
        expect(task).to be_invalid
      end
    end
  end

  describe 'reference' do
    it 'deleted when user deleted' do
      expect(task_cre.id).to eq 1
      task_cre.user.destroy
      expect(Action.where(id: 1).count).to eq 0
    end
  end
end
