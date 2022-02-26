package com.tphuong.demo.controller.event;

import com.tphuong.demo.domain.event.Event;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class EventResponseFactory {
    public EventSearchResponse createSearchResponse(List<Event> events) {

        List<EventSearchResponse.EventInfo> eventInfos = events.stream().map(this::createEventInfo).collect(Collectors.toList());
        return new EventSearchResponse(eventInfos);
    }

    private EventSearchResponse.EventInfo createEventInfo(Event event) {
        return new EventSearchResponse.EventInfo(
                event.getId(),
                event.getTitle(),
                event.getContent(),
                event.getType(),
                event.getCreatedDate(),
                event.getCelebratedDate()
        );
    }
}
