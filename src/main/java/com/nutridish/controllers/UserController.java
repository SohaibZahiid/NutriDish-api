package com.nutridish.controllers;

import com.nutridish.dto.UserDTO;
import com.nutridish.dto.UserLoginDTO;
import com.nutridish.entities.UserEntity;
import com.nutridish.services.UserService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



@RestController
@RequestMapping("/api")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("register")
    public ResponseEntity<String> register(@Valid @RequestBody UserEntity user) {
        ResponseEntity<String> response = userService.register(user);
        return ResponseEntity.status(response.getStatusCode()).body(response.getBody());
    }

    @PostMapping("/login")
    public ResponseEntity<UserDTO> login(@Valid @RequestBody UserLoginDTO user) {
        String username = user.getUsername();
        String password = user.getPassword();

        return userService.login(username, password);
    }

    @GetMapping("/user/{id}")
    public ResponseEntity<UserDTO> getUserById(@PathVariable Long id) {
        return userService.getUserById(id);
    }

    @PutMapping("/user/{id}/update")
    public ResponseEntity<String> updateUser(@PathVariable Long id, @Valid @RequestBody UserEntity user) {
        return userService.updateUser(id, user);
    }
}
