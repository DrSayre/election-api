class CreateMeanSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :mean_samples do |t|
      t.references :candidate, foreign_key: true
      t.date :sample_date
      t.decimal :probability

      t.timestamps
    end
  end
end
