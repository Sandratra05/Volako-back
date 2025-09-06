package com.volako.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "categories",
        uniqueConstraints = @UniqueConstraint(columnNames = {"user_id","name"}))
public class Category {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = true)
    @JoinColumn(name = "user_id")
    private User user;

    @Column(nullable = false, length = 50)
    private String name;

    private Boolean isDefault = Boolean.FALSE;

    @OneToMany(mappedBy = "category")
    private List<Transaction> transactions;

    // getters/setters
}
