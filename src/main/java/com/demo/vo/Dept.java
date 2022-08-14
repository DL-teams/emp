package com.demo.vo;

import java.io.Serializable;

/**
 * 部门（t_dept表对应的Java实体类）
 */
public class Dept implements Serializable {
    private Long id;//主键
    private String deptName;//名称
    private String deptLoc;//地点
    private String deptCount;//员工数量
    private String deptLeader;//部门领导
    private String deptText;//详细信息

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    public String getDeptLoc() {
        return deptLoc;
    }

    public void setDeptLoc(String deptLoc) {
        this.deptLoc = deptLoc;
    }
    public String getDeptCount() {
        return deptCount;
    }

    public void setDeptCount(String deptCount) {
        this.deptCount = deptCount;
    }
    public String getDeptLeader() {
        return deptLeader;
    }

    public void setDeptLeader(String deptLeader) {
        this.deptLeader = deptLeader;
    }
    public String getDeptText() {
        return deptText;
    }

    public void setDeptText(String deptText) {
        this.deptText = deptText;
    }
}
