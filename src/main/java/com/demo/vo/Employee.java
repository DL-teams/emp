package com.demo.vo;

import java.io.Serializable;

/**
 * 员工（t_employee表对应的Java实体类）
 */
public class Employee implements Serializable {
    private Long id;//主键
    private String employeeName;//姓名
    private String employeeSex;//性别:男/女
    private String employeePhone;//联系方式
    private String employeeDept;//所属部门
    private String employeeJob;//职位
    private String employeeNo;//工号
    private String employeeAge;//年龄
    private String employeeEducation;//学历
    private String employeeIntime;//入职时间
    private String employeeText;//备注

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }
    public String getEmployeeSex() {
        return employeeSex;
    }

    public void setEmployeeSex(String employeeSex) {
        this.employeeSex = employeeSex;
    }
    public String getEmployeePhone() {
        return employeePhone;
    }

    public void setEmployeePhone(String employeePhone) {
        this.employeePhone = employeePhone;
    }
    public String getEmployeeDept() {
        return employeeDept;
    }

    public void setEmployeeDept(String employeeDept) {
        this.employeeDept = employeeDept;
    }
    public String getEmployeeJob() {
        return employeeJob;
    }

    public void setEmployeeJob(String employeeJob) {
        this.employeeJob = employeeJob;
    }
    public String getEmployeeNo() {
        return employeeNo;
    }

    public void setEmployeeNo(String employeeNo) {
        this.employeeNo = employeeNo;
    }
    public String getEmployeeAge() {
        return employeeAge;
    }

    public void setEmployeeAge(String employeeAge) {
        this.employeeAge = employeeAge;
    }
    public String getEmployeeEducation() {
        return employeeEducation;
    }

    public void setEmployeeEducation(String employeeEducation) {
        this.employeeEducation = employeeEducation;
    }
    public String getEmployeeIntime() {
        return employeeIntime;
    }

    public void setEmployeeIntime(String employeeIntime) {
        this.employeeIntime = employeeIntime;
    }
    public String getEmployeeText() {
        return employeeText;
    }

    public void setEmployeeText(String employeeText) {
        this.employeeText = employeeText;
    }

    public Employee(String employeeName, String employeeSex, String employeePhone) {
        this.employeeName = employeeName;
        this.employeeSex = employeeSex;
        this.employeePhone = employeePhone;
    }

    public Employee(String employeeName, String employeeSex, String employeePhone, String employeeDept, String employeeJob, String employeeNo, String employeeAge, String employeeEducation, String employeeIntime, String employeeText) {
        this.employeeName = employeeName;
        this.employeeSex = employeeSex;
        this.employeePhone = employeePhone;
        this.employeeDept = employeeDept;
        this.employeeJob = employeeJob;
        this.employeeNo = employeeNo;
        this.employeeAge = employeeAge;
        this.employeeEducation = employeeEducation;
        this.employeeIntime = employeeIntime;
        this.employeeText = employeeText;
    }

    public Employee() {
    }
}
