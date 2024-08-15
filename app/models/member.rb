class Member < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    belongs_to :team
    accepts_nested_attributes_for :team
    has_and_belongs_to_many :projects, join_table: 'members_projects_joins'

end
