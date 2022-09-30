package com.atanhui.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回值
 * 返回json数据
 */
public class Msg {

    // 状态码 100-成功 200-失败
    private int code;
    // 提示信息 成功？ 失败？
    private String msg;

    // 用户返回给浏览器的数据 map
    private Map<String, Object> extend = new HashMap<String, Object>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理成功！");
        return msg;
    }

    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理失败！");
        return msg;
    }

    // 链式添加
    public Msg add(String key, Object value){
        this.getExtend().put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
