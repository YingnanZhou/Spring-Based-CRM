package com.zyn.crm.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Permission {
    private Long id;

    private String name;

    private String expression;


}