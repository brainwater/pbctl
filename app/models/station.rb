class Station < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 250 }
  validates :index, presence: true, uniqueness: { case_sensitive: true }

end
