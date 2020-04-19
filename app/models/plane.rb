# frozen_string_literal: true

# plane model
class Plane < ApplicationRecord
  STATES = %w[hangar awaiting_takeoff takeoff flew_away]

  has_many :events, class_name: 'PlaneEvent'

  validates :code, presence: true

  delegate :hangar?, :awaiting_takeoff?, :takeoff?, :flew_away?, to: :current_state

  def current_state
    (events.last.try(:state) || STATES.first).inquiry
  end

  def awaiting_takeoff
    events.create!(state: 'awaiting_takeoff') if hangar?
  end

  def takeoff
    events.create!(state: 'takeoff') if awaiting_takeoff?
  end

  def flew_away
    events.create!(state: 'flew_away') if takeoff?
  end
end
