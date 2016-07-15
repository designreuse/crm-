package com.kingit.mapper;

import com.kingit.pojo.Notice;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/11.
 */
public interface NoticeMapper {
    void saveNotice(Notice notice);

    Notice findById(Integer id);

    Long getTotalCount();

    List<Notice> findByParam(Map<String, Object> param);
}
