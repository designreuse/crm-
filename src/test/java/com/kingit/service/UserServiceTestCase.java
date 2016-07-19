package com.kingit.service;

import com.kingit.mapper.RoleMapper;
import com.kingit.pojo.Document;
import com.kingit.pojo.Notice;
import com.kingit.pojo.Role;
import com.kingit.pojo.User;
import com.kingit.utils.Md5Util;
import com.kingit.utils.ShiroUtil;
import com.kingit.utils.SqlUtil;
import org.joda.time.DateTime;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.inject.Inject;
import java.util.List;

/**
 * Created by Administrator on 2016/7/8.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class UserServiceTestCase {
    @Inject
    private UserService userService;
    @Inject
    private RoleMapper roleMapper;
    @Inject
    private NoticeService noticeService;
    @Inject
    private DocumentService documentService;
    @Inject
    private CustomerService customerService;

    @Test
    public void testFindByUserName() {
        User user = userService.findByUserName("king");
        Assert.assertNotNull(user);
        System.out.println(user);
    }

    @Test
    public void testMd5Util() {
        String pwd = Md5Util.Md5("123");
        System.out.println(pwd + "=====");
    }

    @Test
    public void testRoleMapper() {
        List<Role> roleList = roleMapper.findAll();
        Assert.assertEquals(2, roleList.size());
        System.out.println("====================");
        System.out.println(roleList);
    }

    @Test
    public void testDatetimeNow() {
        String now = DateTime.now().toString("yyyy-MM-dd HH:mm" + "==========");
        System.out.println(now);
    }

    @Test
    public void testDelUser() {
        userService.delUser(11);
    }

    @Test
    public void testSaveNotice() {
        noticeService.saveNotice(new Notice("钢铁是怎么炼成的", "差哈弗司机", "梁文超", 9));
    }

    @Test
    public void testFindById() {
        Notice notice = noticeService.findById(1);
        Assert.assertNotNull(notice);
        System.out.println(notice);
    }

    //documentService
    @Test
    public void testSave() {
        documentService.save(new Document("钢铁侠", "1.3M", 3, "王全伟", "nihao", "jjjj", "kkk", "lllm"));
    }

    @Test
    public void testFindList() {
        System.out.println(documentService.findList());
    }

    @Test
    public void testFindOne() {
        System.out.println(documentService.findById(1));
    }

    @Test
    public void delOne() {
        System.out.println(userService.findByUserid(22));
    }

    @Test
    public void testIsManger() {
        System.out.println(ShiroUtil.getCurrentRealName());
    }

    @Test
    public void findCompanyList() {
        System.out.println("==============");
        System.out.println(customerService.findCompanyList());
        System.out.println("==============");
    }

    @Test
    public void getCompanyNameById() {
        System.out.println(userService.findAll());

    }

    @Test
    public void testSaveSql() {
        String a = SqlUtil.save("id", "name", "password", "email");
        System.out.println(a);
        System.out.println("================");
    }

    @Test
    public void testUpdateSql() {
        String a = SqlUtil.update("source","name", "password", "email", "address","filename");
        System.out.println(a);
        System.out.println("================");
    }

    @Test
    public void testSetUpdateSql() {
        String a = SqlUtil.setUpdate("name", "price", "custname", "progress","lasttime", "username", "successtime", "userid", "custid");
        System.out.println(a);
        System.out.println("==============");
    }
}
