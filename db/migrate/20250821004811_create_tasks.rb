# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.string :status, null: false, default: "pending"

      t.timestamps
    end

    add_index :tasks, :status
    add_index :tasks, :title
    add_index :tasks, :description, using: :gin, opclass: :gin_trgm_ops
  end
end
