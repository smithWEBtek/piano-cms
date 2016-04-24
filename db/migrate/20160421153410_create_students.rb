class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |u|
      u.string :username
      u.string :password_digest
    end
  end
end
