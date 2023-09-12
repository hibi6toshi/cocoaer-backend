require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment_article) { build(:comment, :with_article) }
  let(:comment_article_cre) { create(:comment, :with_article) }
  describe 'validation' do
    context "name validation" do
      it 'name not null is valid' do
        expect(comment_article).to be_valid
      end
    end

    context "name validation" do
      before { comment_article.body = nil }
      it 'name null is invalid' do
        expect(comment_article).to be_invalid
      end
    end
  end

  describe 'reference' do
    it 'deleted when user deleted' do
      expect(comment_article_cre.id).to eq 1
      comment_article_cre.user.destroy
      expect(Comment.where(id: 1).count).to eq 0
    end

    it 'deleted when favoritable deleted' do
      expect(comment_article_cre.id).to eq 1
      comment_article_cre.commentable.destroy
      expect(Comment.where(id: 1).count).to eq 0
    end
  end
end
