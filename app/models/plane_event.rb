# frozen_string_literal: true

# plane events model
class PlaneEvent < ApplicationRecord
  belongs_to :plane

  validates :plane_id, :state, presence: true
  validates :state, inclusion: {in: Plane::STATES}
end
