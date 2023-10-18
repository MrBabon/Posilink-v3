class Organization < ApplicationRecord
    has_many :directors, dependent: :destroy
    has_many :users, through: :directors
    has_many :events, dependent: :destroy
    has_one_attached :avatar
  
    enum category: {
      ecologie: "écologie",
      culture: "culture",
      sport: "sport",
      sante: "santé",
      education: "éducation",
      humanitaire: "humanitaire"
    }
    validates :category, inclusion: { in: categories.keys, message: "Catégorie invalide" }
    
  
    include PgSearch::Model
    pg_search_scope :search_by_organization,
                    against: [:name, :category, :description],
                    using: {
                        tsearch: { prefix: true }
                    }
  
    def category_form_value
      self.class.categories.key(category) || category
    end
end
