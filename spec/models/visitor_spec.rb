require 'rails_helper'

RSpec.describe Visitor, type: :model do
  let!(:visit1) { FactoryGirl.create(:visitor, visit_key: 'Fred', starts_on: Date.new(2016, 3, 1), ends_on: Date.new(2016, 3, 5)) }
  let!(:visit2) { FactoryGirl.create(:visitor, visit_key: 'Sue', starts_on: Date.new(2016, 3, 1), ends_on: Date.new(2016, 3, 10)) }
  let!(:visit3) { FactoryGirl.create(:visitor, visit_key: 'Li', starts_on: Date.new(2016, 3, 6), ends_on: Date.new(2016, 3, 10)) }
  let!(:visit4) { FactoryGirl.create(:visitor, visit_key: 'Fred', starts_on: Date.new(2016, 3, 5), ends_on: Date.new(2016, 3, 5)) }
  let!(:visit5) { FactoryGirl.create(:visitor, visit_key: 'Sue', starts_on: Date.new(2016, 3, 1), ends_on: Date.new(2016, 3, 3)) }
  let!(:visit6) { FactoryGirl.create(:visitor, visit_key: 'Harry', starts_on: Date.new(2016, 3, 7), ends_on: Date.new(2016, 3, 10)) }

  describe '.in_data_range' do
    subject { Visitor.in_date_range(Date.new(2016, 3, 4), Date.new(2016, 3, 6)).all }
    it 'includes visits that start within range' do
      expect(subject).to include(visit3)
    end
    it 'includes visits that end within range' do
      expect(subject).to include(visit1)
    end
    it 'includes visits that start before and end after range' do
      expect(subject).to include(visit2)
    end
    it 'includes visits that start and end within range' do
      expect(subject).to include(visit4)
    end
    it 'excludes visits that end before range' do
      expect(subject).not_to include(visit5)
    end
    it 'excludes visits that start after range' do
      expect(subject).not_to include(visit6)
    end
  end

  describe '.unique_count' do
    it 'counts only unique visitors' do
      expect(Visitor.unique_visitors_in_period(Date.new(2016,3,1), Date.new(2016,3,10))).to eql(4)
    end
  end

end
