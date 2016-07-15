package com.kingit.dto;

import java.util.List;

/**
 * Created by Administrator on 2016/7/10.
 */
public class DatatableResult<T> {
    private String draw;
    private Long recordsFiltered;
    private Long recordsTotal;
    private List<T> data;

    public DatatableResult(String draw, Long recordsFiltered, Long recordsTotal, List<T> data) {
        this.draw = draw;
        this.recordsFiltered = recordsFiltered;
        this.recordsTotal = recordsTotal;
        this.data = data;
    }

    public String getDraw() {
        return draw;
    }

    public void setDraw(String draw) {
        this.draw = draw;
    }

    public Long getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(Long recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

    public Long getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(Long recordsTotal) {
        this.recordsTotal = recordsTotal;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }
}
