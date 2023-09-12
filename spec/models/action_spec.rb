require 'rails_helper'

RSpec.describe Action, type: :model do
  let(:action) { build(:action) }
  let(:action_cre) { create(:action) }
  describe 'validation' do
    context "name validation" do
      it 'name not null is valid' do
        expect(action).to be_valid
      end
    end

    context "name validation" do
      before { action.name = nil }
      it 'name null is invalid' do
        expect(action).to be_invalid
      end
    end
  end

  describe 'reference' do
    it 'deleted when user deleted' do
      expect(action_cre.id).to eq 1
      action_cre.user.destroy
      expect(Action.where(id: 1).count).to eq 0
    end
  end
end
