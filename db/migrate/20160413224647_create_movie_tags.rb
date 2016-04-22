class CreateMovieTags < ActiveRecord::Migration
  def change
    create_table :movie_tags do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
