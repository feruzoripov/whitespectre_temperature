class SystemConfig < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: true }

  class << self
    def [](name)
      self.find_by_name(name)
    end

    def []=(name, value)
      config = self.find_or_initialize_by({name: name})
      config.value = value
      config.save!
    end
  end
end
