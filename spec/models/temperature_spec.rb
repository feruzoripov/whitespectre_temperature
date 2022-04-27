require 'rails_helper'

RSpec.describe Temperature, type: :model do
  before :each do
    MandrillMailer.deliveries.clear
  end

  context 'valid' do
    it 'should validate presence of value' do
      tmp = Temperature.new
      expect(tmp).to_not be_valid

      tmp.value = 10
      expect(tmp).to be_valid
    end
  end

  context 'offset value' do
    it 'removes offset value before creation' do
      allow(SystemConfig).to receive(:[]).and_return('5')
      tmp = Temperature.new(value: 40)
      tmp.save

      expect(tmp.value).to eq 35
    end
  end

  context 'since && till' do
    it 'should return temps > since' do
      tmp1 = Temperature.create(value: 10, created_at: 5.days.ago)
      tmp2 = Temperature.create(value: 15)

      expect(Temperature.since(1.day.ago)).to eq [tmp2]
    end

    it 'should return temps < till' do
      tmp1 = Temperature.create(value: 10, created_at: 5.days.ago)
      tmp2 = Temperature.create(value: 15)

      expect(Temperature.till(1.day.ago)).to eq [tmp1]
    end

    it 'should return since < temps < till' do
      tmp1 = Temperature.create(value: 10, created_at: 5.days.ago)
      tmp2 = Temperature.create(value: 15, created_at: 3.days.ago)
      tmp3 = Temperature.create(value: 20, created_at: 2.days.ago)
      tmp4 = Temperature.create(value: 15)

      expect(Temperature.since(4.days.ago).till(1.day.ago)).to match_array [tmp2, tmp3]
    end
  end

  context 'alert notification' do
    it 'should send alert notification if last 5 raws exceeds 37.5' do
      allow(SystemConfig).to receive(:[]).and_return('test@example.com')
      tmp1 = Temperature.create(value: 40)
      tmp2 = Temperature.create(value: 45)
      tmp3 = Temperature.create(value: 40)
      tmp4 = Temperature.create(value: 45)
      tmp5 = Temperature.create(value: 45)
      tmp6 = Temperature.create(value: 45)

      email = MandrillMailer.deliveries.detect { |mail|
        mail.message['to'].any? { |to| to['email'] == 'test@example.com' }
      }
      expect(email).to_not be_nil
    end
  end
end
