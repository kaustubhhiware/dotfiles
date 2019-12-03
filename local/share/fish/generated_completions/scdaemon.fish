# scdaemon
# Autogenerated from man page /usr/share/man/man1/scdaemon.1.gz
complete -c scdaemon -l options --description 'Reads configuration from file instead of from the default per-user configurat…'
complete -c scdaemon -l homedir --description 'Set the name of the home directory to dir.'
complete -c scdaemon -l verbose --description 'Outputs additional information while running.'
complete -c scdaemon -l debug-level --description 'Select the debug level for investigating problems.'
complete -c scdaemon -l debug --description 'This option is only useful for debugging and the behavior may change at any t…'
complete -c scdaemon -l debug-all --description 'Same as --debug=0xffffffff.'
complete -c scdaemon -l debug-wait --description 'When running in server mode, wait n seconds before entering the actual proces…'
complete -c scdaemon -l debug-ccid-driver --description 'Enable debug output from the included CCID driver for smartcards.'
complete -c scdaemon -l debug-disable-ticker --description 'This option disables all ticker functions like checking for card insertions.'
complete -c scdaemon -l debug-allow-core-dump --description 'For security reasons we won\'t create a core dump when the process aborts.'
complete -c scdaemon -l debug-log-tid --description 'This option appends a thread ID to the PID in the log output.'
complete -c scdaemon -l debug-assuan-log-cats --description 'Changes the active Libassuan logging categories to cats.'
complete -c scdaemon -l no-detach --description 'Don\'t detach the process from the console.'
complete -c scdaemon -l listen-backlog --description 'Set the size of the queue for pending connections.   The default is 64.'
complete -c scdaemon -l log-file --description 'Append all logging output to file.'
complete -c scdaemon -l pcsc-driver --description 'Use library to access the smartcard reader.'
complete -c scdaemon -l ctapi-driver --description 'Use library to access the smartcard reader.'
complete -c scdaemon -l disable-ccid --description 'Disable the integrated support for CCID compliant readers.'
complete -c scdaemon -l reader-port --description 'This option may be used to specify the port of the card terminal.'
complete -c scdaemon -l card-timeout --description 'If n is not 0 and no client is actively using the card, the card will be powe…'
complete -c scdaemon -l enable-pinpad-varlen --description 'Please specify this option when the card reader supports variable length inpu…'
complete -c scdaemon -l disable-pinpad --description 'Even if a card reader features a pinpad, do not try to use it.'
complete -c scdaemon -l deny-admin --description 'This option disables the use of admin class commands for card applications wh…'
complete -c scdaemon -l version --description 'Print the program version and licensing information.'
complete -c scdaemon -l help -s h --description 'Print a usage message summarizing the most useful command-line options.'
complete -c scdaemon -l dump-options --description 'Print a list of all available options and commands.'
complete -c scdaemon -l server --description 'Run in server mode and wait for commands on the stdin.'
complete -c scdaemon -l multi-server --description 'Run in server mode and wait for commands on the stdin as well as on an additi…'
complete -c scdaemon -l daemon --description 'Run the program in the background.'
complete -c scdaemon -s v --description '.'
complete -c scdaemon -l allow-admin --description 'commands.'
complete -c scdaemon -l disable-application --description 'This option disables the use of the card application named name.'
