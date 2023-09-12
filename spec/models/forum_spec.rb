require 'rails_helper'

RSpec.describe Forum, type: :model do
  let(:forum) { build(:forum) }
  let(:forum_cre) { create(:forum) }
  describe 'validation' do
    context "cost validation" do
      before { forum.cost = nil }
      it 'cost null is valid' do
        expect(forum).to be_valid
      end
    end

    context "cost validation" do
      before { forum.cost = -1 }
      it 'cost nuder 0 is invalid' do
        expect(forum).to be_invalid
      end
    end

    context "days validation" do
      before { forum.days = nil }
      it 'days null is valid' do
        expect(forum).to be_valid
      end
    end

    context "days validation" do
      before { forum.days = -1 }
      it 'days nuder 0 is invalid' do
        expect(forum).to be_invalid
      end
    end
  end

  describe 'reference' do
    it 'deleted when user deleted' do
      expect(forum_cre.id).to eq 1
      forum_cre.user.destroy
      expect(Forum.where(id: 1).count).to eq 0
    end
  end
end
