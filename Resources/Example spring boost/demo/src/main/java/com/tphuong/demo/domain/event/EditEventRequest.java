package com.tphuong.demo.domain.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Date;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class EditEventRequest {
    @NotNull(message = "title is required")
    @NotEmpty(message = "title is required")
    @JsonProperty("title")
    private String title;

    @NotNull(message = "content is required")
    @NotEmpty(message = "content is required")
    @JsonProperty("content")
    private String content;

    @NotNull(message = "type is required")
    @NotEmpty(message = "type is required")
    @Pattern(regexp="news", message = "type is not correct")
    @JsonProperty("type")
    private String type;

    @JsonProperty("celebrated_date")
    private Date celebratedDate;

    public Event toEvent(int id) {
        return new Event(
                id,
                title,
                content,
                type,
                new Date(),
                celebratedDate
        );
    }
}