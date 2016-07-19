package com.kingit.service;

import com.kingit.exception.DataException;
import com.kingit.mapper.DocumentMapper;
import com.kingit.pojo.Document;
import com.kingit.utils.ShiroUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

/**
 * Created by Administrator on 2016/7/13.
 */
@Named
public class DocumentService {
    @Inject
    private DocumentMapper documentMapper;
    @Value("${imagePath}")
    private String savePath;

    public void delete(Integer id) {
        documentMapper.delDocument(id);
    }

    public void save(Document document) {
//        document.setCreatuser(ShiroUtil.getCurrentRealName());
        documentMapper.saveDocument(document);
    }

    public Document findById(Integer id) {
        return documentMapper.findById(id);
    }

    public List<Document> findList() {
        return documentMapper.findList();
    }

    public List<Document> findByFid(Integer fid) {
        return documentMapper.findByFid(fid);
    }

    /**
     * 上传文件并保存到指定目录,把把结果记录给数据库
     *
     * @param inputStream
     * @param originFileName
     * @param fid            父id
     * @param contentType
     * @param size
     */
    @Transactional
    public void saveFile(InputStream inputStream, String originFileName, Integer fid, String contentType, long size) {
        String extName = "";
        File file = new File("E:/image/pic");
        if (!file.exists() && !file.isDirectory()) {
            file.mkdir();
        }
        if (originFileName.contains(".")) ;
        {
            extName = originFileName.substring(originFileName.lastIndexOf("."));
        }

        String newFileName = UUID.randomUUID().toString() + extName;//获取本地文件名
        try {
            FileOutputStream outputStream = new FileOutputStream(new File(savePath, newFileName));
            IOUtils.copy(inputStream, outputStream);
            outputStream.flush();
            outputStream.close();
            inputStream.close();
        } catch (IOException e) {
            throw new DataException("保存文件失败");
        }

        Document document = new Document();
        document.setCreatuser(ShiroUtil.getCurrentRealName());
        document.setContenttype(contentType);
        document.setFid(fid);
        document.setSize(FileUtils.byteCountToDisplaySize(size));
        document.setName(originFileName);
        document.setFilename(newFileName);
        document.setType(Document.TYPE_DOC);

        documentMapper.saveDocument(document);

    }


    public void newDir(String dirname, Integer fid) {
        Document document = new Document();
        document.setType(Document.TYPE_DIR);
        document.setCreatuser(ShiroUtil.getCurrentRealName());
        document.setName(dirname);
        document.setFid(fid);
        documentMapper.saveDocument(document);
    }
}
