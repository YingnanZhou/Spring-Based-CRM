package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Department;
import com.zyn.crm.mapper.DepartmentMapper;
import com.zyn.crm.query.DepartmentQueryObject;
import com.zyn.crm.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DepartmentServiceImpl implements IDepartmentService{
    @Autowired
    private DepartmentMapper departmentMapper;
    @Override
    public void saveOrUpdate(Department department) {
        if(department.getId() == null) departmentMapper.insert(department);
        else departmentMapper.updateByPrimaryKey(department);

    }

    @Override
    public void delete(Long id) {
        departmentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Department get(Long id) {
        return departmentMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(DepartmentQueryObject qo) {

        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Department> list = departmentMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public List<Department> list() {
        return departmentMapper.selectAll();
    }
}
