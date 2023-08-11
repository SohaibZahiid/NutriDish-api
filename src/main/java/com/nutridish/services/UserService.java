package com.nutridish.services;

import com.nutridish.dto.UserDTO;
import com.nutridish.entities.FavoriteEntity;
import com.nutridish.entities.RecipeEntity;
import com.nutridish.entities.UserEntity;
import com.nutridish.repositories.FavoriteRepository;
import com.nutridish.repositories.RecipeRepository;
import com.nutridish.repositories.UserRepository;
import jakarta.validation.Valid;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RecipeRepository recipeRepository;
    private final FavoriteRepository favoriteRepository;
    private final ModelMapper modelMapper;

    public UserService(UserRepository userRepository, ModelMapper modelMapper, RecipeRepository recipeRepository, FavoriteRepository favoriteRepository) {
        this.userRepository = userRepository;
        this.modelMapper = modelMapper;
        this.recipeRepository = recipeRepository;
        this.favoriteRepository = favoriteRepository;
    }

    public ResponseEntity<String> register(UserEntity user) {

        if (userRepository.existsByUsername(user.getUsername())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Username is already taken");
        }

        UserEntity registeredUser = userRepository.save(user);
        if (registeredUser == null) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to register user");
        }

        return ResponseEntity.status(HttpStatus.CREATED).body("User registered successfully");
    }

    public ResponseEntity<UserDTO> login(String username, String password) {
        UserEntity user = userRepository.findByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            UserDTO mappedUser = modelMapper.map(user, UserDTO.class);
            return ResponseEntity.ok(mappedUser);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    public ResponseEntity<UserDTO> getUserById(Long id) {
        UserEntity user = userRepository.findById(id).orElse(null);

        if (user != null) {
            UserDTO mappedUser = modelMapper.map(user, UserDTO.class);
            return ResponseEntity.ok(mappedUser);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    public ResponseEntity<String> updateUser(Long id, UserEntity user) {

        UserEntity existingUser = userRepository.findById(id).orElse(null);


        if (existingUser == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User not found");
        } else if (!existingUser.getUsername().equals(user.getUsername()) && userRepository.existsByUsername(user.getUsername())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Username is already taken");
        } else {
            existingUser.setName(user.getName());

            existingUser.setUsername(user.getUsername());
            existingUser.setPassword(user.getPassword());
            userRepository.save(existingUser);
            return ResponseEntity.status(HttpStatus.CREATED).body("User updated successfully");
        }


    }

    public void addRecipeToFavorites(Long userId, Long recipeId) {
        UserEntity user = userRepository.findById(userId)
                .orElse(null);

        RecipeEntity recipe = recipeRepository.findById(recipeId)
                .orElse(null);

        FavoriteEntity favorite = new FavoriteEntity();
        favorite.setUser(user);
        favorite.setRecipe(recipe);

        favoriteRepository.save(favorite);

    }

}
