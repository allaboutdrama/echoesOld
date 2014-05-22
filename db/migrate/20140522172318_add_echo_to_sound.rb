class AddEchoToSound < ActiveRecord::Migration
  def change
    add_column :sounds, :echo, :string
  end
end
