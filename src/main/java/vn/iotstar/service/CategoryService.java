package vn.iotstar.service;

import vn.iotstar.entity.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {
    List<Category> findAll();
    Optional<Category> findById(Integer id);
    Category create(String name, String icon);
    Category update(Integer id, String name, String icon);
    boolean delete(Integer id);
}