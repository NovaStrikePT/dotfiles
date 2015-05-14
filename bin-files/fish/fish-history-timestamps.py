#!/usr/bin/python
# From https://github.com/fish-shell/fish-shell/issues/677

import datetime
from os.path import expanduser
home = expanduser("~")
path=home + '/.config/fish/fish_history'
txt=open(path,'r').readlines()
cmd=''
when=''
for line in txt:
    if line.startswith('- cmd:'):
        cmd = line.partition('- cmd: ')[2][:-1]
    elif line.startswith('   when:'):
        when = line.partition('   when: ')[2][:-1]
        when = datetime.datetime.fromtimestamp(int(when)).strftime('%Y-%m-%d %H:%M:%S')
        print "%s: %s" % (when, cmd)
