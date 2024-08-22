# frozen_string_literal: true

class Member < ApplicationRecord
  validates :first_name, :last_name, presence: true,
                                     format: { with: /\A[a-zA-Z\s]+\z/, message: 'only allows letters and spaces' }
  validates :city, :state, :country, format: { with: /\A[a-zA-Z\s]+\z/, message: 'only allows letters and spaces' },
                                     allow_blank: true
  belongs_to :team
  accepts_nested_attributes_for :team
  has_and_belongs_to_many :projects
end
