docker build -t komparo/tde_dataset_dyntoy .
docker push komparo/tde_dataset_dyntoy

rm .snakemake/singularity/*.simg

snakemake
snakemake --use-singularity
