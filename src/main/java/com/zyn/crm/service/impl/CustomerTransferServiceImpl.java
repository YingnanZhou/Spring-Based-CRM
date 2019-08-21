package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Customer;
import com.zyn.crm.domain.CustomerTransfer;
import com.zyn.crm.domain.Employee;
import com.zyn.crm.mapper.CustomerMapper;
import com.zyn.crm.mapper.CustomerTransferMapper;
import com.zyn.crm.query.QueryObject;
import com.zyn.crm.service.ICustomerTransferService;
import com.zyn.crm.util.UserContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.List;

@Service
public class CustomerTransferServiceImpl implements ICustomerTransferService{
    @Autowired
    private CustomerTransferMapper customerTransferMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Override
    public void saveOrUpdate(CustomerTransfer customerTransfer) {


        Employee employee = UserContext.getCurEmp();



        if(customerTransfer.getNewSeller() == null) {
            customerTransfer.setNewSeller(employee);
        }


        customerTransfer.setOperator(employee);
        customerTransfer.setOperateTime(new Date());
        customerTransferMapper.insert(customerTransfer);


    }

    @Override
    public void delete(Long id) {
        customerTransferMapper.deleteByPrimaryKey(id);
    }

    @Override
    public CustomerTransfer get(Long id) {
        return customerTransferMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(QueryObject qo) {

        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<CustomerTransfer> list = customerTransferMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public List<CustomerTransfer> list() {
        return customerTransferMapper.selectAll();
    }
}
