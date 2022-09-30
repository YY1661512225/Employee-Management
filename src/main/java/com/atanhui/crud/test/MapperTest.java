package com.atanhui.crud.test;

import com.atanhui.crud.bean.Department;
import com.atanhui.crud.bean.Employee;
import com.atanhui.crud.bean.EmployeeExample;
import com.atanhui.crud.dao.DepartmentMapper;
import com.atanhui.crud.dao.EmployeeMapper;
import com.atanhui.crud.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/**
 * 测试DAO层的工作
 * 推荐 Spring项目可以使用 Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入SpringTest
 * 2.@ContextConfiguration 指定Spring配置文件的位置
 * 3.直接 autowired 自动装配
 */

// 运行单元测试的工具 SpringJUnit4ClassRunner
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Autowired
    EmployeeService employeeService;

    // 测试departmentMapper
    @Test
    public void testCRUD(){
        // 1.根创建 Spring IOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        // 2.从容器中获取mapper
//        DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
//        System.out.println(departmentMapper);

        // 1.插入部门
//        Department department = new Department(null, "开发部");
//        departmentMapper.insertSelective(department);
//        departmentMapper.insertSelective(new Department(null, "测试部"));

        // 2.生成员工数据，测试员工
//        employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@qq.com", 1));
//        employeeMapper.insertSelective(new Employee(null, "Tom", "F", "Tom@qq.com", 1));
        // 3.批量插入员工数据 批量 sqlSession
//        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++) {
//            // UUID 生成随机码的工具 截取UUID
//            String uuid = UUID.randomUUID().toString().substring(0,5) + i;
//            employeeMapper.insertSelective(new Employee(null, uuid, "M", uuid+"@atanhui.com", 2));
//        }

        // 4.测试登录功能
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo("Tom").andPasswordEqualTo("Tom");

        boolean b = employeeService.checkUserToLogin("Tom", "Tom");
        System.out.println(b);
    }
}
