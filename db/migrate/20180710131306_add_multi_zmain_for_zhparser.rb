class AddMultiZmainForZhparser < ActiveRecord::Migration[5.2]
  def change
    execute 'alter role all set zhparser.multi_zmain=on;'
  end
end
