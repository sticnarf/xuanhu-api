class UsePgZhparser < ActiveRecord::Migration[5.2]
  def change
    execute 'CREATE TEXT SEARCH CONFIGURATION testzhcfg (PARSER = zhparser);'
    execute 'ALTER TEXT SEARCH CONFIGURATION testzhcfg ADD MAPPING FOR n,v,a,i,e,l WITH simple;'
  end
end
