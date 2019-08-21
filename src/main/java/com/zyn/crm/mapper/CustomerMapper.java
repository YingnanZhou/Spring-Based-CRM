package com.zyn.crm.mapper;

import com.zyn.crm.domain.Customer;
import com.zyn.crm.query.QueryObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CustomerMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Customer record);

    Customer selectByPrimaryKey(Long id);


    int updateByPrimaryKey(Customer record);

    List<Customer> queryForList(QueryObject qo);

    void updateStatus(@Param("cid") Long cid, @Param("status") Integer status);

    void updateSellerId(@Param("customerId") Long customerId, @Param("curEmpId") Long curEmpId);

    void updateNewSeller(Customer customer);
}