class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :target_id
      t.integer :action_type

      t.timestamps
    end
  end
end
