# CSC324 Testing Suite

This is a crude testing suite for CSC324-A2 (Chups!)

## Usage

`git clone` this repository inside your folder containing `Chups.hs` and `ChupsTypes.hs`

### Example

If your directory containing your source files (`Chups.hs`) is `dir/`, clone the repository into `dir/testing/`

### Running the Test Suite

* `cd` into the git repository
* `chmod +x main.sh`
* `./main.sh`

### Adding a New Test

All tests reside in `./tests`, add a new file here for your new test.

Note: You need to use the `cps` transformed versions of the functions `cps:*, cps:+, etc`.