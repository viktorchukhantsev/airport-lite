# frozen_string_literal: true

PlaneEvent.destroy_all
Plane.destroy_all
10.times { Plane.create!(code: SecureRandom.hex(3).to_s.upcase) }
