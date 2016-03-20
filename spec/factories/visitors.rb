FactoryGirl.define do
  factory :visitor do
    visit_key { SecureRandom.urlsafe_base64(16) }
    starts_on { Date.today }
    ends_on { Date.today }
  end
end
