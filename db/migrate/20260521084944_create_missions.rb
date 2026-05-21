class CreateMissions < ActiveRecord::Migration[8.1]
  def change
    create_table :missions do |t|
      t.references :agent, null: false, foreign_key: true
      t.string :title, null: false
      t.string :status, null: false, default: 'assigned'

      t.timestamps
    end
  end
end
