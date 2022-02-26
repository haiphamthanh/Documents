package com.tphuong.demo.repository;
import com.tphuong.demo.domain.event.*;
import com.tphuong.demo.exception.EventAddException;
import com.tphuong.demo.exception.EventEditException;
import com.tphuong.demo.exception.EventSearchException;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Repository
public class EventRepositoryImpl implements EventRepository {
    private static ArrayList<Event> events = new ArrayList<Event>();
    static {
        Date today = new Date();
        SimpleDateFormat formattedDate = new SimpleDateFormat("yyyyMMdd");
        Calendar c = Calendar.getInstance();
        c.add(Calendar.DATE, 1);
        Date tomorrow = c.getTime();

        events.add(new Event(1,"title1", "content1", "event", new Date(), tomorrow));
        events.add(new Event(2,"title2", "content2", "news", new Date(), tomorrow));
        events.add(new Event(3,"title3", "content3", "disaster", new Date(), tomorrow));
        events.add(new Event(4,"title4", "content4", "news", new Date(), tomorrow));

    }
    @Override
    public List<Event> findAll() throws EventSearchException {
        return events;
    }

    @Override
    public Event findById(int id) throws EventSearchException {
        for(Event event: events) {
            if (event.getId() == id) {
                return  event;
            }
        }
        return null;
    }

    @Override
    public Event postEvent(final CreateEventRequest eventRequest) throws EventAddException {
        if (eventRequest != null) {
            Event ev = eventRequest.toEvent(events.size() + 1);
            events.add(ev);
            return ev;
        }
        return null;
    }

    @Override
    public Event putEvent(int id, final EditEventRequest eventRequest) throws EventEditException {
        for(Event event: events) {
            if (event.getId() == id) {
                event.setTitle(eventRequest.getTitle());
                event.setContent(eventRequest.getContent());
                event.setType(eventRequest.getType());
                event.setCelebratedDate(eventRequest.getCelebratedDate());
                return  event;
            }
        }
        return null;
    }

    @Override
    public List<Event> search(SearchEventRequest request) throws EventSearchException {
        if (request.getKeyword() == null && request.getType() == null) {
            throw new EventSearchException("Keyword is not valid");
        }
        ArrayList<Event> results = (ArrayList<Event>) events.clone();

        if (request.getType() != null && request.getType().length() > 0) {
            results.removeIf(p -> !Objects.equals(p.getType(), request.getType()));
        }

        if (request.getKeyword() != null && request.getKeyword().length() > 0) {
            results.removeIf(p -> !p.getTitle().contains(request.getKeyword()));
        }
        return results;
    }
}
