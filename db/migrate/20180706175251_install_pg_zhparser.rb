class InstallPgZhparser < ActiveRecord::Migration[5.2]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS zhparser;"
  end

  def down
    execute "DROP EXTENSION IF EXISTS zhparser;"
  end
end
