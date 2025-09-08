package vn.iotstar.service;

import vn.iotstar.entity.User;

import java.util.Optional;

public interface UserService {
    Optional<User> login(String username, String password);
    Optional<User> findByUsername(String username);
    User create(User user);
}
