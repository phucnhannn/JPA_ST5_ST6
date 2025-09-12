package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.Impl.CategoryServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/home")
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
        if (current == null || current.getRoleId() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        List<Category> items;
        int role = current.getRoleId();
        if (role == 2) { 
            items = service.findByUserId(current.getUserId());
        } else { 
            items = service.findAll();
        }
        req.setAttribute("currentUser", current);
        req.setAttribute("categories", items);

        String view;
        if (role == 2) {
            view = "/views/manager/categories.jsp";
        } else if (role == 3) {
            view = "/views/admin/categories.jsp";
        } else {
            view = "/views/user/categories.jsp";
        }
        req.getRequestDispatcher(view).forward(req, resp);
    }
}