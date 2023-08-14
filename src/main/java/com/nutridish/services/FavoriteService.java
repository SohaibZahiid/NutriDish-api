package com.nutridish.services;

import com.nutridish.entities.FavoriteEntity;
import com.nutridish.repositories.FavoriteRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FavoriteService {
    final FavoriteRepository favoriteRepository;

    public FavoriteService(FavoriteRepository favoriteRepository) {
        this.favoriteRepository = favoriteRepository;
    }

    public List<FavoriteEntity> getUserFavourite(Long id) {
        return this.favoriteRepository.findByUserId(id);
    }
}
