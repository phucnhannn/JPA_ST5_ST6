package vn.iotstar.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.Impl.CategoryServiceImpl;
import vn.iotstar.utils.UploadUtils;

import java.io.IOException;

@WebServlet(urlPatterns = "/admin/category/create")
@MultipartConfig
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
        Part iconPart = null;
        try { iconPart = req.getPart("iconFile"); } catch (Exception ignored) {}
        String uploadedPath = null;
        if (iconPart != null && iconPart.getSize() > 0) {
            uploadedPath = UploadUtils.saveToUploads(req, iconPart);
        }
        String finalIcon = (uploadedPath != null) ? uploadedPath : icon;

        HttpSession session = req.getSession(false);
        User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (current != null) {
            service.createForUser(current, name, finalIcon);
        } else {
            service.create(name, finalIcon);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }
}