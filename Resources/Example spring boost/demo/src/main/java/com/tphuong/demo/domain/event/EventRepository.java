package com.tphuong.demo.domain.event;
import com.tphuong.demo.exception.EventAddException;
import com.tphuong.demo.exception.EventEditException;
import com.tphuong.demo.exception.EventSearchException;

import java.util.List;

public interface EventRepository {
    List<Event> findAll() throws EventSearchException;
    Event findById(int id) throws EventSearchException;
    Event postEvent(final CreateEventRequest eventRequest) throws EventAddException;
    Event putEvent(int id, final EditEventRequest eventRequest) throws EventEditException;
    List<Event> search(SearchEventRequest request) throws EventSearchException;
}
