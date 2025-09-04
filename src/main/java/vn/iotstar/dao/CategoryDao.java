package vn.iotstar.dao;

import vn.iotstar.entity.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryDao {
    Category create(Category entity);
    Category update(Category entity);
    boolean remove(Integer id);
    Optional<Category> findById(Integer id);
    List<Category> findAll();
    List<Category> searchByName(String keyword);
}