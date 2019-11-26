# CSC324 Testing Suite

This is a crude testing suite for CSC324-A2 (Chups!)

## Usage

Run the following command in your repository inside your folder containing `Chups.hs` and `ChupsTypes.hs`:

```sh
git submodule add https://github.com/EDToaster/CSC324-A2-TestingSuite testing
```

### Running the Test Suite

```sh
cd testing
chmod +x main.sh
./main.sh
```

### Adding a New Test

All tests reside in `./tests`, add a new file here for your new test.

Note: You need to use the `cps` transformed versions of the functions `cps:*, cps:+, etc`. Since there is no `cps:-` or `cps:/`, arithmetic expressions are fairly limited (unless you implement them yourself). The testing suite does not guarantee that your solution to A2 is correct, even if it passes all of the test cases!

Note note: The return value of the test cases can be anything. We aren't checking for the return values ... rather we are checking that, after running through the transformation, the output stays the same!

## Implementation

This test suite works as follows:

* For each input program in `tests` folder
* Transpile this input program to haskell-data format
* Transpile haskell-data format back to racket using cpsTransform
* Evaluate both the input Chups program and the output Racket program
* If the two outputs are equivalent, pass the test case
* If the two outputs are different, fail the test case
