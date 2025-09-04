package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.Impl.CategoryServiceImpl;

import java.io.IOException;

@WebServlet(urlPatterns = "/admin/category/create")
public class AddCategoryController extends HttpServlet {

    private transient CategoryService service;

    @Override
    public void init() {
        service = new CategoryServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("catename");
        String icon = req.getParameter("icon");
        service.create(name, icon);
        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }
}