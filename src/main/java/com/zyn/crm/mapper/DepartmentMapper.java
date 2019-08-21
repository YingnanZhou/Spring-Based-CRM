package com.zyn.crm.mapper;

import com.zyn.crm.domain.Department;
import com.zyn.crm.query.DepartmentQueryObject;
import java.util.List;

public interface DepartmentMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Department record);

    Department selectByPrimaryKey(Long id);

    List<Department> selectAll();

    int updateByPrimaryKey(Department record);

    int queryForCount(DepartmentQueryObject qo);

    List<Department> queryForList(DepartmentQueryObject qo);
}