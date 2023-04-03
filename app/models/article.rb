class Article < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_rich_text :content
    extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
        title_changed? || super
    end
end
