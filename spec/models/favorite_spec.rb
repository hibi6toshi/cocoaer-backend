require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:favorite_article) { build(:favorite, :with_article) }
  let(:favorite_article_cre) { create(:favorite, :with_article) }

  describe 'validation' do
    context "user uniqueness validation" do
      it 'same user & same favoritable is invalid' do
        favorite = Favorite.new(user: favorite_article_cre.user, favoritable: favorite_article_cre.favoritable)
        expect(favorite).to be_invalid
      end
    end
  end

  describe 'reference' do
    it 'deleted when user deleted' do
      expect(favorite_article_cre.id).to eq 1
      favorite_article_cre.user.destroy
      expect(Favorite.where(id: 1).count).to eq 0
    end

    it 'deleted when favoritable deleted' do
      expect(favorite_article_cre.id).to eq 1
      favorite_article_cre.favoritable.destroy
      expect(Favorite.where(id: 1).count).to eq 0
    end
  end
end
