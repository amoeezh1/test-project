class Team < ApplicationRecord
    validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
    has_many :members
end
