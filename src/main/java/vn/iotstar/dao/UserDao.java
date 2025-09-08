package vn.iotstar.dao;

import vn.iotstar.entity.User;

import java.util.Optional;

public interface UserDao {
    Optional<User> findById(Integer id);
    Optional<User> findByUsername(String username);
    Optional<User> login(String username, String password);
    User create(User user);
}
