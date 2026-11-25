# C template for multiple main files

For https://c-programming.aydos.de

Select a C main file and press <kbd>F5</kbd> to start your program. There are two examples for testing: `hello.c` and `pi-estimator.c`.

## CSV file filter tests

Run the regression test for malformed short CSV rows with:

```sh
bash tests/test-csv-file-filter.sh
```

The test compiles `src/CSV-file-filter.c` with a C++20 compiler (`g++` by default; set `CXX` to use another compiler) and verifies that a one-character input row reports a missing age instead of crashing.