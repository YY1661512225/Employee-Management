package com.atanhui.crud.controller;

import com.atanhui.crud.service.DepartmentService;
import com.atanhui.crud.bean.Department;
import com.atanhui.crud.bean.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    /**
     * 返回部门信息
     */
    @RequestMapping("/dept")
    @ResponseBody
    public Msg getDeptWithJson(){
        // 查出部门信息
        List<Department> dept = departmentService.getDepts();
        return Msg.success().add("depts", dept);
    }
}
