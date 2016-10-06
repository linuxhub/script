#!/usr/bin/env python
#encoding:utf8
#author: zeping lai
# mysql -uroot -p123456
# > create database stock_analysis default charset=utf8;

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
#from flask.ext.sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:123456@127.0.0.1:3306/stock_analysis'
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True
db = SQLAlchemy(app)

class Info(db.Model):
    __tablename__ = 'st_info'
    id = db.Column(db.Integer,primary_key=True) # id 主键自增
    code = db.Column(db.Integer,unique=True,nullable=True,index=True)    # 股票编码（不允许重复,不允许不空，创建索引）
    name = db.Column(db.String(128),unique=True,nullable=True,index=True) # 股票名称 （不允许重复,不允许不空，创建索引）
    market = db.Column(db.String(64),unique=True,nullable=True,index=True) # 市场缩写 （不允许重复,不允许不空，创建索引）
    pinyin = db.Column(db.String(128)) # 市场缩写 （不允许重复,不允许不空，创建索引）
    def __repr__(self):
        return '<Info %r>' % self.name

class History(db.Model):
    __tablename__ = 'st_history'
    id = db.Column(db.Integer,primary_key=True) # id 主键自增
    code = db.Column(db.Integer,unique=True,nullable=True,index=True)    # 股票编码（不允许重复,不允许不空，创建索引）
    date = db.Column(db.Date()) # 日期
    open_price = db.Column(db.Numeric(4,3))   # 开盘价 9999.999
    close_price = db.Column(db.Numeric(4,3))  # 收盘价
    max_price = db.Column(db.Numeric(4,3))    # 最高价
    min_price = db.Column(db.Numeric(4,3))    # 最低价
    trade_num = db.Column(db.BigInteger)      #交易数量(股)
    trade_money = db.Column(db.BigInteger)    #交易金额(元)
    def __repr__(self):
        return '<History %r>' % self.date


#db.drop_all()   #删除所有表
db.create_all()  #创建所有表
