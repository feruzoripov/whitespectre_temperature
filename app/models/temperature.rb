class Temperature < ApplicationRecord
  validates :value, presence: true

  before_create :rm_offset_value

  after_save :verify_for_alert

  default_scope { order(created_at: :desc) }

  scope :since, ->(date) {
    return self unless date.present?
    where('created_at >= ?' , date.to_date.beginning_of_day)
  }

  scope :till, ->(date) {
    return self unless date.present?
    where('created_at <= ?', date.to_date.end_of_day)
  }

  private

  def rm_offset_value
    offset_value = SystemConfig['offset_value'].to_f
    self.value -= offset_value
  end

  def verify_for_alert
    VerifyAlert.call
  end
end
