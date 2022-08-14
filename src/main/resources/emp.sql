/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : emp

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 14/08/2022 15:35:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_dept
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dept_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `dept_loc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地点',
  `dept_count` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工数量',
  `dept_leader` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门领导',
  `dept_text` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dept
-- ----------------------------
INSERT INTO `t_dept` VALUES (1, '管理部', '北京', '20', '张小理', '专注管理');
INSERT INTO `t_dept` VALUES (2, '设计部', '北京', '50', '李小设', '');

-- ----------------------------
-- Table structure for t_employee
-- ----------------------------
DROP TABLE IF EXISTS `t_employee`;
CREATE TABLE `t_employee`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `employee_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `employee_sex` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别:男/女',
  `employee_phone` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `employee_dept` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `employee_job` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位',
  `employee_no` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `employee_age` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '年龄',
  `employee_education` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学历',
  `employee_intime` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '入职时间',
  `employee_text` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_employee
-- ----------------------------
INSERT INTO `t_employee` VALUES (1, '张小理', '男', '13812345678', '管理部', '部长', '002', '23', '本科', '2021-08-31', '管理高手');
INSERT INTO `t_employee` VALUES (2, '李小设', '男', '13422222222', '设计部', '部长', '003', '25', '本科', '2021-08-31', '设计大师');
INSERT INTO `t_employee` VALUES (7, '彭大浩', '男', '17611111111', '设计部', '部员', '005', '25', '研究生', '2021-08-31', '新人报道12345');
INSERT INTO `t_employee` VALUES (38, '吕小冲', '男', '19022222222', '管理部', '部员', '040', '25', '研究生', '2021-08-31', 'qaq');
INSERT INTO `t_employee` VALUES (39, '小小龙', '女', '13181719800', NULL, NULL, NULL, NULL, NULL, NULL, '无');

-- ----------------------------
-- Table structure for t_leave
-- ----------------------------
DROP TABLE IF EXISTS `t_leave`;
CREATE TABLE `t_leave`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `leave_no` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `leave_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `leave_start` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开始',
  `leave_end` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束',
  `leave_days` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '天数',
  `leave_reason` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事由',
  `leave_text` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '请假' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_leave
-- ----------------------------
INSERT INTO `t_leave` VALUES (1, '005', '彭大浩', '2022-08-10', '2022-08-12', '2', '病假', '无');
INSERT INTO `t_leave` VALUES (2, '040', '吕小冲', '2022.8.11', '2022.8.13', '2', '当然是吃饭啦', '同意');

-- ----------------------------
-- Table structure for t_salary
-- ----------------------------
DROP TABLE IF EXISTS `t_salary`;
CREATE TABLE `t_salary`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `salary_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `salary_no` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `salary_dept` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门',
  `salary_money` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '薪资',
  `salary_fmoney` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扣除薪资',
  `salary_tmoney` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实际薪资',
  `salary_text` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工资' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_salary
-- ----------------------------
INSERT INTO `t_salary` VALUES (2, '彭大浩', '005', '设计部', '25000', '1212', '1210', '1');
INSERT INTO `t_salary` VALUES (3, '张小理', '002', '管理部', '20000', '44', '4', '管得好，挣得多');
INSERT INTO `t_salary` VALUES (4, '李小设', '003', '设计部', '25000', '44', '4', '技术过硬，思维灵敏');
INSERT INTO `t_salary` VALUES (34, '吕小冲', '040', '管理部', '3000', '4', '4', '干的不行');
INSERT INTO `t_salary` VALUES (35, '小小龙', NULL, NULL, NULL, '752', '55', NULL);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `real_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `user_sex` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别:男/女',
  `user_phone` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `user_text` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `user_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型:管理员/普通用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '123456', '老张', '女', '13588888888', '是一个好人', '管理员');
INSERT INTO `t_user` VALUES (2, 'zxl', '123456', '张小理', '男', '13812345678', '管理高手', '管理员');
INSERT INTO `t_user` VALUES (5, 'lxs', '654321', '李小设', '男', '13422222222', '设计大师', '管理员');
INSERT INTO `t_user` VALUES (30, 'pdh', '123456', '彭大浩', '男', '17611111111', '新人报道123466', '普通用户');
INSERT INTO `t_user` VALUES (63, '123', '123', '吕小冲', '男', '19022222222', 'qaq', '普通用户');
INSERT INTO `t_user` VALUES (64, '456', '456', '小小龙', '男', '13181719800', '无', '普通用户');

-- ----------------------------
-- Triggers structure for table t_dept
-- ----------------------------
DROP TRIGGER IF EXISTS `up`;
delimiter ;;
CREATE TRIGGER `up` AFTER UPDATE ON `t_dept` FOR EACH ROW BEGIN
UPDATE t_employee SET employee_dept = NEW.dept_name WHERE employee_dept = OLD.dept_name;
UPDATE t_salary SET salary_dept = NEW.dept_name WHERE salary_dept = OLD.dept_name;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_employee
-- ----------------------------
DROP TRIGGER IF EXISTS `updept`;
delimiter ;;
CREATE TRIGGER `updept` AFTER UPDATE ON `t_employee` FOR EACH ROW BEGIN
UPDATE t_salary SET salary_dept = new.employee_dept WHERE salary_name = OLD.employee_name;
UPDATE t_salary SET salary_no = new.employee_no WHERE salary_name = OLD.employee_name;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_salary
-- ----------------------------
DROP TRIGGER IF EXISTS `1`;
delimiter ;;
CREATE TRIGGER `1` AFTER UPDATE ON `t_salary` FOR EACH ROW BEGIN
UPDATE t_salary SET salary_tmoney = salary_money-salary_fmoney WHERE salary_fmoney=new.salary_fmoney;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_user
-- ----------------------------
DROP TRIGGER IF EXISTS `insalary`;
delimiter ;;
CREATE TRIGGER `insalary` AFTER INSERT ON `t_user` FOR EACH ROW BEGIN
		insert into t_salary(salary_name) values(new.username);
		insert into t_employee(employee_name) values(new.username);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_user
-- ----------------------------
DROP TRIGGER IF EXISTS `upphone`;
delimiter ;;
CREATE TRIGGER `upphone` AFTER UPDATE ON `t_user` FOR EACH ROW BEGIN
UPDATE t_employee SET employee_phone = NEW.user_phone WHERE employee_name = OLD.real_name;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_user
-- ----------------------------
DROP TRIGGER IF EXISTS `upinsa`;
delimiter ;;
CREATE TRIGGER `upinsa` AFTER UPDATE ON `t_user` FOR EACH ROW BEGIN
	UPDATE t_employee SET employee_sex = NEW.user_sex WHERE employee_name = new.username;
	UPDATE t_employee SET employee_phone = NEW.user_phone WHERE employee_name = new.username;
	UPDATE t_employee SET employee_text = NEW.user_text WHERE employee_name = new.username;
	UPDATE t_employee SET employee_name = NEW.real_name WHERE employee_name = new.username;
	UPDATE t_salary SET salary_name = NEW.real_name WHERE salary_name = new.username;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_user
-- ----------------------------
DROP TRIGGER IF EXISTS `uptext`;
delimiter ;;
CREATE TRIGGER `uptext` AFTER UPDATE ON `t_user` FOR EACH ROW BEGIN
UPDATE t_employee SET employee_text = NEW.user_text WHERE employee_text = OLD.user_text;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_user
-- ----------------------------
DROP TRIGGER IF EXISTS `dl1`;
delimiter ;;
CREATE TRIGGER `dl1` AFTER DELETE ON `t_user` FOR EACH ROW BEGIN
DELETE FROM t_employee WHERE employee_name = OLD.real_name;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_user
-- ----------------------------
DROP TRIGGER IF EXISTS `dl2`;
delimiter ;;
CREATE TRIGGER `dl2` AFTER DELETE ON `t_user` FOR EACH ROW BEGIN
DELETE FROM t_leave WHERE leave_name = OLD.real_name;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table t_user
-- ----------------------------
DROP TRIGGER IF EXISTS `dl3`;
delimiter ;;
CREATE TRIGGER `dl3` AFTER DELETE ON `t_user` FOR EACH ROW BEGIN
DELETE FROM t_salary WHERE salary_name = OLD.real_name;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
