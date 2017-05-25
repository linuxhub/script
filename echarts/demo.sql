

/* 创建数据库 demo */
CREATE DATABASE `demo`  DEFAULT CHARACTER SET utf8;


/* 进入demo数据库 */
use demo;

/* 创建表 */
CREATE TABLE `user_age` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) DEFAULT CHARSET=utf8;

/* 增加表数据 */
INSERT INTO `user_age` VALUES (1, '张三', 19);
INSERT INTO `user_age` VALUES (2, '李四', 16);
INSERT INTO `user_age` VALUES (3, '王五', 20);
INSERT INTO `user_age` VALUES (4, '赵六', 17);
INSERT INTO `user_age` VALUES (5, '孙七', 19);
INSERT INTO `user_age` VALUES (6, '周八', 28);
INSERT INTO `user_age` VALUES (7, '吴九', 15);
INSERT INTO `user_age` VALUES (8, '郑十', 22);
