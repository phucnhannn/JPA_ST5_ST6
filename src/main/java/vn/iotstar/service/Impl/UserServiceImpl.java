package vn.iotstar.service.Impl;

import vn.iotstar.dao.Impl.UserDaoImpl;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

import java.util.Optional;

public class UserServiceImpl implements UserService {

    private final UserDao dao = new UserDaoImpl();

    @Override
    public Optional<User> login(String username, String password) {
        return dao.login(username, password);
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return dao.findByUsername(username);
    }

    @Override
    public Optional<User> findById(Integer id) {
        return dao.findById(id);
    }

    @Override
    public User create(User user) {
        return dao.create(user);
    }

    @Override
    public User update(User user) {
        return dao.update(user);
    }
}