#!/bin/bash

# Chemins des dossiers source et cible
SOURCE_DIR="/home/moneem/Desktop/dossier1"
TARGET_DIR="/home/moneem/Desktop/dossier2"

# Vérification de l'existence du dossier source
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Le dossier source '$SOURCE_DIR' n'existe pas."
  exit 1
fi

# Vérification de l'existence du dossier cible
if [ ! -d "$TARGET_DIR" ]; then
  echo "Le dossier cible '$TARGET_DIR' n'existe pas, il sera créé."
  mkdir -p "$TARGET_DIR"
fi

# Fonction pour copier les fichiers existants dans les deux dossiers
copy_existing_files() {
  local source="$1"
  local target="$2"

  # Parcourir les fichiers dans le dossier source
  find "$source" -type f | while read file; do
    # Chemin relatif du fichier par rapport au dossier source
    relative_path="${file#$source/}"
    file_name=$(basename "$file")

    # Chemin complet du fichier dans le dossier cible
    target_file="$target/$relative_path"
    find "$target" -type f | while read fl; do
    # Vérifier si le fichier existe dans les deux dossiers
      fn=$(basename "$fl")
      echo $file_name $fn
      if [ "$file_name" = "$fn" ]; then
        # Remplacer le fichier dans le dossier cible
        cp "$file" "$fl"
        echo "Le fichier '$relative_path' a été remplacé dans '$target'."
      fi
    done
  done
  
}

# Appeler la fonction pour copier les fichiers existants
copy_existing_files "$SOURCE_DIR" "$TARGET_DIR"

echo "Terminé."

