package com.zyn.crm.mapper;

import com.zyn.crm.domain.CustomerTraceHistory;
import com.zyn.crm.query.QueryObject;
import java.util.List;

public interface CustomerTraceHistoryMapper {
    int deleteByPrimaryKey(Long id);

    int insert(CustomerTraceHistory record);

    CustomerTraceHistory selectByPrimaryKey(Long id);

    List<CustomerTraceHistory> selectAll();

    int updateByPrimaryKey(CustomerTraceHistory record);

    List<CustomerTraceHistory> queryForList(QueryObject qo);
}