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
   git clone --recurse git@gitlab.epfl.ch:DIAS/PROJECTS/HBP-SP5/mercator.git
   ```

   The following steps assume the working directory is the root of the mercator repository.

 * **[Optional]** Create 3 datasets, of 1, 10 and 100 features respectively, each with 1000 positions:

   ```sh
   cd mercator_data_generator
   cargo run --release -- 1 10 100
   ```

 * Index the data:

   ```sh
   cd mercator_indexer
   for f in ../mercator_data_generator/1*.json
   do
   	ln -s $f
   done
   cargo run --release -- 1k 10k 100k
   ```

 * Run the Spatial Index, while providing one of the datasets. Currently only one dataset (core) can be loaded at a time.

   ```sh
   cd mercator_service
   for f in ../mercator_indexer/*.index
   do
   	ln -s $f
   done
   RUST_LOG="warn,actix_web=info,mercator_service=trace" \
     MERCATOR_IMPORT_DATA="100k" \
     MERCATOR_ALLOWED_ORIGINS="http://localhost:3200" \
     cargo run --release
   ```

## Documentation

For more information, please refer to the [documentation](https://epfl-dias.github.io/PROJECT_NAME/).

If you want to build the documentation and access it locally, you can use:

```sh
cargo doc --open
```

## Acknowledgements

This open source software code was developed in part or in whole in the
Human Brain Project, funded from the European Union’s Horizon 2020
Framework Programme for Research and Innovation under the Specific Grant
Agreement No. 785907 (Human Brain Project SGA2).
