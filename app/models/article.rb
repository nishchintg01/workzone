class Article < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user
    validates :title, uniqueness: true, :null => false, :presence => true
    validates :subtitle, :null => false, :presence => true
    validates :description, :null => false, :presence => true
    validates :read, :null => false, :presence => true
end
