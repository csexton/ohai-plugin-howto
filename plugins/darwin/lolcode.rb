provides "languages/lolcode"

require_plugin "languages"

languages[:lolcode] = Mash.new unless languages[:lolcode]
languages[:lolcode][:platform] = "MACKERS"
