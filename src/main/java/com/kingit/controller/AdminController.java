package com.kingit.controller;

import com.google.common.collect.Maps;
import com.kingit.dto.DatatableResult;
import com.kingit.mapper.RoleMapper;
import com.kingit.pojo.User;
import com.kingit.service.UserService;
import com.kingit.utils.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/11.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Inject
    private UserService userService;
    @Inject
    private RoleMapper roleMapper;

    /**
     * 指向展示用户页面
     *
     * @param model 向转发页面发送需要的对象
     * @return
     */
    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String userShow(Model model) {
        model.addAttribute("roles", roleMapper.findAll());
        Map<String, Object> param = Maps.newHashMap();
        return "user/show";
    }

    @RequestMapping(value = "/show.json", method = RequestMethod.GET)
    @ResponseBody
    public DatatableResult userLoad(HttpServletRequest request) {
        Map<String, Object> param = Maps.newHashMap();

        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");

        String sortColumnIndex = request.getParameter("order[0][column]");//获取排序列的索引
        String sortColumnName = request.getParameter("columns[" + sortColumnIndex + "][name]");//根据序列的索引获取列的名字
        String sortType = request.getParameter("order[0][dir]");//排序方式(asc,desc)

        System.out.println(sortColumnName + "===========" + sortType);

        String realname = request.getParameter("realname");
        realname = Strings.toUTF8(realname);
        String role = request.getParameter("role");

        param.put("start", start);
        param.put("length", length);
        param.put("sortColumnName", sortColumnName);
        param.put("sortType", sortType);
        param.put("realname", realname);
        param.put("roleid", role);

        System.out.println(param);

        Long recordsTotal = userService.getTotalCount();
        Long recordsFiltered = userService.getRecordsFiltered(param);
        List<User> userList = userService.findUserByParam(param);

        return new DatatableResult(draw, recordsFiltered, recordsTotal, userList);
    }

    /**
     * 新增用户
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/show", method = RequestMethod.POST)
    @ResponseBody
    public String userSave(User user) {
        userService.savaUser(user);
        return "success";
    }

    /**
     * 删除用户
     *
     * @param id 用户id
     * @return 结果
     */
    @RequestMapping(value = "/{id:\\d+}/del", method = RequestMethod.GET)
    @ResponseBody
    public String delUser(@PathVariable("id") Integer id) {
        userService.delUser(id);
        return "success";
    }

    @RequestMapping(value = "/{id:\\d+}.json", method = RequestMethod.GET)
    @ResponseBody
    public User findUserById(@PathVariable("id") Integer id) {
        return userService.findByUserid(id);
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public String editUser(User user) {
        userService.editUser(user);
        return "success";
    }

    /**
     * 重置密码
     *
     * @return 把重置结果返回给页面
     */
    @RequestMapping(value = "/{id:\\d+}/resetpsw", method = RequestMethod.GET)
    @ResponseBody
    public String resetPwd(@PathVariable("id") Integer id) {
        userService.resetPwd(id);
        return "success";
    }

    @RequestMapping(value = "/checkuser.json", method = RequestMethod.GET)
    @ResponseBody
    public String checkUserName(String username) {
        User user = userService.findByUserName(username);
        return user == null ? "true" : "false";
    }
}
