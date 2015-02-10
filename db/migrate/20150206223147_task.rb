class Task < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
     t.string :description

     t.timestamps null: false
   end
  end
end
