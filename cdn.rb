require 'dotenv'

Dotenv.load

if ENV['CDN_HOST']
  `sed -i 's/\\/\\w\\+\\/index\\b/#{ENV['CDN_HOST'].gsub('/', '\/')}&/' public/index.html`
end