package com.demo.vo;

import java.io.Serializable;

/**
 * 请假（t_leave表对应的Java实体类）
 */
public class Leave implements Serializable {
    private Long id;//主键
    private String leaveNo;//工号
    private String leaveName;//姓名
    private String leaveStart;//开始
    private String leaveEnd;//结束
    private String leaveDays;//天数
    private String leaveReason;//事由
    private String leaveText;//备注

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    public String getLeaveNo() {
        return leaveNo;
    }

    public void setLeaveNo(String leaveNo) {
        this.leaveNo = leaveNo;
    }
    public String getLeaveName() {
        return leaveName;
    }

    public void setLeaveName(String leaveName) {
        this.leaveName = leaveName;
    }
    public String getLeaveStart() {
        return leaveStart;
    }

    public void setLeaveStart(String leaveStart) {
        this.leaveStart = leaveStart;
    }
    public String getLeaveEnd() {
        return leaveEnd;
    }

    public void setLeaveEnd(String leaveEnd) {
        this.leaveEnd = leaveEnd;
    }
    public String getLeaveDays() {
        return leaveDays;
    }

    public void setLeaveDays(String leaveDays) {
        this.leaveDays = leaveDays;
    }
    public String getLeaveReason() {
        return leaveReason;
    }

    public void setLeaveReason(String leaveReason) {
        this.leaveReason = leaveReason;
    }
    public String getLeaveText() {
        return leaveText;
    }

    public void setLeaveText(String leaveText) {
        this.leaveText = leaveText;
    }
}
