package com.kingit.mapper;

import com.kingit.pojo.Document;

import java.util.List;

/**
 * Created by Administrator on 2016/7/13.
 */
public interface DocumentMapper {
    void saveDocument(Document document);
    void delDocument(Integer id);

    Document findById(Integer id);

    List<Document> findList();

    List<Document> findByFid(Integer fid);
}
