#!/usr/bin/env python
#encoding:utf8
#author: zeping lai

# 接create_tables.py文件里面定义好的数据模型 
from create_tables import db
from create_tables import Info
from create_tables import History

# 插入数据 info
taipingying_info = Info(code='601099',name='太平洋',market='sh',pinyin='taipingying')
db.session.add(taipingying_info)
db.session.commit()

# 插入数据 history
taipingying_history = History(code='601099',
                              date='2016-09-30',
                              open_price='4.850',
                              close_price='4.920',
                              max_price='4.930',
                              min_price='4.840',
                              trade_num='227872735',
                              trade_money='1113735589'
                              )
db.session.add(taipingying_history)
db.session.commit()
