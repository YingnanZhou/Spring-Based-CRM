package com.zyn.crm.domain;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Role {
    private Long id;

    private String name;

    private String sn;

    private List<Permission> permissions = new ArrayList<>();

}