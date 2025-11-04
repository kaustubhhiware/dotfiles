<task name="Test and Lint">

<task_objective>
Run the complete test suite first, then perform linting checks on the codebase. This workflow ensures code quality by validating functionality before checking style and consistency.
</task_objective>

<detailed_sequence_steps>

# Test and Lint Process - Detailed Sequence of Steps

## 1. Run Tests

1. Execute the complete test suite using the project's make command:
   ```bash
   make test
   ```
   
2. If tests fail, do not stop the workflow and report the failures to the user.

## 2. Run Lint Checks

1. Proceed with linting:
   ```bash
   make lint
   ```

2. Report any linting issues found.

## 3. Report Results

1. Use the `attempt_completion` tool to present the results to the user. Communicate efficiently.

2. Include:
   - Test execution summary
   - Lint check results
   - Any issues found and recommendations for fixes

</detailed_sequence_steps>

</task>
