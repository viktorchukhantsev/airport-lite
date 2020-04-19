# frozen_string_literal: true

FactoryBot.define do
  factory :plane do
    sequence('id')
    code { 'IDDQD' }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end
end
