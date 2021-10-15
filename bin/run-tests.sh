#! /bin/sh

# Synopsis:
# Test the lines of code counter by running it against a predefined set of solutions 
# with an expected output.

# Output:
# Outputs the diff of the expected counts against the actual counts
# generated by the lines of code counter.

# Example:
# ./bin/run-tests.sh

exit_code=0

# Iterate over all test directories
for test_dir in tests/*/*; do
    track_name=$(basename $(realpath "${test_dir}/../"))
    exercise_name=$(basename "${test_dir}")
    test_dir_path=$(realpath "${test_dir}")
    counts_file_path="${test_dir_path}/counts.json"
    expected_counts_file_path="${test_dir_path}/expected_counts.json"

    bin/run.sh "${track_name}" "${exercise_name}" "${test_dir_path}" "${test_dir_path}"

    echo "${track_name}/${exercise_name}: comparing counts.json to expected_counts.json"
    diff "${counts_file_path}" "${expected_counts_file_path}"

    if [ $? -ne 0 ]; then
        exit_code=1
    fi
done

exit ${exit_code}
