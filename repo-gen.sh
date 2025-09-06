#!/bin/bash

SOURCE_DIR="./src/main/java/com/volako/model"

# Dossier de sortie des repositories
REPO_DIR="./src/main/java/com/volako/repository"

# Créer le dossier des repositories s’il n’existe pas
mkdir -p "$REPO_DIR"

# Parcours des fichiers .java dans le dossier source
find "$SOURCE_DIR" -type f -name "*.java" | while read file; do
    # Extraire le nom de classe (sans extension)
    class_name=$(basename "$file" .java)

    # Définir le nom du fichier repository
    repo_file="$REPO_DIR/${class_name}Repository.java"

    # Générer le contenu du fichier repository
    cat <<EOF > "$repo_file"
package com.volako.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.volako.model.${class_name};

public interface ${class_name}Repository extends JpaRepository<${class_name}, Long> {}
EOF

    echo "Généré : $repo_file"
done