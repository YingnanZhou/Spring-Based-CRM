package com.zyn.crm.mapper;

import com.zyn.crm.domain.CustomerTransfer;
import com.zyn.crm.query.QueryObject;
import java.util.List;

public interface CustomerTransferMapper {
    int deleteByPrimaryKey(Long id);

    int insert(CustomerTransfer record);

    CustomerTransfer selectByPrimaryKey(Long id);

    List<CustomerTransfer> selectAll();

    int updateByPrimaryKey(CustomerTransfer record);

    List<CustomerTransfer> queryForList(QueryObject qo);
}