provides "languages/lolcode"

require_plugin "languages"
require_plugin "#{os}::lolcode"

# don't create a new mash if one already exists
languages[:lolcode] = Mash.new unless languages[:lolcode]
languages[:lolcode][:version] = "TEH VERSHIONS"

