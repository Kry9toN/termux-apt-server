import subprocess as sp
import time

from watchdog.events import FileSystemEventHandler

*data_tree, = "/data/web/", "/data/deb/"

class ObserverFile(FileSystemEventHandler):
    def on_created(self, event):
        if event.is_directory:
            return
        else:
            path = event.src_path
            print(f'New file added: {path}')
            time.sleep(1)
            cmd = f'termux-apt-repo {data_tree[1]} {data_tree[0]} termux sc'
            sp.check_call(cmd, shell=True, close_fds=True)

event_handler = ObserverFile()
