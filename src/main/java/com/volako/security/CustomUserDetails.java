package com.volako.security;

import java.util.Collection;
import java.util.Collections;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import com.volako.model.User;

public class CustomUserDetails implements UserDetails {
    private final String email;
    private final String passwordHash;

    public CustomUserDetails(User user) {
        this.email = user.getEmail();
        this.passwordHash = user.getPasswordHash(); // adapte si le getter diffère
    }

    @Override public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.emptyList();
    }
    @Override public String getPassword() { return passwordHash; }
    @Override public String getUsername() { return email; }
    @Override public boolean isAccountNonExpired() { return true; }
    @Override public boolean isAccountNonLocked() { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled() { return true; }
}