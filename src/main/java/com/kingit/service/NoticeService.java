package com.kingit.service;

import com.kingit.exception.DataException;
import com.kingit.mapper.NoticeMapper;
import com.kingit.pojo.Notice;
import com.kingit.utils.ShiroUtil;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.*;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by Administrator on 2016/7/11.
 */
@Named
public class NoticeService {
    @Inject
    private NoticeMapper noticeMapper;
    //把默认文件存储路径写到配置文件并读取
    @Value("${imagePath}")
    private String imageSavePath;

    public void saveNotice(Notice notice) {
        notice.setUserid(ShiroUtil.getCurrentUserId());
        notice.setRealname(ShiroUtil.getCurrentRealName());
        noticeMapper.saveNotice(notice);
    }

    public Notice findById(Integer id) {
        return noticeMapper.findById(id);
    }

    public Long getTotalCount() {
        return noticeMapper.getTotalCount();
    }

    public List<Notice> findByParam(Map<String, Object> param) {
        return noticeMapper.findByParam(param);
    }

    public String saveImage(InputStream inputStream, String fileName) throws IOException {
        String extName = fileName.substring(fileName.lastIndexOf("."));//拓展名.xml之类
        String newFileName = UUID.randomUUID().toString() + extName;//生成唯一标识符
        FileOutputStream outputStream = null;

        outputStream = new FileOutputStream(new File(imageSavePath, newFileName));
        try {
            IOUtils.copy(inputStream, outputStream);
        } catch (IOException e) {
            throw new DataException("写入文件失败", e);
        }

        outputStream.flush();
        outputStream.close();
        inputStream.close();

        return "/preview/" + newFileName;
    }

    private void closeStream(InputStream inputStream, OutputStream outputStream) {
        try {
            if (inputStream != null) {
                inputStream.close();
            }
        } catch (IOException e) {
            throw new DataException("关闭输入流失败");
        } finally {
            try {
                if (outputStream != null) {
                    outputStream.flush();
                }
            } catch (IOException e) {
                throw new DataException("刷新输出流失败");

            } finally {
                if (outputStream != null) {
                    try {
                        outputStream.close();
                    } catch (IOException e) {
                        throw new DataException("关闭输出流失败");
                    }
                }
            }
        }
    }
}
