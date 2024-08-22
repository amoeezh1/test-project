# frozen_string_literal: true

class Project < ApplicationRecord
  has_and_belongs_to_many :members
  validates :name, format: { with: /\A[a-zA-Z\s]+\z/, message: 'only allows letters and spaces' }, allow_blank: true
end
