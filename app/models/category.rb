# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :articles

  validates :name, presence: true, length: { minimum: 3 }

  scope :desc_order, -> { order(:name) } #lista os nomes em ordem alfabética
end
