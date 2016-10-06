#!/usr/bin/env python
#encoding:utf8
#author: zeping lai
# 抓取股票一个季度的历史数据，保存到MySQL数据库

from flask import Flask
from flask_sqlalchemy import SQLAlchemy

import urllib2
from bs4 import BeautifulSoup

# URL地址 （获取601099股票 第三季度的历史数据）
url = "http://money.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/601099.phtml?year=2016&jidu=3"

# 数据库配置
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:123456@127.0.0.1:3306/stock_analysis'
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True
db = SQLAlchemy(app)

# 数据表模型
class History(db.Model):
    __tablename__ = 'st_history'
    id = db.Column(db.Integer,primary_key=True) # id 主键自增
    code = db.Column(db.Integer,nullable=True,index=True)    # 股票编码（不允许不空，创建索引）
    date = db.Column(db.Date()) # 日期
    open_price = db.Column(db.Numeric(4,3))   # 开盘价 9999.999
    close_price = db.Column(db.Numeric(4,3))  # 收盘价
    max_price = db.Column(db.Numeric(4,3))    # 最高价
    min_price = db.Column(db.Numeric(4,3))    # 最低价
    trade_num = db.Column(db.BigInteger)      #交易数量(股)
    trade_money = db.Column(db.BigInteger)    #交易金额(元)
    def __repr__(self):
        return '<History %r>' % self.date


db.drop_all()   #删除所有表
db.create_all()  #创建所有表

# 获取网页内容
response = urllib2.urlopen(url)
if response.getcode() != 200:
    print "请求返回的状态不等于200,请求失败"
    exit();
html_doc = response.read()


# 解析网页，爬取需要的数据
soup = BeautifulSoup(html_doc,'html.parser', from_encoding='utf-8')
tab = soup.find(id='FundHoldSharesTable')
data_list = []
for tr in tab.findAll('tr'):
    res_list = []
    for td in tr.findAll('td'):
        res_list.append(td.getText())
    data_list.append(res_list)
#print data_list


# 数据入库
for res in data_list:
    if res :
        date = res[0].strip().encode('utf-8') # 日期
        if date == '日期':
            continue
        open_price = res[1].strip()   # 开盘价
        max_price = res[2].strip()    # 最高价
        close_price = res[3].strip()  # 收盘价
        min_price = res[4].strip()    # 最低价
        trade_num = res[5].strip()    # 交易数量(股)
        trade_money = res[6].strip()  # 交易金额(元)
        #print date, open_price, max_price, close_price, min_price, trade_num, trade_money

        db.session.add(History(code='601099',
                               date=date,
                               open_price=open_price,
                               close_price=close_price,
                               max_price=max_price,
                               min_price=min_price,
                               trade_num=trade_num,
                               trade_money=trade_money
                               ))
    db.session.commit() #提交写到数据库
