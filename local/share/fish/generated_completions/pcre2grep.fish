# pcre2grep
# Autogenerated from man page /usr/share/man/man1/pcre2grep.1.gz
complete -c pcre2grep -s A -l after-context --description 'Output up to number lines of context after each matching line.'
complete -c pcre2grep -s a -l text --description 'Treat binary files as text.  This is equivalent to --binary-files=text.'
complete -c pcre2grep -s B -l before-context --description 'Output up to number lines of context before each matching line.'
complete -c pcre2grep -l binary-files --description 'Specify how binary files are to be processed.'
complete -c pcre2grep -l buffer-size --description 'Set the parameter that controls how much memory is obtained at the start of p…'
complete -c pcre2grep -s C -l context --description 'Output number lines of context both before and after each matching line.'
complete -c pcre2grep -s c -l count --description 'Do not output lines from the files that are being scanned; instead output the…'
complete -c pcre2grep -l colour -l color --description 'If this option is given without any data, it is equivalent to "--colour=auto".'
complete -c pcre2grep -s D -l devices --description 'If an input path is not a regular file or a directory, "action" specifies how…'
complete -c pcre2grep -s d -l directories --description 'If an input path is a directory, "action" specifies how it is to be processed.'
complete -c pcre2grep -l depth-limit --description 'See --match-limit below.'
complete -c pcre2grep -s e -l regex -l regexp --description 'Specify a pattern to be matched.'
complete -c pcre2grep -l exclude --description 'Files (but not directories) whose names match the pattern are skipped without…'
complete -c pcre2grep -l exclude-from --description 'Treat each non-empty line of the file as the data for an --exclude option.'
complete -c pcre2grep -l exclude-dir --description 'Directories whose names match the pattern are skipped without being processed…'
complete -c pcre2grep -s F -l fixed-strings --description 'Interpret each data-matching pattern as a list of fixed strings, separated by…'
complete -c pcre2grep -s f -l file --description 'Read patterns from the file, one per line, and match them against each line o…'
complete -c pcre2grep -l file-list --description 'Read a list of files and/or directories that are to be scanned from the given…'
complete -c pcre2grep -l file-offsets --description 'Instead of showing lines or parts of lines that match, show each match as an …'
complete -c pcre2grep -s H -l with-filename --description 'Force the inclusion of the file name at the start of output lines when search…'
complete -c pcre2grep -s h -l no-filename --description 'Suppress the output file names when searching multiple files.'
complete -c pcre2grep -l heap-limit --description 'See --match-limit below.'
complete -c pcre2grep -l help --description 'Output a help message, giving brief details of the command options and file t…'
complete -c pcre2grep -s I --description 'Ignore binary files.  This is equivalent to --binary-files=without-match.'
complete -c pcre2grep -s i -l ignore-case --description 'Ignore upper/lower case distinctions during comparisons.'
complete -c pcre2grep -l include --description 'If any --include patterns are specified, the only files that are processed ar…'
complete -c pcre2grep -l include-from --description 'Treat each non-empty line of the file as the data for an --include option.'
complete -c pcre2grep -l include-dir --description 'If any --include-dir patterns are specified, the only directories that are pr…'
complete -c pcre2grep -s L -l files-without-match --description 'Instead of outputting lines from the files, just output the names of the file…'
complete -c pcre2grep -s l -l files-with-matches --description 'Instead of outputting lines from the files, just output the names of the file…'
complete -c pcre2grep -l label --description 'This option supplies a name to be used for the standard input when file names…'
complete -c pcre2grep -l line-buffered --description 'When this option is given, non-compressed input is read and processed line by…'
complete -c pcre2grep -l line-offsets --description 'Instead of showing lines or parts of lines that match, show each match as a l…'
complete -c pcre2grep -l locale --description 'This option specifies a locale to be used for pattern matching.'
complete -c pcre2grep -l match-limit --description 'Processing some regular expression patterns may take a very long time to sear…'
complete -c pcre2grep -l max-buffer-size --description 'This limits the expansion of the processing buffer, whose initial size can be…'
complete -c pcre2grep -s M -l multiline --description 'Allow patterns to match more than one line.'
complete -c pcre2grep -s N -l newline --description 'The PCRE2 library supports five different conventions for indicating the ends…'
complete -c pcre2grep -s n -l line-number --description 'Precede each output line by its line number in the file, followed by a colon …'
complete -c pcre2grep -l no-jit --description 'If the PCRE2 library is built with support for just-in-time compiling (which …'
complete -c pcre2grep -s O -l output --description 'When there is a match, instead of outputting the whole line that matched, out…'
complete -c pcre2grep -s o -l only-matching --description 'Show only the part of the line that matched a pattern instead of the whole li…'
complete -c pcre2grep -o onumber --description 'Show only the part of the line that matched the capturing parentheses of the …'
complete -c pcre2grep -l om-separator --description 'Specify a separating string for multiple occurrences of -o.'
complete -c pcre2grep -s q -l quiet --description 'Work quietly, that is, display nothing except error messages.'
complete -c pcre2grep -s r -l recursive --description 'If any given path is a directory, recursively scan the files it contains, tak…'
complete -c pcre2grep -l recursion-limit --description 'See --match-limit above.'
complete -c pcre2grep -s s -l no-messages --description 'Suppress error messages about non-existent or unreadable files.'
complete -c pcre2grep -s t -l total-count --description 'This option is useful when scanning more than one file.'
complete -c pcre2grep -s u -l utf-8 --description 'Operate in UTF-8 mode.'
complete -c pcre2grep -s V -l version --description 'Write the version numbers of pcre2grep and the PCRE2 library to the standard …'
complete -c pcre2grep -s v -l invert-match --description 'Invert the sense of the match, so that lines which do not match any of the pa…'
complete -c pcre2grep -s w -l word-regex -l word-regexp --description 'Force the patterns only to match "words".'
complete -c pcre2grep -s x --description 'given any number of times.  If a directory matches both --include-dir and.'
complete -c pcre2grep -o o3 -o o1 -o o3 --description 'then 3 again to be output.'
complete -c pcre2grep -l line-regex -l line-regexp --description 'Force the patterns to start matching only at the beginnings of lines, and in …'
complete -c pcre2grep -l xxx-regexp -l xxx-regex --description '(PCRE2 terminology).  However, the --depth-limit, --file-list,.'

