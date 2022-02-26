package com.tphuong.demo.controller.event;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
public class EventSearchResponse {
    private List<EventInfo> results;
    @Data
    @AllArgsConstructor
    public static class EventInfo {
        private int id;
        private String title;
        private String content;
        private String type;
        private Date createdDate;
        private Date celebratedDate;
    }
}
