class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.integer :lesson_id
      t.integer :anwser_id
      t.integer :word_id

      t.timestamps
    end
  end
end
