package com.atanhui.crud.controller;

import com.atanhui.crud.service.EmployeeService;
import com.atanhui.crud.bean.Employee;
import com.atanhui.crud.bean.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    // 检查用户名是否可用
    @RequestMapping(value = "/checkUser", method = RequestMethod.GET)
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        // 先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{3,5}$)";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名可以是3-5位中文或者6-16位英文和数字的组合！");
        }

        // 数据库用户名重复校验
        boolean isEmp = employeeService.checkUser(empName);
        if (isEmp){
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名存在！");
        }
    }

    // 检查用户名是否可用
    @RequestMapping(value = "/checkUserToLogin", method = RequestMethod.GET)
    @ResponseBody
    public Msg checkUserToLogin(@RequestParam("empName") String empName, @RequestParam("password") String password){
        // 先判断用户名是否是合法的表达式
//        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{3,5}$)";
//        if (!empName.matches(regx)) {
//            return Msg.fail().add("va_msg", "用户名可以是3-5位中文或者6-16位英文和数字的组合！");
//        }
        // 数据库用户名重复校验
        boolean isEmp = employeeService.checkUserToLogin(empName, password);
        if (isEmp){
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }

    /**
     * 查询员工数据 分页查询
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model){
        // 分页查询？？？
        // 引入PageHelper
        // 在查询之前只需要调用， (传入页面 页面大小)
        PageHelper.startPage(pn, 5);
        // startPage 后面的查询 分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageinfo包装查询的结果 连续显示的页数
        // 封装详细的分页信息
        PageInfo pageInfo = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }


    /**
     * 导入Jackson
     * @param pn
     * @return
     */
    @RequestMapping(value = "/emps", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        // 分页查询？？？
        // 引入PageHelper
        // 在查询之前只需要调用， 传入页面 页面大小
        PageHelper.startPage(pn, 5);
        // startPage 后面的查询 分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageinfo 包装查询的结果 连续显示的页数
        PageInfo pageInfo = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 保存员工
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator
     * @return
     */
    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        // 校验失败，返回失败，在模态框中显示校验失败的错误信息
        Map<String, Object> map = new HashMap<String, Object>();
        List<FieldError> fieldErrors = result.getFieldErrors();
        for (FieldError fieldError : fieldErrors) {
            System.out.println("错误的字段名："+fieldError.getField());
            System.out.println("错误信息："+fieldError.getDefaultMessage());
            map.put(fieldError.getField(), fieldError.getDefaultMessage());
        }
        if (result.hasErrors()){
            System.out.println("失败");
            return Msg.fail().add("errorFields", map);
        }else {
            System.out.println("成功");
            int saveEmp = employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    // 更新员工信息
    // Ajax请求发送PUT请求引发的血案，
    // PUT请求请求体中的数据，request.getParameter()拿不到数据，
    // Tomcat，看到PUT请求，不会封装数据为map,只有POST请求，才会封装请求体
    // 如果直接发送ajax 请求==put，封装的数据除了路径，其他属性==null
    // 问题：请求体中有数据，但是employee对象封装不上
    // 原因：Tomcat问题，将请求体中的数据，封装一个map，request.getParameter() 就会从从这个map中取值
    // SpringMVC 封装POJO对象的时候，会把POJO中，每个属性的值，调用request.getParameter()
    // 我们需要支持直接发送PUT之类的请求，需要封装请求体中的数据
    // 解决方案：配置HttpPutFormContentFilter，将请求体中的数据解析包装成为一个map，
    // request.getParameter()方法被重写。从自己封装的map中取数据
    @RequestMapping(value = "/emps/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(@Valid Employee employee, BindingResult result){
        // 校验失败，返回失败，在模态框中显示校验失败的错误信息
        Map<String, Object> map = new HashMap<String, Object>();
        List<FieldError> fieldErrors = result.getFieldErrors();
        for (FieldError fieldError : fieldErrors) {
            System.out.println("错误的字段名："+fieldError.getField());
            System.out.println("错误信息："+fieldError.getDefaultMessage());
            map.put(fieldError.getField(), fieldError.getDefaultMessage());
        }
        if (result.hasErrors()){
            return Msg.fail().add("errorFields", map);
        }else {
            // 字段名 对应一致
            System.out.println("将要更新的数据："+employee);
            int saveEmp = employeeService.updateEmp(employee);
            return Msg.success();
        }
    }

    // 根据id 查询员工
    @RequestMapping(value = "/emps/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    // 单个 批量 二合一
    // 批量删除：1-2-3，单个删除：1
    @RequestMapping(value = "/emps/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            // 批量删除
            String[] str_ids = ids.split("-");
            // 组装id集合
            ArrayList<Integer> list = new ArrayList<>();
            for (String str_id : str_ids) {
                int id = Integer.parseInt(str_id);
                list.add(id);
            }
            int flag = employeeService.deleteBatchById(list);
        }else {
            // 单个删除
            int id = Integer.parseInt(ids);
            int deleteEmp  = employeeService.deleteEmpById(id);
        }
        return Msg.success();
    }
}
