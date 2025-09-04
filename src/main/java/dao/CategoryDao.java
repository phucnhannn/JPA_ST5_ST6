package dao;

import entity.Category;

public interface CategoryDao {
	Category create(Category category);
	Category update(Category category);
}
