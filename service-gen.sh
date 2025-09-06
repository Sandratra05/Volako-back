#!/bin/bash

SOURCE_DIR="./src/main/java/com/volako/model"
REPO_DIR="./src/main/java/com/volako/service"

mkdir -p "$REPO_DIR"

find "$SOURCE_DIR" -type f -name "*.java" | while read -r file; do
    class_name=$(basename "$file" .java)
    class_name_minus="${class_name,}"
    repo_file="$REPO_DIR/${class_name}Service.java"

    cat <<EOF > "$repo_file"
package com.volako.service;

import org.springframework.stereotype.Service;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import com.volako.model.${class_name};
import com.volako.repository.${class_name}Repository;

@Service
public class ${class_name}Service {
    @Autowired
    private ${class_name}Repository ${class_name_minus}Repository;

    public ${class_name} findById(Long id){
        return ${class_name_minus}Repository.findById(id).get();
    }

    public List<${class_name}> findAll(){
        return ${class_name_minus}Repository.findAll();
    }

    public Long save(${class_name} ${class_name_minus}){
        Long result = ${class_name_minus}Repository.save(${class_name_minus}).getId${class_name}();
        return result;
    }
}
EOF

    echo "Généré : $repo_file"
done