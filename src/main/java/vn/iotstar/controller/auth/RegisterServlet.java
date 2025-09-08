package vn.iotstar.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.Impl.UserServiceImpl;

import java.io.IOException;

@WebServlet(urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {

    private transient UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String fullName = req.getParameter("fullName");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirm");

        // Basic validations
        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            req.setAttribute("alert", "Username và mật khẩu là bắt buộc");
            req.setAttribute("username", username);
            req.setAttribute("fullName", fullName);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (!password.equals(confirm)) {
            req.setAttribute("alert", "Mật khẩu xác nhận không khớp");
            req.setAttribute("username", username);
            req.setAttribute("fullName", fullName);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (userService.findByUsername(username).isPresent()) {
            req.setAttribute("alert", "Tên đăng nhập đã tồn tại");
            req.setAttribute("username", username);
            req.setAttribute("fullName", fullName);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        User u = new User();
        u.setUsername(username);
        u.setPassword(password);
        u.setFullName(fullName);
        u.setRoleId(1);
        userService.create(u);

        req.setAttribute("success", "Đăng ký thành công. Hãy đăng nhập.");
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }
}
