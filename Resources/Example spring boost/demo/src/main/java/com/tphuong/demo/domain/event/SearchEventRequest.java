package com.tphuong.demo.domain.event;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.annotation.Nullable;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchEventRequest {

    @Nullable
    @JsonProperty("keyword")
    private String keyword;

    @Nullable
    @JsonProperty("type")
    private String type;
}
