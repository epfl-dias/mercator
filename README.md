# Mercator Workspace

This repository references everything needed to build various tools related to the Spatial Index.

## Mercator: Spatial Index

**Mercator** is a spatial *volumetric* index for the [Human Brain Project](http://www.humanbrainproject.eu). It is a component of the [Knowledge Graph](http://www.humanbrainproject.eu/en/explore-the-brain/search/) service, which  provides the spatial anchoring for the metadata registered as well as processes the volumetric queries.

It is build on top of the Iron Sea database toolkit.

## Iron Sea: Database Toolkit

**Iron Sea** provides a set of database engine bricks, which can be combined and applied on arbitrary data structures.

Unlike a traditional database, it does not assume a specific physical structure for the tables nor the records, but relies on the developper to provide a set of extractor functions which are used by the specific indices provided.

This enables the index implementations to be agnostic from the underlying data structure, and re-used.

## Requirements

### Software

 * Rust: https://www.rust-lang.org

## Quick start

 * Clone the workspace, which will take care of bringing all the repositories needed.

   ```sh
   git clone --recurse https://github.com/epfl-dias/mercator
   ```

   The following steps assume the working directory is the root of the mercator repository.

 * **[Optional]** Create 3 datasets, of 1, 10 and 100 features respectively, each with 1000 positions:

   ```sh
   cd mercator_data_generator
   cargo run --release -- 1 10 100
   ```

 * Link the data in the indexer folder (It has to be in the current working directory when calling the indexer):

   ```sh
   cd mercator_indexer
   for f in ../mercator_data_generator/1*.json
   do
       ln -s $f
   done
   ```

 * Index the data (assuming the datasets generated above):

   ```sh
   cargo run --release -- 1k 10k 100k
   mv *.index ../mercator_service
   ```

 * Run the Spatial Index, while providing the path to the datasets.

   ```sh
   cd mercator_service
   cargo run --release
   ```

## Documentation

For more information, please refer to each sub projects, as well as the on-line help for the tools & utilities.

### Tools

 * Mercator Service
   **[[src](https://github.com/epfl-dias/mercator_service), [doc](https://epfl-dias.github.io/mercator_service/)]**
 * Mercator Indexer
   **[[src](https://github.com/epfl-dias/mercator_indexer)]**

### Utilities

 * Mercator Data Generator
   **[[src](https://github.com/epfl-dias/mercator_data_generator/)]**

### Libraries

 * IronSea Index
    **[[src](https://github.com/epfl-dias/ironsea_index/), [doc](https://epfl-dias.github.io/ironsea_index/)]**
 * IronSea Index HashMap
    **[[src](https://github.com/epfl-dias/ironsea_index_hashmap/), [doc](https://epfl-dias.github.io/ironsea_index_hashmap/)]**
 * IronSea Index SFC-DBC
   **[[src](https://github.com/epfl-dias/ironsea_index_sfc_dbc/), [doc](https://epfl-dias.github.io/ironsea_index_sfc_dbc/)]**
 * Mercator DB
   **[[src](https://github.com/epfl-dias/mercator_db/), [doc](https://epfl-dias.github.io/mercator_db/)]**
 * Mercator Parser **[[src](https://github.com/epfl-dias/mercator_parser/), [doc](https://epfl-dias.github.io/mercator_parser/), [query language](https://epfl-dias.github.io/mercator_parser/book/)]**

## Acknowledgements

This open source software code was developed in part or in whole in the
Human Brain Project, funded from the European Union’s Horizon 2020
Framework Programme for Research and Innovation under the Specific Grant
Agreement No. 785907 (Human Brain Project SGA2).
