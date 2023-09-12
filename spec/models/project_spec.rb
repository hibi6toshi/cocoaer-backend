require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { build(:project) }
  let(:project_cre) { create(:project) }
  describe 'validation' do
    context "cost validation" do
      before { project.cost = nil }
      it 'cost null is valid' do
        expect(project).to be_valid
      end
    end

    context "cost validation" do
      before { project.cost = -1 }
      it 'cost nuder 0 is invalid' do
        expect(project).to be_invalid
      end
    end
  end

  describe 'reference' do
    it 'deleted when user deleted' do
      expect(project_cre.id).to eq 1
      project_cre.user.destroy
      expect(Project.where(id: 1).count).to eq 0
    end
  end
end
