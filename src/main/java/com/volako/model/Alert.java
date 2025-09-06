package com.volako.model;

import jakarta.persistence.*;
import java.time.Instant;

@Entity
@Table(name = "alerts")
public class Alert {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false) @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne @JoinColumn(name = "budget_id")
    private Budget budget;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String message;

    private Boolean isRead = Boolean.FALSE;

    @Column(nullable = false, updatable = false)
    private Instant createdAt = Instant.now();

    // getters/setters
}