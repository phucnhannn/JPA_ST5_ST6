package vn.iotstar.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.Impl.UserServiceImpl;

import java.io.IOException;
import java.util.Optional;

@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private transient UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user != null && user.getRoleId() != null) {
            String ctx = req.getContextPath();
            switch (user.getRoleId()) {
                case 1 -> resp.sendRedirect(ctx + "/user/category");
                case 2 -> resp.sendRedirect(ctx + "/manager/home");
                case 3 -> resp.sendRedirect(ctx + "/admin/home");
                default -> resp.sendRedirect(ctx + "/login");
            }
            return;
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Optional<User> opt = userService.login(username, password);
        if (opt.isPresent()) {
            User user = opt.get();
            HttpSession session = req.getSession(true);
            session.setAttribute("currentUser", user);
            String ctx = req.getContextPath();
            switch (user.getRoleId()) {
                case 1 -> resp.sendRedirect(ctx + "/user/category");
                case 2 -> resp.sendRedirect(ctx + "/manager/home");
                case 3 -> resp.sendRedirect(ctx + "/admin/home");
                default -> resp.sendRedirect(ctx + "/login");
            }
        } else {
            req.setAttribute("alert", "Sai tài khoản hoặc mật khẩu");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}