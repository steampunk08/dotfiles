# General Mode Tmux Setup

tmux has-session -t General 2> /dev/null

if [ $? != 0 ]; then
   tmux new -s General -n main -d

   tmux new-window -n tests
   tmux new-window -n music
   
   tmux split-window -v -t General:3

   tmux send-keys -t General:3.1 'cd /storage/sdcard1/com.ayamob.video && vifm' C-m
   tmux send-keys -t General:3.2 'cd /storage/sdcard1/Music && vifm' C-m

   tmux select-window -t General:1
fi
tmux attach -t General

alias exit="logout"
