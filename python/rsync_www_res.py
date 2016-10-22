#!/usr/bin/python
# -*- coding: utf-8 -*-
# author: zeping lai
# rsync_www_res.py

import os,sys
from datetime import datetime

def run_rsync(source,target,option):
    cmd = "rsync -avzP " + option + " --password-file=/etc/rsync/rsync.password " + source + " " + target
    print(cmd)
    sys.stdout.flush()
    os.system(cmd)

gz_host = "rsyncd@192.168.10.200::wwwmain"
bj_host = "rsyncd@192.168.20.200::wwwmain"
sh_host = "rsyncd@192.168.30.200::wwwmain"

dirs = [
        ("www.linxuhub.cn",
         {
             "hosts": [("", bj_host), ("", gz_host), ("", dg_host)],
             "paths": [("/data/www/www.linxuhub.cn/pic/", "/www.linxuhub.org/mobile/res/www/pic/"),
                       ("/data/www/www.linxuhub.cn/upload/", "/www.linxuhub.org/mobile/res/www/upload/")
                       ]
         }
         ),

        ("m.linxuhub.cn",
            {
             "hosts" : [("", bj_host),("", gz_host),("", dg_host)],
             "paths" : [("/data/www/m.linxuhub.cn/pic/", "/www.linxuhub.org/mobile/res/m/pic/"),
                         ("/data/www/m.linxuhub.cn/img/", "/www.linxuhub.org/mobile/res/m/img/"),
                        ("/data/www/m.linxuhub.cn/public/upload/", "/www.linxuhub.org/mobile/res/m/upload/")
                        ]
            }
         )
]
        
print "******  start syncing process at %s" % (datetime.now())
for name,conf in dirs:
    print "***  start syncing %s at %s" % (name, datetime.now())
    for source_dir, target_dir in conf["paths"]:
        for source_host, target_host in conf["hosts"]:
            run_rsync(source_host + source_dir, target_host + target_dir, "")

    print "*** end syncing %s at %s ." % (name, datetime.now())
    print

print "******  end syncing process at %s" % (datetime.now())
