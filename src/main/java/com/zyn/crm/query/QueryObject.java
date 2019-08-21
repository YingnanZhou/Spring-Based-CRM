package com.zyn.crm.query;

import lombok.Getter;
import lombok.Setter;

@Getter@Setter
public class QueryObject {
    private int currentPage = 1;
    private int pageSize = 3;

    public int getBeginIndex() {
        return (currentPage - 1) * pageSize;
    }
}
