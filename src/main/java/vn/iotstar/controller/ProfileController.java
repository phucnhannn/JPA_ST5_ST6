package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.Impl.UserServiceImpl;
import vn.iotstar.utils.UploadUtils;

import java.io.IOException;
import java.util.Optional;

@WebServlet(urlPatterns = {"/user/profile", "/admin/profile", "/manager/profile"})
@MultipartConfig
public class ProfileController extends HttpServlet {
    private transient UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    private void applyNoCache(HttpServletResponse resp) {
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (current == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Optional<User> dbUser = userService.findById(current.getUserId());
        dbUser.ifPresent(u -> {
            req.setAttribute("user", u);
            session.setAttribute("currentUser", u);
        });
        if (session != null) {
            Object alert = session.getAttribute("alert");
            if (alert != null) {
                req.setAttribute("alert", alert);
                session.removeAttribute("alert");
            }
        }
        String v = req.getParameter("v");
        long cacheBust = (v != null && !v.isBlank()) ? System.currentTimeMillis() : System.currentTimeMillis();
        req.setAttribute("cacheBust", cacheBust);
        applyNoCache(resp);
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        User current = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (current == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String imageUrl = req.getParameter("image");
        Part imagePart = null;
        try { imagePart = req.getPart("imageFile"); } catch (Exception ignored) {}
        System.out.println("[ProfileController] fullName=" + fullName + ", phone=" + phone + ", imageUrl=" + imageUrl + ", imageFile.size=" + (imagePart != null ? imagePart.getSize() : 0));
        String uploadedPath = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            uploadedPath = UploadUtils.saveToUploads(req, imagePart);
        }
        Optional<User> dbUserOpt = userService.findById(current.getUserId());
        if (dbUserOpt.isPresent()) {
            User dbUser = dbUserOpt.get();
            dbUser.setFullName(fullName);
            dbUser.setPhone(phone);
            if (uploadedPath != null) {
                dbUser.setImage(uploadedPath);
            } else if (imageUrl != null && !imageUrl.isBlank()) {
                dbUser.setImage(imageUrl);
            }
            try {
                User updated = userService.update(dbUser);
                session.setAttribute("currentUser", updated);
                session.setAttribute("alert", "Cập nhật hồ sơ thành công");
            } catch (Exception e) {
                session.setAttribute("alert", "Lỗi khi cập nhật hồ sơ: " + e.getMessage());
            }
        } else {
            session.setAttribute("alert", "Không tìm thấy người dùng");
        }
        String back = req.getContextPath() + req.getServletPath() + "?v=" + System.currentTimeMillis();
        resp.sendRedirect(back);
    }
}
