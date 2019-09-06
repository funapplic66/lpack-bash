# lpack-bash
Bash script that creates a .lbry archive that supports JS and CSS within the LBRY app! The original script was in fish. This is a conversion and improvement over the original one.

Inspired from [https://open.lbry.com/blog#4](https://open.lbry.com/blog#4) and [https://open.lbry.com/@BrendonBrewer:3/websites:0](https://open.lbry.com/@BrendonBrewer:3/websites:0).

## Requirements

- Linux
- bash
- zstd
- tar

## Testing

There is a test file on this repo to test basic functionality. Navigate to `test` directory README.md file for details.

## Usage

Make sure it is executable: `chmod +x lpack.bash`

Run:

```
$ lpack.bash /path/to/your/html/files yourfilename.lbry
```

This should create a `yourfilename.lbry` file ready to be uploaded to LBRY.

**License: MIT**
