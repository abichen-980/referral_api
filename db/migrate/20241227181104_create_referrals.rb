class CreateReferrals < ActiveRecord::Migration[7.2]
  def change
    create_table :referrals do |t|
      t.references :referrer, null: false, foreign_key: { to_table: :users }
      t.references :referred, foreign_key: { to_table: :users }
      t.string :email
      t.integer :status

      t.timestamps
    end
  end
end
