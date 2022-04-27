class Temperature < ApplicationRecord
  validates :value, presence: true

  before_create :rm_offset_value

  default_scope { order(created_at: :desc) }

  scope :since, ->(date) {
    return self unless date.present?
    where('created_at >= ?' , date.to_date)
  }

  scope :till, ->(date) {
    return self unless date.present?
    where('created_at <= ?', date.to_date)
  }

  private

  def rm_offset_value
    offset_value = SystemConfig['offset_value'].to_f
    self.value -= offset_value
  end
end
