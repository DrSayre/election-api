class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.decimal :probability, default: 0

      t.timestamps
    end
  end
end
