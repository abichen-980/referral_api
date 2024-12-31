class AddTokenDetailsToReferrals < ActiveRecord::Migration[7.2]
  def change
    add_column :referrals, :token, :string

    add_index :referrals, :token, unique: true
  end
end
