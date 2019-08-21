package com.zyn.crm.query;

import lombok.Getter;
import lombok.Setter;

@Setter@Getter
public class CustomerQueryObject extends QueryObject{
    private Long sellerId;
    private String keyword;
    private Integer status;
}
