package vn.iotstar.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;
import java.util.UUID;

public final class UploadUtils {

    private UploadUtils() {}

    public static String saveToUploads(HttpServletRequest req, Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) return null;

        String submitted = getSubmittedFileName(filePart);
        String ext = getExt(submitted);
        String contentType = safeLower(filePart.getContentType());

        // Ensure only images are accepted
        if (contentType == null || !contentType.startsWith("image/")) {
            if (!isAllowedExt(ext)) {
                throw new IOException("Only image uploads are allowed");
            }
        }

        // Derive extension from content type if missing or not allowed
        if (ext.isBlank() || !isAllowedExt(ext)) {
            ext = deriveExtFromContentType(contentType);
        }
        if (ext.isBlank()) {
            // Final fallback
            ext = ".png";
        }

        String base = sanitizeFileName(removeExt(submitted != null ? submitted : "image"));
        if (base.isBlank()) base = "img";
        String safeName = base + "_" + UUID.randomUUID() + ext.toLowerCase(Locale.ROOT);

        String realUploadDir = req.getServletContext().getRealPath("/uploads");
        if (realUploadDir == null) throw new IOException("Cannot resolve real path for /uploads");
        File realDir = new File(realUploadDir);
        if (!realDir.exists() && !realDir.mkdirs()) {
            throw new IOException("Cannot create uploads directory: " + realUploadDir);
        }
        Path dest = Paths.get(realDir.getAbsolutePath(), safeName);

        // Write bytes to destination reliably
        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, dest);
        }

        tryCopyToSourceUploads(realDir, safeName, dest);

        return "/uploads/" + safeName;
    }

    private static void tryCopyToSourceUploads(File realDir, String safeName, Path sourceFile) {
        // First, try Maven project layout: .../target/... -> copy to {projectRoot}/src/main/webapp/uploads
        try {
            Path realPath = realDir.toPath();
            String p = realPath.toString();
            int idx = p.replace('\\', '/').toLowerCase(Locale.ROOT).indexOf("/target/");
            if (idx != -1) {
                String projectRoot = p.substring(0, idx);
                Path sourceUploads = Paths.get(projectRoot, "src", "main", "webapp", "uploads");
                Files.createDirectories(sourceUploads);
                Path dest = sourceUploads.resolve(safeName);
                if (!Files.exists(dest)) {
                    try (FileInputStream in = new FileInputStream(sourceFile.toFile());
                         FileOutputStream out = new FileOutputStream(dest.toFile())) {
                        in.transferTo(out);
                    }
                }
                return; // done
            }
        } catch (Exception ignored) {
        }

        // Fallback: configurable or known dev path (use system property, env var, then a sensible default)
        try {
            String override = System.getProperty("project.src.webapp");
            if (override == null || override.isBlank()) {
                override = System.getenv("PROJECT_SRC_WEBAPP");
            }
            Path srcWebapp = (override != null && !override.isBlank())
                    ? Paths.get(override)
                    : Paths.get("D:", "LT Web", "StudyWeb", "workspace", "JPAST56", "src", "main", "webapp");
            Path sourceUploads = srcWebapp.resolve("uploads");
            Files.createDirectories(sourceUploads);
            Path dest = sourceUploads.resolve(safeName);
            if (!Files.exists(dest)) {
                try (FileInputStream in = new FileInputStream(sourceFile.toFile());
                     FileOutputStream out = new FileOutputStream(dest.toFile())) {
                    in.transferTo(out);
                }
            }
        } catch (Exception ignored) {
        }
    }

    private static boolean isAllowedExt(String ext) {
        String e = ext == null ? "" : ext.toLowerCase(Locale.ROOT);
        return e.equals(".png") || e.equals(".jpg") || e.equals(".jpeg") || e.equals(".gif") || e.equals(".webp") || e.equals(".svg");
    }

    private static String getSubmittedFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String seg : cd.split(";")) {
            String s = seg.trim();
            if (s.startsWith("filename")) {
                String name = s.substring(s.indexOf('=') + 1).trim().replace("\"", "");
                return Paths.get(name).getFileName().toString();
            }
        }
        return null;
    }

    private static String sanitizeFileName(String name) {
        return name == null ? "" : name.replaceAll("[^a-zA-Z0-9-_]", "_");
    }

    private static String getExt(String name) {
        if (name == null) return "";
        int i = name.lastIndexOf('.');
        return (i >= 0) ? name.substring(i) : "";
    }

    private static String removeExt(String name) {
        if (name == null) return "";
        int i = name.lastIndexOf('.');
        return (i >= 0) ? name.substring(0, i) : name;
    }

    private static String safeLower(String s) {
        return s == null ? null : s.toLowerCase(Locale.ROOT);
    }

    private static String deriveExtFromContentType(String ct) {
        if (ct == null) return "";
        switch (ct.toLowerCase(Locale.ROOT)) {
            case "image/png": return ".png";
            case "image/jpeg": return ".jpg";
            case "image/jpg": return ".jpg";
            case "image/gif": return ".gif";
            case "image/webp": return ".webp";
            case "image/svg+xml": return ".svg";
            default:
                if (ct.startsWith("image/")) {
                    return "." + ct.substring("image/".length());
                }
                return "";
        }
    }
}