class AddForeignKeyToSounds < ActiveRecord::Migration
  def change
    add_reference :sounds, :user, index: true
  end
end
