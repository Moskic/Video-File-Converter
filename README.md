# Video File Converter

This is a Windows batch file script for converting video files from `.ts`, `.mkv`, and `.flv` formats to `.mp4` format using `FFmpeg`. `FFmpeg` is a powerful and popular command-line tool for handling multimedia data.

## How It Works

The script operates by taking one or more files that you drag and drop onto it and converts each file sequentially. For each file, it checks the file extension and runs the corresponding `FFmpeg` command to convert the file into `.mp4` format.

- If the input file has a `.ts`, `.mkv` or `.flv` extension, the script directly copies the video and audio streams to an `.mp4` container. This process is swift and lossless as it does not involve re-encoding the data. However, it will only work if the original streams are in a format that the `.mp4` container supports.

- If the input file has any other extension, the script prints an error message and skips that file.

## Important Notes

- The script assumes that the `FFmpeg` executable is located in the same directory as the batch file. If not, you will need to modify the script to include the full path to the `FFmpeg` executable.

- The resulting `.mp4` files are saved in the same directory as the input files, with the same base filename but a `.mp4` extension.

- The conversion process is sequential and does not process multiple files in parallel. If you drop multiple files onto the batch file, the conversion of all files may take some time as each file is processed one at a time.
