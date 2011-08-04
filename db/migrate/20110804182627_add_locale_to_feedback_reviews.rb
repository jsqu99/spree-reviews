class AddLocaleToFeedbackReviews < ActiveRecord::Migration
  def self.up
    add_column :feedback_reviews, :locale, :string, :default => 'en'
  end

  def self.down
    remove_column :feedback_reviews, :locale
  end
end
