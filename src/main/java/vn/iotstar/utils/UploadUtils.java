package vn.iotstar.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
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
        if (submitted == null || submitted.isBlank()) return null;
        String ext = getExt(submitted);
        if (!isAllowedExt(ext)) {
            throw new IOException("File type not allowed: " + ext);
        }
        String safeName = sanitizeFileName(removeExt(submitted)) + "_" + UUID.randomUUID() + ext;

        String realUploadDir = req.getServletContext().getRealPath("/uploads");
        if (realUploadDir == null) throw new IOException("Cannot resolve real path for /uploads");
        File realDir = new File(realUploadDir);
        if (!realDir.exists() && !realDir.mkdirs()) {
            throw new IOException("Cannot create uploads directory: " + realUploadDir);
        }
        Path dest = Paths.get(realDir.getAbsolutePath(), safeName);
        filePart.write(dest.toString());

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
        String e = ext.toLowerCase(Locale.ROOT);
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
        return name.replaceAll("[^a-zA-Z0-9-_]", "_");
    }

    private static String getExt(String name) {
        int i = name.lastIndexOf('.');
        return (i >= 0) ? name.substring(i) : "";
    }

    private static String removeExt(String name) {
        int i = name.lastIndexOf('.');
        return (i >= 0) ? name.substring(0, i) : name;
    }
}