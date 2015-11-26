To have launchd start elasticsearch at login:
  ln -sfv /usr/local/opt/elasticsearch/*.plist ~/Library/LaunchAgents
Then to load elasticsearch now:
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
Or, if you don't want/need launchctl, you can just run:
  elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml