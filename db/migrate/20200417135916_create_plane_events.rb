# frozen_string_literal: true

# create plane events table
class CreatePlaneEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :plane_events do |t|
      t.references :plane, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
