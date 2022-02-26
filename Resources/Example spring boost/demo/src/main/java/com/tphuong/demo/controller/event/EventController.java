package com.tphuong.demo.controller.event;
import com.tphuong.demo.domain.event.CreateEventRequest;
import com.tphuong.demo.domain.event.EditEventRequest;
import com.tphuong.demo.domain.event.SearchEventRequest;
import com.tphuong.demo.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/events")
public class EventController {

    private EventResponseFactory eventResponseFactory;
    private EventService eventService;

    @Autowired
    public EventController(EventResponseFactory eventResponseFactory, EventService eventService) {
        this.eventResponseFactory = eventResponseFactory;
        this.eventService = eventService;
    }

    @GetMapping("/all")
    public ResponseEntity<?> getEvents() throws Exception {
        var events = eventService.findAll();
        return ResponseEntity.ok(eventResponseFactory.createSearchResponse(events));
    }

    @GetMapping("/search")
    public ResponseEntity<?> searchEvents(final SearchEventRequest request, final BindingResult bindingResult) throws Exception {
        if(bindingResult.hasErrors()) {
            throw new InvalidParameterException(getErrorMessage(bindingResult));
        }
        var events = eventService.searchEvent(request);
        return ResponseEntity.ok(eventResponseFactory.createSearchResponse(events));
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getEvent(@PathVariable int id) throws Exception {
        var event = eventService.findEvent(id);
        return ResponseEntity.ok(event);
    }

    @PostMapping
    public ResponseEntity<?> postEvent(final @RequestBody CreateEventRequest request, final BindingResult bindingResult) throws Exception {
        if(bindingResult.hasErrors()) {
            throw new InvalidParameterException(getErrorMessage(bindingResult));
        }
        var event = eventService.addEvent(request);

        return ResponseEntity.ok(event);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> editEvent(@PathVariable int id, final @RequestBody EditEventRequest request, final BindingResult bindingResult) throws Exception {
        if(bindingResult.hasErrors()) {
            throw new InvalidParameterException(getErrorMessage(bindingResult));
        }
        var event = eventService.editEvent(id, request);

        return ResponseEntity.ok(event);
    }

    private String getErrorMessage(final BindingResult bindingResult) {

        List<String> errMessages = new ArrayList<>();
        List<FieldError> fieldErrors = bindingResult.getFieldErrors();
        fieldErrors.forEach(error -> errMessages.add(error.getDefaultMessage()));
        return String.join("\r\n", errMessages);
    }
}
