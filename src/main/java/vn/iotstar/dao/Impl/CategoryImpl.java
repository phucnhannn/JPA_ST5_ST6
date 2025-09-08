package vn.iotstar.dao.Impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.configs.JPAConfig;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.entity.Category;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

public class CategoryImpl implements CategoryDao {

    @Override
    public Category create(Category entity) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(entity);
            tx.commit();
            return entity;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Category update(Category entity) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Category merged = em.merge(entity);
            tx.commit();
            return merged;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean remove(Integer id) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            Category found = em.find(Category.class, id);
            if (found == null) return false;
            tx.begin();
            em.remove(found);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Optional<Category> findById(Integer id) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return Optional.ofNullable(em.find(Category.class, id));
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> q = em.createQuery(
                "SELECT c FROM Category c LEFT JOIN FETCH c.owner ORDER BY c.cateid", Category.class);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> searchByName(String keyword) {
        if (keyword == null || keyword.isBlank()) return Collections.emptyList();
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> q = em.createQuery(
                "SELECT c FROM Category c WHERE LOWER(c.catename) LIKE :kw ORDER BY c.cateid", Category.class);
            q.setParameter("kw", "%" + keyword.toLowerCase() + "%");
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> findByUserId(Integer userId) {
        if (userId == null) return Collections.emptyList();
        EntityManager em = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> q = em.createQuery(
                "SELECT c FROM Category c LEFT JOIN FETCH c.owner WHERE c.owner.userId = :uid ORDER BY c.cateid", Category.class);
            q.setParameter("uid", userId);
            return q.getResultList();
        } finally {
            em.close();
        }
    }
}