class Snack < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :price

  has_many :machine_snacks
  has_many :machines, through: :machine_snacks
  has_many :owners, through: :machines
end