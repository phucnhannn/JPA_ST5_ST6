package vn.iotstar.service.Impl;

import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.Impl.CategoryImpl;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.service.CategoryService;

import java.util.List;
import java.util.Optional;

public class CategoryServiceImpl implements CategoryService {

    private final CategoryDao dao = new CategoryImpl();

    @Override
    public List<Category> findAll() {
        return dao.findAll();
    }

    @Override
    public List<Category> findByUserId(Integer userId) {
        return dao.findByUserId(userId);
    }

    @Override
    public Optional<Category> findById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public Category create(String name, String icon) {
        Category c = new Category(name, icon);
        return dao.create(c);
    }

    @Override
    public Category createForUser(User owner, String name, String icon) {
        Category c = new Category(name, icon);
        c.setOwner(owner);
        return dao.create(c);
    }

    @Override
    public Category update(Integer id, String name, String icon) {
        Category c = dao.findById(id).orElseThrow(() -> new IllegalArgumentException("Category not found: " + id));
        c.setCatename(name);
        c.setIcon(icon);
        return dao.update(c);
    }

    @Override
    public boolean delete(Integer id) {
        return dao.remove(id);
    }
}