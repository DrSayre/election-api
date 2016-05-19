class CreateSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :samples do |t|
      t.references :source, foreign_key: true
      t.references :candidate, foreign_key: true
      t.decimal :probability
      t.timestamp :time_added

      t.timestamps
    end
  end
end
