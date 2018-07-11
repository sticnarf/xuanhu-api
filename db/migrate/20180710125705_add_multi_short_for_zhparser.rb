class AddMultiShortForZhparser < ActiveRecord::Migration[5.2]
  def change
    execute 'alter role all set zhparser.multi_short=on;'
  end
end
