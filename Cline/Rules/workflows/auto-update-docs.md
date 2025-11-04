<task name="Auto-Update Documentation">

<task_objective>
Automatically update project documentation when code changes are detected, ensuring docs stay synchronized with the codebase.
</task_objective>

<detailed_sequence_steps>

# Auto-Update Documentation Process - Detailed Sequence of Steps

## 1. Detect Changes

1. Monitor for file changes in key directories:
   - `internal/` for code changes
   - `docs/` for documentation updates
   - `README.md` and other root-level docs

2. Use `search_files` to identify outdated references or missing documentation.

## 2. Analyze Impact

1. Read modified files to understand changes.

2. Identify documentation that needs updates:
   - API documentation for gRPC services
   - Architecture diagrams for new services
   - Configuration documentation
   - README files for new features

## 3. Update Documentation

1. Check existing documentation structure using `list_files`.

2. Update or create documentation files:
   - Use `replace_in_file` for targeted updates
   - Use `write_to_file` for new documentation

3. Ensure consistency with project standards:
   - Follow established markdown formatting
   - Include code examples where relevant
   - Update table of contents if needed

## 4. Validate Updates

1. Check that all links are valid.

2. Ensure code examples compile and run.

3. Verify documentation completeness.

4. Use `attempt_completion` to present the updated documentation.

</detailed_sequence_steps>

</task>
