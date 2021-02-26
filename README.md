# Data processing scripts for mouse male germ cell atlas

## Environment setup

```bash
conda env create -n scRNA_seq -f env.yml && conda activate scRNA_seq
```

## Data preprocessing

Raw data can be obtained from the Gene Expression Omnibus (GEO) at NCBI with accession number GSE148032.

Scripts for data preprocessing pipeline are located in the "Scripts" directory. Paths in the scripts need to be changed as necessary before running the pipeline.

## Main softwares used in downstream analyses 

* Seurat (v3.0.0)
* Monocle (v2.10.1)
* pyscenic (v0.9.19)
* Cytoscape (v3.7.1)

## Contact

Feel free to submit an issue or contact us at [sunshine_lp0@163.com](mailto:sunshine_lp0@163.com) for problems about this project.
