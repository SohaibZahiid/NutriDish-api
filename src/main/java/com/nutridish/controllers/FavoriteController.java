package com.nutridish.controllers;

import com.nutridish.entities.FavoriteEntity;
import com.nutridish.entities.RecipeEntity;
import com.nutridish.pojos.JsonRes;
import com.nutridish.services.FavoriteService;
import com.nutridish.services.RecipeService;
import com.nutridish.services.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api")
public class FavoriteController {

    private final FavoriteService favoriteService;

    public FavoriteController(FavoriteService favoriteService) {
        this.favoriteService = favoriteService;
    }

    @GetMapping("/recipes/favorites/{id}")
    public List<RecipeEntity> getFavoriteRecipes(@PathVariable Long id) {
        return this.favoriteService.getUserFavourite(id);
    }

    @GetMapping("/recipes/{mealType}/favorites/{userId}")
    public List<RecipeEntity> getRecipesByMealTypeAndFavorite(
            @PathVariable Long userId,
            @PathVariable String mealType
    ) {
        return favoriteService.getRecipesByMealTypeAndFavorite(userId, mealType);
    }

    @PostMapping("/recipe/{userId}/favorites/{recipeId}")
    public JsonRes<FavoriteEntity> addRecipeToFavorites(@PathVariable Long userId, @PathVariable Long recipeId) {
        return favoriteService.addRecipeToFavorites(userId, recipeId);
    }

    /*@GetMapping("/recipes/favorites/{userId}")
    public List<RecipeEntity> getAllRecipesWithFavoriteIndicator(@PathVariable Long userId) {
        return favoriteService.getAllRecipesWithFavoriteIndicator(userId);
    }*/


}
