class Temperature < ApplicationRecord
  validates :temp, presence: true

  before_create :rm_offset_value

  private

  def rm_offset_value
    offset_value = SystemConfig['offset_value'].to_f
    self.temp -= offset_value
  end
end
