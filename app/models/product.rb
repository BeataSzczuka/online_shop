# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :comments
  validates_presence_of :name
  validates_presence_of :price
end
