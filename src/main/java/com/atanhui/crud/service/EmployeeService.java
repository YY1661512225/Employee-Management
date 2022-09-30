package com.atanhui.crud.service;

import com.atanhui.crud.bean.Employee;
import com.atanhui.crud.bean.EmployeeExample;
import com.atanhui.crud.dao.EmployeeMapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;



@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    // 检验用户名是否可用
    // count == 0 ？ true可用 ： false不可用
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    public boolean checkUserToLogin(String empName, String password) {
        EmployeeExample employeeExample1 = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample1.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        criteria.andPasswordEqualTo(password);
        List<Employee> employees = employeeMapper.selectByExample(employeeExample1);
        System.out.println(employees);
        if (employees.get(0)!=null){
            return true;
        } else {
            return false;
        }
    }

    // 按照员工id 查询员工
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
        return employee;
    }

    // 员工更新
    public int updateEmp(Employee employee) {
        EmployeeExample employeeExample = new EmployeeExample();
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    // 员工删除
    public int deleteEmpById(Integer id) {
        int delete = employeeMapper.deleteByPrimaryKey(id);
        return delete;
    }

    public int deleteBatchById(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        // delete from xxx where emp_id in (1,2,3);
        criteria.andEmpIdIn(ids);
        return employeeMapper.deleteByExample(example);
    }
}
