class CreateAnwsers < ActiveRecord::Migration[5.0]
  def change
    create_table :anwsers do |t|
      t.integer :word_id
      t.string :content
      t.boolean :is_correct

      t.timestamps
    end
  end
end