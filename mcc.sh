while [ true ]; do

done


 if [ $(rgx e -i /opt/mcsd/$1/server.properties "enable-rcon=(\w+)" "\$1" | grep true) != "true" ]; then
  echo "RCON is not enabled for $1"
  exit
 fi
 echo "$1">~/con_rcon_id.txt
 tmux new-session -d -s fakeconsole \
  "journalctl -u minecraft@$1 -f" \; \
  split-window -v '/bin/bash /opt/mcsd/con_rcon.sh' \; \
  select-pane -t 0 \; \
  resize-pane -y 50 \; \
  select-pane -t 1 \; \
  resize-pane -y 4 \; \
  attach
