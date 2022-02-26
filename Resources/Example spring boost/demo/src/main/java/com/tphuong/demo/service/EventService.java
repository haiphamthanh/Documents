package com.tphuong.demo.service;
import com.tphuong.demo.domain.event.*;
import com.tphuong.demo.exception.DataNotFoundException;
import com.tphuong.demo.exception.EventAddException;
import com.tphuong.demo.exception.EventEditException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;

@Service
public class EventService {
    private EventRepository repository;

    @Autowired
    public EventService(final EventRepository repository) {
        this.repository = repository;
    }
    public List<Event> findAll() throws Exception {

        List<Event> events = repository.findAll();
        if(CollectionUtils.isEmpty(events)) {
            throw new DataNotFoundException("Product list is empty");
        }
        return events;
    }

    public Event findEvent(int id) throws Exception {

        Event event = repository.findById(id);
        if(event == null) {
            throw new DataNotFoundException("Can't find out event!");
        }
        return event;
    }

    public Event addEvent(final CreateEventRequest eventRequest) throws Exception {

        Event result = repository.postEvent(eventRequest);
        if(result == null) {
            throw new DataNotFoundException("Can't add event!");
        }
        return result;
    }

    public Event editEvent(int id, final EditEventRequest eventRequest) throws Exception {

        Event result = repository.putEvent(id, eventRequest);
        if(result == null) {
            throw new EventEditException("Can't find out event!");
        }
        return result;
    }

    public List<Event> searchEvent(SearchEventRequest request) throws Exception {

        List<Event> events = repository.search(request);
        if(CollectionUtils.isEmpty(events)) {
            throw new DataNotFoundException("Product list is empty");
        }
        return events;
    }

}
