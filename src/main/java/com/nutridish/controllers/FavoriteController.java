package com.nutridish.controllers;

import com.nutridish.entities.FavoriteEntity;
import com.nutridish.services.FavoriteService;
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

    @GetMapping("/recipes/favorite/{id}")
    public List<FavoriteEntity> getFavorite(@PathVariable Long id) {
        return this.favoriteService.getUserFavourite(id);
    }
}
