package com.tphuong.demo.domain.event;

import com.google.common.base.Preconditions;
import lombok.Data;
import lombok.Setter;
import org.springframework.util.ObjectUtils;

import javax.annotation.Nullable;
import java.util.Date;

@Data
@Setter
public class Event {
    private int id;
    private String title;
    private String content;
    private String type;
    private Date createdDate;
    private Date celebratedDate;

    public Event(int id, String title, String content, String type, Date createdDate, @Nullable Date celebratedDate) {
        Preconditions.checkArgument(title.length() > 0, "Title can not empty!");
        Preconditions.checkArgument(content.length() > 0, "Title can not empty!");
        if (createdDate!= null) {
            Preconditions.checkArgument(celebratedDate.toInstant().isAfter(createdDate.toInstant()), "celebrated date need before create date");
        }
        this.id = id;
        this.title = title;
        this.content = content;
        this.type = type;
        this.createdDate = createdDate;
        this.celebratedDate = celebratedDate;
    }
}
