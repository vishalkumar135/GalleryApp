class Album < ApplicationRecord
    belongs_to :user
    validates :title, presence:true
    validates :all_tags, presence:true
    validates :Description, presence:true, length:{ minimum: 10}
    validates :cover_photo, presence:true
    validates :images, presence:true
    has_one_attached :cover_photo, dependent: :destroy
    has_many_attached :images  ,dependent: :destroy
    has_many :taggings ,dependent: :destroy
    has_many :tags, through: :taggings 
                                                   
    scope :published, -> { where(published: true) }
    scope :unpublished,->{ where(published: false)}

   

   

    def all_tags=(names)
       self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
       end
    end
    def all_tags
        self.tags.map(&:name).join(", ")
    end
  
    
end
