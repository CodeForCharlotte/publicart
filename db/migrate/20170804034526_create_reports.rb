class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :ip_address
      t.integer :user_id

      t.timestamps
    end
  end
end
