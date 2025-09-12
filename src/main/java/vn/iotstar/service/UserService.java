package vn.iotstar.service;

import vn.iotstar.entity.User;

import java.util.Optional;

public interface UserService {
    Optional<User> login(String username, String password);
    Optional<User> findByUsername(String username);
    Optional<User> findById(Integer id);
    User create(User user);
    User update(User user);
}