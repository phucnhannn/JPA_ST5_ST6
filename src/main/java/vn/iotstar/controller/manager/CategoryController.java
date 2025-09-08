package vn.iotstar.controller.manager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.Impl.CategoryServiceImpl;
import vn.iotstar.utils.UploadUtils;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(urlPatterns = {
        "/manager/category",
        "/manager/category/edit",
        "/manager/category/update",
        "/manager/category/delete",
        "/manager/category/create"
})
@MultipartConfig
public class CategoryController extends HttpServlet {

    private transient CategoryService service;

    @Override
    public void init() throws ServletException {
        service = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/manager/category" -> showList(req, resp);
            case "/manager/category/edit" -> showEdit(req, resp);
            case "/manager/category/delete" -> delete(req, resp);
            default -> resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
        List<Category> items = (current != null) ? service.findByUserId(current.getUserId()) : List.of();
        req.setAttribute("currentUser", current);
        req.setAttribute("categories", items);
        req.getRequestDispatcher("/views/manager/categories.jsp").forward(req, resp);
    }

    private void showEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Integer id = Integer.valueOf(idStr);
                Optional<Category> c = service.findById(id);
                HttpSession session = req.getSession(false);
                User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
                if (c.isPresent() && current != null && c.get().getOwner() != null &&
                        current.getUserId().equals(c.get().getOwner().getUserId())) {
                    req.setAttribute("cate", c.get());
                }
            } catch (NumberFormatException ignored) { }
        }
        showList(req, resp);
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Integer id = Integer.valueOf(idStr);
                Optional<Category> c = service.findById(id);
                HttpSession session = req.getSession(false);
                User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
                if (c.isPresent() && current != null && c.get().getOwner() != null &&
                        current.getUserId().equals(c.get().getOwner().getUserId())) {
                    service.delete(id);
                }
            } catch (NumberFormatException ignored) { }
        }
        resp.sendRedirect(req.getContextPath() + "/manager/category");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/manager/category/update" -> update(req, resp);
            case "/manager/category/create" -> create(req, resp);
            default -> resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
        String name = req.getParameter("catename");
        String icon = req.getParameter("icon");
        Part iconPart = null;
        try { iconPart = req.getPart("iconFile"); } catch (Exception ignored) {}
        String uploadedPath = null;
        if (iconPart != null && iconPart.getSize() > 0) {
            uploadedPath = UploadUtils.saveToUploads(req, iconPart);
        }
        String finalIcon = (uploadedPath != null) ? uploadedPath : icon;
        if (current != null) {
            service.createForUser(current, name, finalIcon);
        }
        resp.sendRedirect(req.getContextPath() + "/manager/category");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        Integer id = Integer.valueOf(req.getParameter("id"));
        String name = req.getParameter("catename");
        String icon = req.getParameter("icon");
        Part iconPart = null;
        try { iconPart = req.getPart("iconFile"); } catch (Exception ignored) {}
        Optional<Category> c = service.findById(id);
        HttpSession session = req.getSession(false);
        User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (c.isPresent() && current != null && c.get().getOwner() != null &&
                current.getUserId().equals(c.get().getOwner().getUserId())) {
            String uploadedPath = null;
            if (iconPart != null && iconPart.getSize() > 0) {
                uploadedPath = UploadUtils.saveToUploads(req, iconPart);
            }
            String finalIcon = (uploadedPath != null) ? uploadedPath : (icon != null && !icon.isBlank() ? icon : c.get().getIcon());
            service.update(id, name, finalIcon);
        }
        resp.sendRedirect(req.getContextPath() + "/manager/category");
    }
}