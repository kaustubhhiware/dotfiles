# sensord
# Autogenerated from man page /usr/share/man/man8/sensord.8.gz
complete -c sensord -s i -l interval --description 'Specify the interval between scanning for sensor alarms; the default is to sc…'
complete -c sensord -s l -l log-interval --description 'Specify the interval between logging all sensor readings; the default is to l…'
complete -c sensord -s t -l rrd-interval --description 'Specify the interval between logging all sensor readings to a round-robin dat…'
complete -c sensord -s T -l rrd-no-average --description 'Specify that the round-robin database should not be averaged.'
complete -c sensord -s r -l rrd-file --description 'Specify a round-robin database into which to log all sensor readings; e. g.'
complete -c sensord -s c -l config-file --description 'Specify a  libsensors (3) configuration file.'
complete -c sensord -s p -l pid-file --description 'Specify what PID file to write; the default is to write the file `/var/run/se…'
complete -c sensord -s f -l syslog-facility --description 'Specify the  syslog (3) facility to use when logging sensor readings and alar…'
complete -c sensord -s g -l rrd-cgi --description 'Prints out a sample  rrdcgi (1) CGI script that can be used to display graphs…'
complete -c sensord -s a -l load-average --description 'Include the load average in the RRD database.'
complete -c sensord -s d -l debug --description 'Prints a small amount of additional debugging information.'
complete -c sensord -s h -l help --description 'Prints a help message and exits.'
complete -c sensord -s v -l version --description 'Displays the program version and exits.'

