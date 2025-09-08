package vn.iotstar.service;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;

import java.util.List;
import java.util.Optional;

public interface CategoryService {
    List<Category> findAll();
    List<Category> findByUserId(Integer userId);
    Optional<Category> findById(Integer id);
    Category create(String name, String icon);
    Category createForUser(User owner, String name, String icon);
    Category update(Integer id, String name, String icon);
    boolean delete(Integer id);
}