#!/usr/bin/env python

import time
import os

from watchdog.observers import Observer
from observer import event_handler, data_tree

def main():
    observer = Observer()
    observer.schedule(event_handler, data_tree[1], recursive=False)
    observer.start()

    for path in data_tree:
        if not os.path.exists(path):
            os.makedirs(path)

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()

    observer.join()

if __name__ == "__main__":
    main()
