require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { build(:article) }
  let(:article_cre) { create(:article) }
  describe 'validation' do
    context "cost validation" do
      before { article.cost = nil }
      it 'cost null is valid' do
        expect(article).to be_valid
      end
    end

    context "cost validation" do
      before { article.cost = -1 }
      it 'cost nuder 0 is invalid' do
        expect(article).to be_invalid
      end
    end

    context "days validation" do
      before { article.days = nil }
      it 'days null is valid' do
        expect(article).to be_valid
      end
    end

    context "days validation" do
      before { article.days = -1 }
      it 'fays nuder 0 is invalid' do
        expect(article).to be_invalid
      end
    end
  end

  describe 'reference' do
    it 'deleted when user deleted' do
      expect(article_cre.id).to eq 1
      article_cre.user.destroy
      expect(Article.where(id: 1).count).to eq 0
    end
  end
end
