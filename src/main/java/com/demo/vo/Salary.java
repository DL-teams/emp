package com.demo.vo;

import java.io.Serializable;

/**
 * 工资（t_salary表对应的Java实体类）
 */
public class Salary implements Serializable {
    private Long id;//主键
    private String salaryName;//姓名
    private String salaryNo;//工号
    private String salaryDept;//部门
    private String salaryMoney;//薪资
    private String salaryFmoney;//扣除工资
    private String salaryTmoney;//实际工资
    private String salaryText;//备注

    public String getSalaryFmoney() {
        return salaryFmoney;
    }

    public void setSalaryFmoney(String salaryFmoney) {
        this.salaryFmoney = salaryFmoney;
    }

    public String getSalaryTmoney() {
        return salaryTmoney;
    }

    public void setSalaryTmoney(String salaryTmoney) {
        this.salaryTmoney = salaryTmoney;
    }

    public Salary() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public String getSalaryName() {
        return salaryName;
    }

    public void setSalaryName(String salaryName) {
        this.salaryName = salaryName;
    }
    public String getSalaryNo() {
        return salaryNo;
    }

    public void setSalaryNo(String salaryNo) {
        this.salaryNo = salaryNo;
    }
    public String getSalaryDept() {
        return salaryDept;
    }

    public void setSalaryDept(String salaryDept) {
        this.salaryDept = salaryDept;
    }

    public String getSalaryMoney() {
        return salaryMoney;
    }

    public void setSalaryMoney(String salaryMoney) {
        this.salaryMoney = salaryMoney;
    }



    public String getSalaryText() {
        return salaryText;
    }

    public void setSalaryText(String salaryText) {
        this.salaryText = salaryText;
    }
}
