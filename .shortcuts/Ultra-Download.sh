# Ultra Download Mode Tmux Setup

tmux has-session -t general 2> /dev/null

if [ $? != 0 ]; then
   tmux new -s Ultra-Download -n main -d

   #tmux new-window -n tests
   #tmux new-window -n music
   
   #tmux split-window -v -t general:3

   #tmux send-keys -t general:3.1 'cd /storage/sdcard1/com.ayamob.video/' C-m
   #tmux send-keys -t general:3.2 'cd /storage/sdcard1/Music//' C-m

   #tmux select-window -t general:1
fi
tmux attach -t Ultra-Download

alias exit="logout"
