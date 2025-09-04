package vn.iotstar.configs;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public final class JPAConfig {
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("dataSource");

    private JPAConfig() {}

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public static void shutdown() {
        if (emf != null && emf.isOpen()) emf.close();
    }
}