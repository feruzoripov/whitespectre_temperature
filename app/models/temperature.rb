class Temperature < ApplicationRecord
  validates :temp, presence: true
end
