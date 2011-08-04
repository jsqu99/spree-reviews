class AddLocaleToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :locale, :string, :default => 'en'
  end

  def self.down
    remove_column :reviews, :locale
  end
end
