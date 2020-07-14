/*
Navicat MySQL Data Transfer

Source Server         : qqq
Source Server Version : 50713
Source Host           : localhost:3306
Source Database       : iotdb

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2019-01-15 14:30:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `talarmdata`
-- ----------------------------
DROP TABLE IF EXISTS `talarmdata`;
CREATE TABLE `talarmdata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gdid` bigint(20) DEFAULT NULL COMMENT '终端设备ID,关联tgatedevice',
  `alarmtime` datetime NOT NULL COMMENT '报警时间',
  `alarmdata` text NOT NULL COMMENT '报警数据：JSON格式',
  `pushresult` varchar(1024) DEFAULT NULL COMMENT 'APP消息推送结果：预留备用',
  `proccessresult` varchar(1024) DEFAULT NULL COMMENT '报警处理结果',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='终端设备报警数据';

-- ----------------------------
-- Records of talarmdata
-- ----------------------------

-- ----------------------------
-- Table structure for `tdevice`
-- ----------------------------
DROP TABLE IF EXISTS `tdevice`;
CREATE TABLE `tdevice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dtid` bigint(20) DEFAULT NULL COMMENT '设备类型id',
  `devicecode` varchar(50) NOT NULL COMMENT '设备型号：终端通讯备用，必须唯一',
  `devicename` varchar(256) NOT NULL COMMENT '设备名称',
  `devicephoto` varchar(1024) DEFAULT NULL COMMENT '设备图片',
  `deviceconfig` text COMMENT '设备参数配置：JSON格式（可以覆盖类型中的参数设定）',
  `deviceenabled` int(11) DEFAULT NULL COMMENT '是否启用',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='物联网设备';

-- ----------------------------
-- Records of tdevice
-- ----------------------------
INSERT INTO `tdevice` VALUES ('1', '1', 'DHT11', '温湿度传感器', 'photos/dht11.png', '{\"tempmax\":40,\"humimax\":75}', '1', null, '2017-11-25 15:19:02');
INSERT INTO `tdevice` VALUES ('2', '2', 'RBGLED', '三色LED灯', 'photos/aa.jpg', null, '1', null, '2017-11-25 15:19:45');
INSERT INTO `tdevice` VALUES ('3', '2', 'DHT12', '光照设备2', 'photos/aa.jpg', null, '1', null, null);
INSERT INTO `tdevice` VALUES ('4', '2', 'RBGLED2', '温湿度2', 'photos/rgbled.jpg', null, '1', null, null);
INSERT INTO `tdevice` VALUES ('5', '1', '13131·', '光传感器', 'photos/a.jpg', null, '1', null, null);
INSERT INTO `tdevice` VALUES ('6', '2', '12312', '磁传感器', 'photos/dht11.png', null, '1', null, null);
INSERT INTO `tdevice` VALUES ('7', '1', '12', '智能锁', 'photos/red.jpg', null, '1', null, null);

-- ----------------------------
-- Table structure for `tdevicetype`
-- ----------------------------
DROP TABLE IF EXISTS `tdevicetype`;
CREATE TABLE `tdevicetype` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `devicetypecode` varchar(50) NOT NULL COMMENT '设备类型编码：终端通讯备用，必须唯一',
  `devicetypename` varchar(256) NOT NULL COMMENT '设备类型名称：感知设备，控制设备，监控设备',
  `devicetypeconfig` text COMMENT '设备类型参数配置：JSON格式',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='物联网设备类型';

-- ----------------------------
-- Records of tdevicetype
-- ----------------------------
INSERT INTO `tdevicetype` VALUES ('1', '01', '感知设备', '123', null, '2017-11-25 15:16:40');
INSERT INTO `tdevicetype` VALUES ('2', '02', '控制设备', '13', null, '2017-11-25 15:17:09');
INSERT INTO `tdevicetype` VALUES ('3', '03', '监控设备', '534', null, '2017-11-25 15:17:24');
INSERT INTO `tdevicetype` VALUES ('10', '03', '监控设备', '23', null, '2019-01-15 02:00:50');

-- ----------------------------
-- Table structure for `tgate`
-- ----------------------------
DROP TABLE IF EXISTS `tgate`;
CREATE TABLE `tgate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` bigint(20) DEFAULT NULL COMMENT '项目ID',
  `gatename` varchar(256) NOT NULL COMMENT '网关名称',
  `gateid` varchar(50) NOT NULL COMMENT '网关编号：通讯端使用，必须唯一，可以采用UUID',
  `gateenabled` int(11) DEFAULT '1' COMMENT '是否启用',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='物联网通讯网关';

-- ----------------------------
-- Records of tgate
-- ----------------------------
INSERT INTO `tgate` VALUES ('1', '1', '树莓派网关', '1', '1', null, '2017-11-25 15:22:04');
INSERT INTO `tgate` VALUES ('2', '1', '因特网网关', '2', '1', '2', '2019-01-11 23:49:36');
INSERT INTO `tgate` VALUES ('3', '1', 'LAN网关', '3', '1', null, '2019-01-09 23:50:14');
INSERT INTO `tgate` VALUES ('4', '2', 'LNA', '2', '1', null, '2019-01-08 21:08:53');

-- ----------------------------
-- Table structure for `tgatedevice`
-- ----------------------------
DROP TABLE IF EXISTS `tgatedevice`;
CREATE TABLE `tgatedevice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gid` bigint(20) DEFAULT NULL COMMENT '网关ID',
  `did` bigint(20) DEFAULT NULL COMMENT '设备ID',
  `clientdevicename` varchar(256) DEFAULT NULL COMMENT '终端设备名称',
  `clientdeviceid` varchar(256) NOT NULL COMMENT '终端设备编号：通讯时候使用，必须唯一，可以采用UUID',
  `clientdeviceconfig` text COMMENT '终端设备参数：JSON格式（包含报警上下限等）',
  `clientdevicestate` varchar(2048) DEFAULT NULL COMMENT '终端设备状态：备用',
  `clientdeviceenabled` int(11) DEFAULT NULL COMMENT '是否启用',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='物联网终端设备';

-- ----------------------------
-- Records of tgatedevice
-- ----------------------------
INSERT INTO `tgatedevice` VALUES ('1', '3', '3', '智能门锁', '21312', null, null, '213', '23', null);
INSERT INTO `tgatedevice` VALUES ('2', '3', '2', '人体红外感应', '422', null, null, '1', null, '2017-11-25 15:26:38');
INSERT INTO `tgatedevice` VALUES ('3', '1', '1', '智能摄像头', '213', null, null, '1', null, null);
INSERT INTO `tgatedevice` VALUES ('4', '2', null, '自动', '6', null, null, '1', null, null);
INSERT INTO `tgatedevice` VALUES ('5', null, null, 'GRGR', '7', null, null, '1', null, null);
INSERT INTO `tgatedevice` VALUES ('7', '1', null, '光度传感器', '4', null, null, '0', null, null);

-- ----------------------------
-- Table structure for `thistorydata`
-- ----------------------------
DROP TABLE IF EXISTS `thistorydata`;
CREATE TABLE `thistorydata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gdid` bigint(20) DEFAULT NULL COMMENT '终端设备ID,关联tgatedevice',
  `recordtime` datetime NOT NULL COMMENT '记录时间',
  `recorddata` text NOT NULL COMMENT '数据JSON格式',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='历史记录按照终端设备记录';

-- ----------------------------
-- Records of thistorydata
-- ----------------------------
INSERT INTO `thistorydata` VALUES ('1', '1010001', '2016-01-13 21:09:34', '{\"humi\":\"14\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('2', '1010001', '2019-01-13 21:09:39', '{\"humi\":\"13\",\"temp\":\"13\"}', null);
INSERT INTO `thistorydata` VALUES ('3', '1010001', '2019-01-13 21:09:44', '{\"humi\":\"16\",\"temp\":\"13\"}', null);
INSERT INTO `thistorydata` VALUES ('4', '1010001', '2019-01-13 21:09:49', '{\"humi\":\"15\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('5', '1010001', '2019-01-13 21:09:54', '{\"humi\":\"17\",\"temp\":\"18\"}', null);
INSERT INTO `thistorydata` VALUES ('6', '1010001', '2019-01-13 21:09:59', '{\"humi\":\"10\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('7', '1010001', '2019-01-13 21:10:04', '{\"humi\":\"13\",\"temp\":\"18\"}', null);
INSERT INTO `thistorydata` VALUES ('8', '1010001', '2019-01-13 21:10:09', '{\"humi\":\"11\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('9', '1010001', '2019-01-13 21:10:14', '{\"humi\":\"18\",\"temp\":\"14\"}', null);
INSERT INTO `thistorydata` VALUES ('10', '1010001', '2019-01-13 21:10:19', '{\"humi\":\"20\",\"temp\":\"19\"}', null);
INSERT INTO `thistorydata` VALUES ('11', '1010001', '2019-01-13 21:10:26', '{\"humi\":\"16\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('12', '1010001', '2019-01-13 21:10:31', '{\"humi\":\"17\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('13', '1010001', '2019-01-15 11:11:48', '{\"humi\":\"15\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('14', '1010002', '2019-01-15 11:11:53', '{\"humi\":\"18\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('15', '1010002', '2019-01-15 11:11:58', '{\"humi\":\"17\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('16', '1010002', '2019-01-15 11:12:03', '{\"humi\":\"10\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('17', '1010002', '2019-01-15 11:12:08', '{\"humi\":\"19\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('18', '1010002', '2019-01-15 11:12:13', '{\"humi\":\"16\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('19', '1010002', '2019-01-15 11:12:18', '{\"humi\":\"18\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('20', '1010002', '2019-01-15 11:12:23', '{\"humi\":\"11\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('21', '1010002', '2019-01-15 11:12:28', '{\"humi\":\"10\",\"temp\":\"19\"}', null);
INSERT INTO `thistorydata` VALUES ('22', '1010002', '2019-01-15 11:12:33', '{\"humi\":\"15\",\"temp\":\"17\"}', null);
INSERT INTO `thistorydata` VALUES ('23', '1010002', '2019-01-15 11:12:38', '{\"humi\":\"14\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('24', '1010002', '2019-01-15 11:12:43', '{\"humi\":\"10\",\"temp\":\"13\"}', null);
INSERT INTO `thistorydata` VALUES ('25', '1010002', '2019-01-15 11:12:48', '{\"humi\":\"16\",\"temp\":\"14\"}', null);
INSERT INTO `thistorydata` VALUES ('26', '1010002', '2019-01-15 11:12:53', '{\"humi\":\"17\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('27', '1010002', '2019-01-15 11:12:58', '{\"humi\":\"13\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('28', '1010002', '2019-01-15 11:13:03', '{\"humi\":\"20\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('29', '1010002', '2019-01-15 11:13:08', '{\"humi\":\"18\",\"temp\":\"14\"}', null);
INSERT INTO `thistorydata` VALUES ('30', '1010002', '2019-01-15 11:13:13', '{\"humi\":\"11\",\"temp\":\"18\"}', null);
INSERT INTO `thistorydata` VALUES ('31', '1010002', '2019-01-15 11:13:18', '{\"humi\":\"13\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('32', '1010002', '2019-01-15 11:13:23', '{\"humi\":\"10\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('33', '1010002', '2019-01-15 11:13:28', '{\"humi\":\"11\",\"temp\":\"20\"}', null);
INSERT INTO `thistorydata` VALUES ('34', '1010002', '2019-01-15 11:13:33', '{\"humi\":\"16\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('35', '1010002', '2019-01-15 11:13:38', '{\"humi\":\"16\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('36', '1010002', '2019-01-15 11:13:43', '{\"humi\":\"15\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('37', '1010002', '2019-01-15 11:13:48', '{\"humi\":\"16\",\"temp\":\"17\"}', null);
INSERT INTO `thistorydata` VALUES ('38', '1010002', '2019-01-15 11:13:53', '{\"humi\":\"19\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('39', '1010002', '2019-01-15 11:13:58', '{\"humi\":\"12\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('40', '1010002', '2019-01-15 11:14:03', '{\"humi\":\"10\",\"temp\":\"20\"}', null);
INSERT INTO `thistorydata` VALUES ('41', '1010002', '2019-01-15 11:14:08', '{\"humi\":\"11\",\"temp\":\"20\"}', null);
INSERT INTO `thistorydata` VALUES ('42', '1010002', '2019-01-15 11:14:13', '{\"humi\":\"18\",\"temp\":\"20\"}', null);
INSERT INTO `thistorydata` VALUES ('43', '1010002', '2019-01-15 11:14:18', '{\"humi\":\"11\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('44', '1010002', '2019-01-15 11:14:23', '{\"humi\":\"14\",\"temp\":\"13\"}', null);
INSERT INTO `thistorydata` VALUES ('45', '1010002', '2019-01-15 11:14:28', '{\"humi\":\"18\",\"temp\":\"19\"}', null);
INSERT INTO `thistorydata` VALUES ('46', '1010002', '2019-01-15 11:14:33', '{\"humi\":\"11\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('47', '1010002', '2019-01-15 11:14:38', '{\"humi\":\"11\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('48', '1010002', '2019-01-15 11:14:43', '{\"humi\":\"13\",\"temp\":\"13\"}', null);
INSERT INTO `thistorydata` VALUES ('49', '1010002', '2019-01-15 11:14:48', '{\"humi\":\"15\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('50', '1010002', '2019-01-15 11:14:53', '{\"humi\":\"11\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('51', '1010002', '2019-01-15 11:14:58', '{\"humi\":\"13\",\"temp\":\"17\"}', null);
INSERT INTO `thistorydata` VALUES ('52', '1010002', '2019-01-15 11:15:03', '{\"humi\":\"18\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('53', '1010002', '2019-01-15 11:15:08', '{\"humi\":\"12\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('54', '1010002', '2019-01-15 11:15:13', '{\"humi\":\"13\",\"temp\":\"13\"}', null);
INSERT INTO `thistorydata` VALUES ('55', '1010002', '2019-01-15 11:15:18', '{\"humi\":\"19\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('56', '1010002', '2019-01-15 11:15:23', '{\"humi\":\"10\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('57', '1010002', '2019-01-15 11:15:28', '{\"humi\":\"17\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('58', '1010001', '2019-01-15 11:38:59', '{\"humi\":\"12\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('59', '1010002', '2019-01-15 11:39:04', '{\"humi\":\"18\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('60', '1010002', '2019-01-15 11:39:09', '{\"humi\":\"17\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('61', '1010002', '2019-01-15 11:39:14', '{\"humi\":\"18\",\"temp\":\"13\"}', null);
INSERT INTO `thistorydata` VALUES ('62', '1010002', '2019-01-15 11:39:19', '{\"humi\":\"18\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('63', '1010002', '2019-01-15 11:39:24', '{\"humi\":\"18\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('64', '1010002', '2019-01-15 11:39:29', '{\"humi\":\"17\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('65', '1010002', '2019-01-15 11:39:34', '{\"humi\":\"15\",\"temp\":\"20\"}', null);
INSERT INTO `thistorydata` VALUES ('66', '1010002', '2019-01-15 11:39:39', '{\"humi\":\"16\",\"temp\":\"19\"}', null);
INSERT INTO `thistorydata` VALUES ('67', '1010002', '2019-01-15 11:39:44', '{\"humi\":\"13\",\"temp\":\"18\"}', null);
INSERT INTO `thistorydata` VALUES ('68', '1010002', '2019-01-15 11:39:49', '{\"humi\":\"16\",\"temp\":\"18\"}', null);
INSERT INTO `thistorydata` VALUES ('69', '1010002', '2019-01-15 11:39:54', '{\"humi\":\"12\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('70', '1010002', '2019-01-15 11:39:59', '{\"humi\":\"18\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('71', '1010002', '2019-01-15 11:40:04', '{\"humi\":\"16\",\"temp\":\"17\"}', null);
INSERT INTO `thistorydata` VALUES ('72', '1010002', '2019-01-15 11:40:09', '{\"humi\":\"14\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('73', '1010002', '2019-01-15 11:40:14', '{\"humi\":\"10\",\"temp\":\"20\"}', null);
INSERT INTO `thistorydata` VALUES ('74', '1010002', '2019-01-15 11:40:19', '{\"humi\":\"14\",\"temp\":\"17\"}', null);
INSERT INTO `thistorydata` VALUES ('75', '1010002', '2019-01-15 11:40:24', '{\"humi\":\"13\",\"temp\":\"18\"}', null);
INSERT INTO `thistorydata` VALUES ('76', '1010002', '2019-01-15 11:40:29', '{\"humi\":\"14\",\"temp\":\"20\"}', null);
INSERT INTO `thistorydata` VALUES ('77', '1010002', '2019-01-15 11:40:35', '{\"humi\":\"18\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('78', '1010002', '2019-01-15 11:40:39', '{\"humi\":\"16\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('79', '1010002', '2019-01-15 11:40:44', '{\"humi\":\"17\",\"temp\":\"17\"}', null);
INSERT INTO `thistorydata` VALUES ('80', '1010002', '2019-01-15 11:40:49', '{\"humi\":\"20\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('81', '1010002', '2019-01-15 11:40:54', '{\"humi\":\"14\",\"temp\":\"19\"}', null);
INSERT INTO `thistorydata` VALUES ('82', '1010002', '2019-01-15 11:40:59', '{\"humi\":\"17\",\"temp\":\"13\"}', null);
INSERT INTO `thistorydata` VALUES ('83', '1010002', '2019-01-15 11:41:04', '{\"humi\":\"10\",\"temp\":\"19\"}', null);
INSERT INTO `thistorydata` VALUES ('84', '1010002', '2019-01-15 11:41:09', '{\"humi\":\"10\",\"temp\":\"19\"}', null);
INSERT INTO `thistorydata` VALUES ('85', '1010002', '2019-01-15 11:41:14', '{\"humi\":\"12\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('86', '1010002', '2019-01-15 11:41:19', '{\"humi\":\"17\",\"temp\":\"17\"}', null);
INSERT INTO `thistorydata` VALUES ('87', '1010002', '2019-01-15 11:41:24', '{\"humi\":\"12\",\"temp\":\"14\"}', null);
INSERT INTO `thistorydata` VALUES ('88', '1010002', '2019-01-15 11:41:30', '{\"humi\":\"16\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('89', '1010002', '2019-01-15 11:41:35', '{\"humi\":\"17\",\"temp\":\"18\"}', null);
INSERT INTO `thistorydata` VALUES ('90', '1010002', '2019-01-15 11:41:40', '{\"humi\":\"17\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('91', '1010002', '2019-01-15 11:41:45', '{\"humi\":\"18\",\"temp\":\"10\"}', null);
INSERT INTO `thistorydata` VALUES ('92', '1010002', '2019-01-15 11:41:50', '{\"humi\":\"13\",\"temp\":\"14\"}', null);
INSERT INTO `thistorydata` VALUES ('93', '1010002', '2019-01-15 11:41:55', '{\"humi\":\"15\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('94', '1010002', '2019-01-15 11:42:00', '{\"humi\":\"12\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('95', '1010002', '2019-01-15 11:42:05', '{\"humi\":\"17\",\"temp\":\"15\"}', null);
INSERT INTO `thistorydata` VALUES ('96', '1010002', '2019-01-15 11:42:10', '{\"humi\":\"10\",\"temp\":\"11\"}', null);
INSERT INTO `thistorydata` VALUES ('97', '1010002', '2019-01-15 11:42:15', '{\"humi\":\"12\",\"temp\":\"18\"}', null);
INSERT INTO `thistorydata` VALUES ('98', '1010002', '2019-01-15 11:42:20', '{\"humi\":\"15\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('99', '1010002', '2019-01-15 11:42:25', '{\"humi\":\"15\",\"temp\":\"12\"}', null);
INSERT INTO `thistorydata` VALUES ('100', '1010002', '2019-01-15 11:42:30', '{\"humi\":\"18\",\"temp\":\"16\"}', null);
INSERT INTO `thistorydata` VALUES ('101', '1010002', '2019-01-15 11:42:35', '{\"humi\":\"15\",\"temp\":\"17\"}', null);
INSERT INTO `thistorydata` VALUES ('102', '1010002', '2019-01-15 11:42:40', '{\"humi\":\"10\",\"temp\":\"12\"}', null);

-- ----------------------------
-- Table structure for `tproject`
-- ----------------------------
DROP TABLE IF EXISTS `tproject`;
CREATE TABLE `tproject` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `projectname` varchar(256) NOT NULL COMMENT '项目名称',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='物联网监控项目';

-- ----------------------------
-- Records of tproject
-- ----------------------------
INSERT INTO `tproject` VALUES ('1', '1', '智能家居系统', null, '2017-11-25 15:14:30');
INSERT INTO `tproject` VALUES ('2', '1', '无人超市系统', 'fayv', '2019-01-11 22:56:20');
INSERT INTO `tproject` VALUES ('3', '3', '私有云项目', '12131f', '2019-01-11 22:56:50');
INSERT INTO `tproject` VALUES ('5', '3', '智能城市', 'solo', '2019-01-14 21:15:20');
INSERT INTO `tproject` VALUES ('6', '5', '智能邮箱', '4321', '2019-01-14 21:15:33');

-- ----------------------------
-- Table structure for `tuser`
-- ----------------------------
DROP TABLE IF EXISTS `tuser`;
CREATE TABLE `tuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(128) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `remark` varchar(1024) DEFAULT NULL COMMENT '备注',
  `truename` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `telephone` varchar(50) DEFAULT NULL COMMENT '电话',
  `address` varchar(150) DEFAULT NULL COMMENT '住址',
  `addtime` datetime DEFAULT NULL COMMENT '添加时间',
  `userenabled` int(11) DEFAULT '1' COMMENT '是否启用',
  `usertype` varchar(50) DEFAULT NULL COMMENT '用户类型：普通用户（管理自己的监控设备），管理员（可以管理用户和设备）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of tuser
-- ----------------------------
INSERT INTO `tuser` VALUES ('1', 'admin', 'admin', null, 'admin', null, null, '2017-11-25 13:07:28', '1', '管理员');
INSERT INTO `tuser` VALUES ('2', 'root', 'root', null, null, null, null, null, '1', '普通用户');
INSERT INTO `tuser` VALUES ('4', 'jsq', '123456', null, null, null, null, null, '1', '游客');

-- ----------------------------
-- Table structure for `yydk_keyword`
-- ----------------------------
DROP TABLE IF EXISTS `yydk_keyword`;
CREATE TABLE `yydk_keyword` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) DEFAULT NULL,
  `keyword_value` char(50) DEFAULT NULL,
  PRIMARY KEY (`keyword_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yydk_keyword
-- ----------------------------
INSERT INTO `yydk_keyword` VALUES ('9', '1', 'jsp');
INSERT INTO `yydk_keyword` VALUES ('10', '1', '新闻');
INSERT INTO `yydk_keyword` VALUES ('11', '1', '发布系统');
INSERT INTO `yydk_keyword` VALUES ('12', '1', 'jspcn');
INSERT INTO `yydk_keyword` VALUES ('13', '3', 'Eclipse');
INSERT INTO `yydk_keyword` VALUES ('14', '3', '入门');
INSERT INTO `yydk_keyword` VALUES ('15', '4', 'jspcn');
INSERT INTO `yydk_keyword` VALUES ('16', '5', 'jspcn');
INSERT INTO `yydk_keyword` VALUES ('17', '6', 'jspcn');

-- ----------------------------
-- Table structure for `yydk_log`
-- ----------------------------
DROP TABLE IF EXISTS `yydk_log`;
CREATE TABLE `yydk_log` (
  `logrecord_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT NULL,
  `operation_time` datetime DEFAULT NULL,
  `ogrecord_operation` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`logrecord_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yydk_log
-- ----------------------------
INSERT INTO `yydk_log` VALUES ('1', '王辉', '2004-09-29 21:55:41', 'add type name: jsp');
INSERT INTO `yydk_log` VALUES ('2', '王辉', '2004-09-29 21:55:45', 'add type name: asp');
INSERT INTO `yydk_log` VALUES ('3', '王辉', '2004-09-29 21:56:04', 'modify type name to: JSP技术 type_id: 1');
INSERT INTO `yydk_log` VALUES ('4', '王辉', '2004-09-29 21:56:19', 'modify type name to: ASP技术 type_id: 2');
INSERT INTO `yydk_log` VALUES ('5', '王辉', '2004-09-29 21:58:01', 'add board name: JSP基础 type: 1');
INSERT INTO `yydk_log` VALUES ('6', '王辉', '2004-09-29 21:58:15', 'add board name: ASP基础 type: 2');
INSERT INTO `yydk_log` VALUES ('7', '王辉', '2004-09-29 21:58:59', 'add news type: 1,board: 1, news title: jsp');
INSERT INTO `yydk_log` VALUES ('8', '王辉', '2004-09-29 22:02:04', 'add news type: 1,board: 1, news title: jsp入门');
INSERT INTO `yydk_log` VALUES ('9', '王辉', '2004-09-29 22:03:19', 'modify type name to: 技术新闻 type_id: 1');
INSERT INTO `yydk_log` VALUES ('10', '王辉', '2004-09-29 22:03:39', 'update board name to JSP新闻,type_id: 1');
INSERT INTO `yydk_log` VALUES ('11', '王辉', '2004-09-29 22:03:49', 'delete news type: 1,board: 1, news_id: 2');
INSERT INTO `yydk_log` VALUES ('12', '王辉', '2004-09-29 22:04:38', 'update news where news_id is 1');
INSERT INTO `yydk_log` VALUES ('13', '王辉', '2004-09-29 22:38:35', '王辉 login system');
INSERT INTO `yydk_log` VALUES ('14', '王辉', '2004-09-29 22:39:13', 'update board name to JSP中文网,type_id: 1');
INSERT INTO `yydk_log` VALUES ('15', '王辉', '2004-09-29 22:39:34', 'modify type name to: JSP技术 type_id: 2');
INSERT INTO `yydk_log` VALUES ('16', '王辉', '2004-09-29 22:39:49', 'update board name to JSP基础,type_id: 2');
INSERT INTO `yydk_log` VALUES ('17', '王辉', '2004-09-29 22:40:01', 'add board name: JSP中文 type: 1');
INSERT INTO `yydk_log` VALUES ('18', '王辉', '2004-09-29 22:40:07', 'update board name to JSP中文,type_id: 2');
INSERT INTO `yydk_log` VALUES ('19', '王辉', '2004-09-29 22:40:21', 'add board name: JSP上传 type: 2');
INSERT INTO `yydk_log` VALUES ('20', '王辉', '2004-09-29 22:40:33', 'add type name: ASP技术');
INSERT INTO `yydk_log` VALUES ('21', '王辉', '2004-09-29 22:40:44', 'add board name: ASP基础 type: 3');
INSERT INTO `yydk_log` VALUES ('22', '王辉', '2004-09-29 22:40:55', 'add type name: PHP技术');
INSERT INTO `yydk_log` VALUES ('23', '王辉', '2004-09-29 22:41:07', 'add board name: PHP基础 type: 4');
INSERT INTO `yydk_log` VALUES ('24', '王辉', '2004-09-29 22:41:36', 'add board name: PHP配置 type: 4');
INSERT INTO `yydk_log` VALUES ('25', '王辉', '2004-09-29 22:43:55', 'update news where news_id is 1');
INSERT INTO `yydk_log` VALUES ('26', '王辉', '2004-09-29 22:50:00', 'add news type: 2,board: 2, news title: Eclipse使用入门');
INSERT INTO `yydk_log` VALUES ('27', '王辉', '2004-09-29 22:51:29', 'add news type: 1,board: 1, news title: JSP新闻发布系统2');
INSERT INTO `yydk_log` VALUES ('28', '王辉', '2004-09-29 22:52:53', 'add news type: 1,board: 1, news title: JSP新闻发布系统3');
INSERT INTO `yydk_log` VALUES ('29', '王辉', '2004-09-29 22:53:54', 'add news type: 1,board: 1, news title: JSP新闻发布系统4');

-- ----------------------------
-- Table structure for `yydk_news`
-- ----------------------------
DROP TABLE IF EXISTS `yydk_news`;
CREATE TABLE `yydk_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `emphsis_id` int(11) DEFAULT NULL,
  `news_title` varchar(200) DEFAULT NULL,
  `news_hits` int(11) DEFAULT NULL,
  `news_source` varchar(100) DEFAULT NULL,
  `news_author` varchar(100) DEFAULT NULL,
  `news_time` datetime DEFAULT NULL,
  `news_modify_time` datetime DEFAULT NULL,
  `news_modify_person` int(11) DEFAULT NULL,
  `news_check` int(11) DEFAULT NULL,
  `news_checker` int(11) DEFAULT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yydk_news
-- ----------------------------
INSERT INTO `yydk_news` VALUES ('1', '1', '1', '青海超限超载车辆禁止进高速 无违章可优惠通行费', '19', '中国新闻网', null, '2014-02-21 21:58:59', '2014-03-18 22:49:59', '1', '1', '1');
INSERT INTO `yydk_news` VALUES ('2', '1', '2', '锡城“面包新语”未见产品下架', '4', '中国新闻网', null, '2014-03-18 22:49:59', '2014-03-18 22:49:59', '1', '1', '1');
INSERT INTO `yydk_news` VALUES ('3', '1', '1', '东莞“铁腕治污”将环保考核列干部政绩重要依据', '7', '中国新闻网', null, '2014-03-18 08:49:59', '2014-03-18 22:49:59', '1', '1', '1');
INSERT INTO `yydk_news` VALUES ('4', '1', '1', '北京：公务接待后须填“花销清单”', '1', '中国新闻网', null, '2014-03-18 08:49:59', '2014-03-18 22:49:59', '1', '1', '1');
INSERT INTO `yydk_news` VALUES ('5', '2', '1', '马航MH370失踪会是一盘大棋吗？', '1', '中国新闻网', null, '2014-03-18 08:49:59', '2014-03-18 22:49:59', '1', '1', '1');
INSERT INTO `yydk_news` VALUES ('7', '2', '2', '普京藐视西方制裁，签署命令将克里米亚纳入俄罗斯', '3', '中国新闻网', null, '2014-03-18 08:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('8', '2', '1', '韩俄举行高官会议 商讨罗津至哈桑铁路项目事宜', '1', '中国新闻网', null, '2014-03-18 06:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('9', '3', '1', '曝曼联高层有意解雇莫耶斯 未来三场定其命运', '20', '中国新闻网', null, '2014-03-18 07:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('10', '3', '1', '曝德罗巴最快今夏回切尔西 免费加盟帮穆帅过渡', '11', '中国新闻网', null, '2014-03-18 08:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('11', '3', '1', '曝囧叔报国无门或执教希腊 马队炮轰米兰已被毁', '13', '中国新闻网', null, '2014-03-18 08:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('12', '4', '1', '日本要求中国核裁军 欲牵制中国核战斗力增长', '41', '中国新闻网', null, '2014-03-18 08:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('13', '4', '1', '金正恩指导朝空军飞行训练 称建“天上的敢死队”', '23', '中国新闻网', null, '2014-03-18 12:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('14', '4', '1', '马航怀疑有一特殊中国乘客 或已飞美军基地', '13', '中国新闻网', null, '2014-03-18 12:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('15', '5', '1', '中国智能硬件开发板玩家大盘点', '11', '中国新闻网', null, '2014-03-18 21:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('16', '5', '1', '智能家居入口开战 平台化成关键点', '5', '中国新闻网', null, '2014-03-18 20:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('17', '5', '1', 'Home Try-On模式在中国能否成功？', '2', '中国新闻网', null, '2014-03-18 20:40:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('18', '6', '1', '8旬老人火车站扶梯上摔倒 4个小伙冲去扶起', '3', '中国新闻网', null, '2014-03-18 20:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('19', '6', '1', '珠海年内将建立司机、乘客黑名单', '22', '中国新闻网', null, '2014-03-18 12:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('20', '6', '1', '沈阳老人义务护鸟数十年 买不起一部手机', '14', '中国新闻网', null, '2014-03-18 21:49:59', '2014-03-18 22:49:59', null, null, null);
INSERT INTO `yydk_news` VALUES ('22', '3', '2', 'bbbbbbbbbbbbbbbbbbbbb', '6', 'bbb', null, '2014-04-05 07:33:24', null, null, null, null);

-- ----------------------------
-- Table structure for `yydk_news_detail`
-- ----------------------------
DROP TABLE IF EXISTS `yydk_news_detail`;
CREATE TABLE `yydk_news_detail` (
  `news_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) DEFAULT NULL,
  `news_content` varchar(1000) DEFAULT NULL,
  `news_content_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`news_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yydk_news_detail
-- ----------------------------
INSERT INTO `yydk_news_detail` VALUES ('4', '1', '中新网西宁3月18日电 (胡友军)“在具备改造条件的高速公路入口处设置超限预检系统和超限劝返站，对超限车辆坚决拦截、劝返，在建、新建高速公路一律实施入口预检劝返系统建设，禁止一切超限超载车辆进入高速公路，目前这些工作我省交通部门已经全面实施。”3月18日，青海省治超工作领导小组副组长、交通厅厅长韩建华表示，对全年无违章记录的企业和个人，给予车辆通行费优惠政策。', '');
INSERT INTO `yydk_news_detail` VALUES ('5', '3', '中新社东莞3月18日电 (李映民 周霞)广东东莞的污染问题历来备受各界关注，该市18日召开的市政府常务会议审议通过多个环保议题，将环保考核结果列为干部政绩重要依据。\r\n\r\n　　会议审议通过了《东莞市环境保护责任考核办法》及《东莞市环境保护责任考核指标体系》。考核对象是镇政府(街道办、管委会)及主要负责人、分管环保工作的责任人和环保行政主管部门主要责任人。环境保护责任考核结果分为优秀、良好、合格和不合格4个档次，“办法”具体规定了考核结果不合格和下降一个档次的情况，并作为评价干部政绩、年度考核、实行奖惩和任用的重要依据之一。\r\n\r\n中新社东莞3月18日电 (李映民 周霞)广东东莞的污染问题历来备', '');
INSERT INTO `yydk_news_detail` VALUES ('6', '2', '　央视315晚会曝光了某食品公司长期向多家知名面包店供应发霉原材料后，虽然面包新语方面一再声称，仅杭州门店采购过涉事食品公司的原料，但销售还是多少受到了影响。昨天上午，记者在清扬路一家面包新语门店看到，前来购买面包的顾客寥寥无几。店长说，店内所有的面包都正常销售，没有产品因此而下架。', null);
INSERT INTO `yydk_news_detail` VALUES ('7', '4', '今天公布的《北京市党政机关国内公务接待管理办法》明确要求，公务活动结束后，接待单位应当如实填写北京市党政机关国内公务接待清单，内容包括接待对象的单位、姓名、职务和公务活动项目、时间、接待场所、费用以及接待陪同人员情况等。不得以任何名义新建、改建、扩建内部接待场所，不得进行超标准装修或者装饰、超标准配置家具和电器。 \r\n今天公布的《北京市党政机关国内公务接待管理办法》明确要求，公务活动结束后，接待单位应当如实填写北京市党政机关国内公务接待清单，内容包括接待对象的单位、姓名、职务和公务活动项目、时间、接待场所、费用以及接待陪同人员情况等。不得以任何名义新建、改建、扩建内部接待场所，不得进行超标准装修或者装饰、超标准配置家具和电器。 \r\n', null);
INSERT INTO `yydk_news_detail` VALUES ('8', '5', '笼罩在马航失联客机上的巨大迷团，前天下午浮现出重大并且极其颠覆性的线索。作为马来西亚政府最高首脑，纳吉布在电视镜头前亲口宣布，有证据表明，是有人蓄意改变了MH370的航向，呼叫应答系统被人为关闭，航班最后与卫星失去联系的时间是当地时间8日早上8点11分，哈萨克斯坦、土库曼斯坦一直延伸到泰国以及印度尼西亚到南印度洋这两个走廊地带很可能是飞机前往的方向。\r\n\r\n尽管马来官方的正式口径仍是“难以确定是否涉及恐怖主义”，但根据“飞机从雷达消失前有战术躲避动作”等细节，人们已经普遍相信，MH370是被劫持，而机长很可能参与了行动。', null);
INSERT INTO `yydk_news_detail` VALUES ('9', '6', '普京签署命令“批准俄罗斯联邦与克里米亚共和国之间的条约草案，将克里米亚共和国纳入俄罗斯联邦。”命令显示，（俄罗斯）总统将与克里米亚俄方扶持的领导人签署协议，但未给出具体日期。克里米亚领导人目前在莫斯科，要求并入俄罗斯。\r\n    上周日，在俄罗斯军队占领下的克里米亚举行了公投，这次公投充满争议，投票结果以苏联式的风格宣称97%的选民支持回归俄罗斯。此前克里米亚成为乌克兰领土已经60年。普京推动克里米亚脱离乌克兰的举动，引发东西方面临冷战结束以来最严峻危机的风险。', null);
INSERT INTO `yydk_news_detail` VALUES ('10', '7', '韩国与俄罗斯18日在位于首尔的韩国外交部大楼举行了第14届次官级（副部长级）政策协商会议，俄罗斯副外长、六方会谈俄方团长莫尔古洛夫（右）作为俄方代表出席了会议。（韩联社）', null);
INSERT INTO `yydk_news_detail` VALUES ('11', '8', '中新网3月18日电 据韩联社报道，韩国与俄罗斯18日在位于首尔的韩国外交部大楼举行了第14届次官级(副部长级)政策协商会议，就扩大两国实质性合作的方案、朝鲜半岛和东北亚局势等深入交换了意见。\r\n\r\n　　韩国外交部次官补(部长助理)李京秀和俄罗斯副外长、六方会谈俄方团长莫尔古洛夫作为两国代表出席了会议。据悉，双方就韩朝俄三方合作项目——罗津至哈桑铁路项目进行了集中讨论。', null);
INSERT INTO `yydk_news_detail` VALUES ('12', '9', '一位曼联俱乐部的内部人士告诉《ESPN》，“尽管格雷泽家族的决策层一直力挺莫耶斯，但是他们现在的立场也开始倾向于更换球队主帅，接下来的一周，曼联的战绩将对莫耶斯的去留起到决定性的作用。在这个时间段内，曼联要首先在主场面对奥林匹亚科斯，而他们在客场输了一个0-2。紧接着，曼联将迎来同西汉姆联的联赛以及同曼城(官方微博 数据) 的德比大战。如果能够在欧冠(微博 专题) 联赛逆转晋级，那么曼联队就能卸下不少的压力，从而更好的备战另外2场赛事。目前，格雷泽家族就认为曼联的状况已经非常吃紧，而主场0-3负于利物浦(官方微博 数据) 更是加剧了高层的担心，一些曼联官员公开表示球队在管理上的变动势在必行。”', null);
INSERT INTO `yydk_news_detail` VALUES ('13', '10', '欧冠对阵加拉塔萨雷的比赛前，穆里尼奥明确表示，德罗巴在未来肯定会重新回到切尔西，但是具体回归的时间是一个未知数。本来人们只是把这句话当做是德罗巴和穆帅以及切尔西的伟大感情的表达而已，而且也没有真的去较真魔兽到底会在什么时候重新回到斯坦福桥。但是现在据英国媒体《镜报》透露称，德罗巴重新回到切尔西不仅仅是有可能，而且是完全有希望实现，甚至最快在下赛季就能上演这场伟大的再相聚好戏。', null);
INSERT INTO `yydk_news_detail` VALUES ('14', '11', '阿莱格里让米兰球迷又爱又恨，他虽然带领球队夺得过意甲冠军，可是红黑军团堕落至此，他的责任也不小。被米兰炒掉后，阿帅一直赋闲在家，近日他收到了一份执教邀请。北京时间3月18日，据意大利《天空体育》报道，阿莱格里有望执教希腊队。囧叔的执教前途突现光明，但米兰现在却依旧处于水深火热中，传奇队长马尔蒂尼如今都忍不住发话了，马队表示现在的米兰让他愤怒伤心，并直言“某些人”正在毁掉米兰。', null);
INSERT INTO `yydk_news_detail` VALUES ('15', '12', '据日本共同社17日报道，日本政府消息人士16日透露，4月将在日本广岛举行的“核裁军和核不扩散倡议”(NPDI)外长会议将发表共同声明，首次写入要求中国等参加旨在削减核弹头数量的美俄磋商，还将明确要求在多边框架下推进核裁军。NPDI是由日本等12个无核武国家组成的国际组织。该报道称，日本政府该举动的目的在于“对五个核持有国中唯一还在增加核战斗力的中国进行牵制”。', null);
INSERT INTO `yydk_news_detail` VALUES ('16', '13', '据朝中社17日报道，朝鲜最高领导人金正恩指导朝鲜人民军航空与防空军第188部队的飞行训练。\r\n　　朝鲜人民军航空与防空军司令官李炳哲和部队指挥官到场迎接。\r\n　　在金正恩下令开始飞行训练后，飞机陆续起飞。各飞行编队急速上升，再向“敌阵”急速俯冲，展现了朝鲜人民军的“战斗气概”。', null);
INSERT INTO `yydk_news_detail` VALUES ('17', '14', '美国媒体3月16日称，两名高级官员透露，新信息显示，MH370航班从雷达消失后做出了战术躲避动作，美国执法和情报官员正调查至少一名飞行员参与事件的可能性。 \r\n\r\n　　在对乘客和机组人员进行调查后，一名官员说，无迹象显示除飞行员外飞机上有人有能力执行如此复杂的机动操作。不过也不排除飞行员被迫行事，改变航线的可能。 \r\n\r\n　　美国媒体称，雷达显示，飞机一度飞到超出飞行极限的4.5万英尺，随后又降至2.3万英尺高度。有分析认为，升至超规高度可能是为了减压弄昏机上人员\r\n', null);
INSERT INTO `yydk_news_detail` VALUES ('18', '15', '这段时间有幸在寨都深圳走访了几家专业开发板的生产厂家，对于国内开发板情况算是有一个新的认识。\r\n\r\nCPU厂商为了将产品推向市场，为了让客户了解CPU的各项性能及电路设计而专门设计的一块电路板，开发板同时会附带硬件接口的驱动程序，开发板电路板将CPU的控制信号线及通用的外围接口延引出来。有了硬件接口及驱动程序，设计人员可以快速专注产品应用软件的开发，完成应用软件对外围电路进行控制测试，软件调试完毕后交付批量生产，完成产品的开发。\r\n\r\n由于厂商推广的开发板价格高企，有没有价格低廉、大众玩家都玩得起的开源开发板呢？有，在国外玩家的推动下，玩家对特定CPU体系自组社区，并规模硬件设计、完善多平台开发环境及软件模块标准化。开源的软硬件设计让爱好者花费很少的费用就能完成想开发的功能。', null);
INSERT INTO `yydk_news_detail` VALUES ('19', '16', '持续的雾霾,使得围绕着空气议题的智能家居，成为智能硬件领域、传统的家电企业、互联网公司共同聚焦的热点，并引发一场围绕智能家居“入口之战”。1月份，谷歌宣布以32亿美金高价收购美国智能空气企业NEST更是刺激了国内企业和资本的神经。\r\n\r\n家电老大海尔在年初的CES展上推出其首款智能设备空气球(又名海尔空气盒子)，据媒体报道该产品将于近期从电商渠道进行预售;互联网新贵小米公司也于之前推出其路由器产品的预售，并定位于智能家居产品;而新兴创业者同样不甘示弱，创业一年多的“家庭环境管家”iKair在众筹网站展开预售，并宣称“有信心成为中国的NEST”!', null);
INSERT INTO `yydk_news_detail` VALUES ('20', '17', '交一副眼镜框架钱后，5副眼镜送上门供顾客试戴，5天后留下自己喜欢的一款，剩下的对方上门回收并赠送一对镜片。听起来很夸张的事，其实是国内眼镜业的垂直电商“可得眼镜网”最近正在推的一项新服务：“在家试戴、5选最爱”。这个网站希望通过该服务，解决中国用户网络配镜带来的无法试戴、验光等问题，把网络配镜服务推广开来。\r\n\r\n成功的“试戴”模式\r\n\r\n“可得眼镜网”是国内最大的网上眼镜商城，根据2013年其合并艾视网时发布的有关数据，它的眼镜网络销量已连续六年全国第一，市场份额保守估计超过65%。而此次推出的试戴服务，在国内也属首创，称得上是眼镜业在服务方式上的突破。但是，对于这种“试戴”销售模式能否在中国行得通，还是值得考量的。', null);
INSERT INTO `yydk_news_detail` VALUES ('21', '18', '昨天上午11时，重庆晚报记者在渝北区龙华大道1809号一处民居内，见到了赵大爷。赵大爷行动缓慢，走路需要拄着拐杖。他掏出一张火车票：成都东到重庆北，3月10日13点13分开。\r\n　　“今年1月11日，我和爱人到成都亲戚家玩。3月10日下午3点40分左右，我们回到重庆。”赵大爷说，由于手机信号不好，和接站的家人错过了。', null);
INSERT INTO `yydk_news_detail` VALUES ('22', '19', '日前，珠海一名的士司机向市交通主管部门投诉，表示希望禁止的士司机安装滴滴打车软件。市交通运输局公交科作出回复：珠海拟将打车软件接入电召平台统一监管，司机可利用现有车载设备直接抢标，年内珠海还将建立司机、乘客黑名单。\r\n\r\n　　的士司机投诉打车软件三重困扰\r\n\r\n　　的士司机黄先生投诉，打车软件今年在珠海运行后给很多的士司机带来了困扰：“第一，如果不安装这个软件，司机会少很多乘客；第二，如果安装了这个软件，在去接单的途中，司机不可避免地会面临拒载的情况；第三，有了这个软件，很多司机都只顾着抢单，开车时也盯着手机，会增加安全隐患。”\r\n\r\n　　黄先生表示，这个软件不是政府开发并投入使用的，因此希望相关部门可以禁止的士司机安装使用这个软件。\r\n\r\n　　据记者了解，滴滴打车软件自上月底进入珠海，已安装该软件的司机有2155名。不过，目前软件公司对司乘双方的补贴已大幅下降。现在在珠海，乘客每单有5—10元的随机奖励，每天两单，而司机有每单2元的奖励，共有5单。\r\n\r\n', null);
INSERT INTO `yydk_news_detail` VALUES ('23', '20', '“我就是内心喜欢，单纯地想保护鸟。有人问我图啥呢，有这工夫干点儿别的挣钱好不好，我就图心里舒服，有人来看鹤就是对我最大的鼓舞。”75岁老人王振友质朴的言语中透露着坚毅。\r\n\r\n　　王振友是沈阳法库县一位土生土长的农民，从小热爱鸟类。20多岁便在法库獾子洞周边做起义务护鸟工作。\r\n\r\n　　獾子洞水库位于沈阳西北70公里处，这个水库东西宽约5公里，南北宽约3公里。王振友介绍，水库靠雨水补给，水深仅半米左右。这个湿地型水库为鸟类提供了优越的生存环境，成为候鸟迁徙的重要中转站，更是珍稀鸟类白鹤于鄱阳湖到西伯利亚南、北迁徙的第一站。法库县曾被中国野生动物保护协会授予“中国白鹤之乡”称号。\r\n\r\n', null);
INSERT INTO `yydk_news_detail` VALUES ('25', '22', 'adsfasdfasdfasdf', null);

-- ----------------------------
-- Table structure for `yydk_review`
-- ----------------------------
DROP TABLE IF EXISTS `yydk_review`;
CREATE TABLE `yydk_review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) DEFAULT NULL,
  `reviewer` varchar(100) DEFAULT NULL,
  `reviewer_email` varchar(100) DEFAULT NULL,
  `reviewer_blog` varchar(100) DEFAULT NULL,
  `review_content` text,
  `review_time` datetime DEFAULT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yydk_review
-- ----------------------------
INSERT INTO `yydk_review` VALUES ('1', '9', '指南针', 'cunstomer2@jspNews.com', null, '鲁能绝对不是主教练的问题，也不是某个球员的问题，是鲁能俱乐部太把自己当回事了。装逼遭雷劈一点不假。在国内一直显摆自己的硬件好的上天，在国外打个比赛，每个人都住单间，怎么样？', '2014-03-17 09:50:58');
INSERT INTO `yydk_review` VALUES ('2', '9', '~~同行天下~~', 'cunstomer1@jspNews.com', null, '向恒大学习吧，多打一人还玩龟缩。不输就很幸运！', '2014-03-16 20:25:14');
INSERT INTO `yydk_review` VALUES ('4', '9', '我的深林', 'cunstomer34@jspNews.com', null, '中国PK韩国足球的差距太大了，拼劲不够，体能不足，配合不默契，还有技不如人，整个中国也许也只有一个郑智能和韩国比一下，但是他也老了。', '2014-03-18 08:14:52');
INSERT INTO `yydk_review` VALUES ('7', '5', 'aaaa', '', null, '是不是认为破坏', '2014-03-19 20:02:51');
INSERT INTO `yydk_review` VALUES ('8', '5', 'fff', '', null, 'ddd', '2014-03-19 20:04:11');
INSERT INTO `yydk_review` VALUES ('11', '22', '1', '', null, 'qweqw', '2014-04-05 07:44:07');

-- ----------------------------
-- Table structure for `yydk_tiplist`
-- ----------------------------
DROP TABLE IF EXISTS `yydk_tiplist`;
CREATE TABLE `yydk_tiplist` (
  `tip_id` int(11) NOT NULL AUTO_INCREMENT,
  `tip_list` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`tip_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yydk_tiplist
-- ----------------------------
INSERT INTO `yydk_tiplist` VALUES ('1', 'abc');
INSERT INTO `yydk_tiplist` VALUES ('2', 'add');
INSERT INTO `yydk_tiplist` VALUES ('3', 'afs');
INSERT INTO `yydk_tiplist` VALUES ('4', 'afd');
INSERT INTO `yydk_tiplist` VALUES ('5', 'aaa');
INSERT INTO `yydk_tiplist` VALUES ('6', '核裁军');
INSERT INTO `yydk_tiplist` VALUES ('7', '曼联');
INSERT INTO `yydk_tiplist` VALUES ('8', 'a');
INSERT INTO `yydk_tiplist` VALUES ('9', 'kk');
INSERT INTO `yydk_tiplist` VALUES ('10', 'h');

-- ----------------------------
-- Table structure for `yydk_type`
-- ----------------------------
DROP TABLE IF EXISTS `yydk_type`;
CREATE TABLE `yydk_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_caption` char(30) DEFAULT NULL,
  `type_info` char(100) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yydk_type
-- ----------------------------
INSERT INTO `yydk_type` VALUES ('1', '技术新闻', '技术新闻');
INSERT INTO `yydk_type` VALUES ('2', 'JSP技术', 'JSP技术');
INSERT INTO `yydk_type` VALUES ('3', 'ASP技术', 'ASP技术');
INSERT INTO `yydk_type` VALUES ('4', 'PHP技术', 'PHP技术');

-- ----------------------------
-- Table structure for `yydk_user`
-- ----------------------------
DROP TABLE IF EXISTS `yydk_user`;
CREATE TABLE `yydk_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_account` varchar(30) DEFAULT NULL,
  `user_name` varchar(30) DEFAULT NULL,
  `user_password` varchar(60) DEFAULT NULL,
  `user_email` varchar(60) DEFAULT NULL,
  `user_mobile` varchar(20) DEFAULT NULL,
  `user_qq` varchar(10) DEFAULT NULL,
  `user_privilege` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yydk_user
-- ----------------------------
INSERT INTO `yydk_user` VALUES ('1', 'admin', '杨谊', 'admin', 'aaa@163.com', '13812345678', '4866815', '10000');
INSERT INTO `yydk_user` VALUES ('2', 'abc', null, '1234567', null, null, null, null);
INSERT INTO `yydk_user` VALUES ('3', 'aaa', null, '1234567', null, null, null, null);
INSERT INTO `yydk_user` VALUES ('4', 'add', null, '1234567', null, null, null, null);
INSERT INTO `yydk_user` VALUES ('5', 'ddd', null, '1234567', null, null, null, null);
INSERT INTO `yydk_user` VALUES ('6', 'ee', null, '1234567', null, null, null, null);
INSERT INTO `yydk_user` VALUES ('10', 'ff2', 'adsfada', 'asdfad', '', '', '', '0');
INSERT INTO `yydk_user` VALUES ('11', 'jsq123', null, 'jsq123', null, null, null, null);
INSERT INTO `yydk_user` VALUES ('12', 'jsq1234', null, 'jsq123', null, null, null, null);
