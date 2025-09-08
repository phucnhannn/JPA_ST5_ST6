package vn.iotstar.controller.manager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.Impl.CategoryServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/manager/home")
public class HomeServlet extends HttpServlet {
    private transient CategoryService service;

    @Override
    public void init() throws ServletException {
        service = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
        List<Category> items = (current != null) ? service.findByUserId(current.getUserId()) : List.of();
        req.setAttribute("currentUser", current);
        req.setAttribute("categories", items);
        req.getRequestDispatcher("/views/manager/categories.jsp").forward(req, resp);
    }
}