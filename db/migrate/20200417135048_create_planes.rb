# frozen_string_literal: true

# create planes table
class CreatePlanes < ActiveRecord::Migration[6.0]
  def change
    create_table :planes do |t|
      t.string :code

      t.timestamps
    end
  end
end
