package com.demo.vo;

import java.io.Serializable;

public class Announcement implements Serializable {

    //主键
    private Long id;

    // 标题
    private String title;

    // 内容
    private String value;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
