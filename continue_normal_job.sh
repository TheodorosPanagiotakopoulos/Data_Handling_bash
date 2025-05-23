# /bin/bash

continue_MD() {
    if [[ ! -f "CONTCAR" ]]; then
        echo "CONTCAR not found. Nothing to do."
        return
    fi
    num=$(( $(ls -d RUN*/ 2>/dev/null | wc -l) + 1 ))
    dir="RUN$num"
    mkdir "$dir"
    gzip OUTCAR
    for f in *; do
        [[ $f == "$dir" || $f == slurm* ]] && continue
        cp -r "$f" "$dir/"
    done
    rm -rf slurm*
    rm -rf OUTCAR.gz
    mv CONTCAR POSCAR
}

continue_MD
