# auto-filebot-amc
Helper script to automate media renaming with the help of Filebot and AMC script

# variables
* **INPUT_DIR** - currently passed at the command line
* **OUTPUT_DIR** - where media will be placed
* **AMC_LOG** - path where script will append to the AMC log
* **KODI** - if you use kodi, you can specify the IP or hostname of the machine 
running Kodi and it will be notified to rescan its library

The following are Filebot parameters you can configure...
* **ACTION** - rename action (**move** | copy | keeplink | symlink | hardlink | test)
* **CONFLICT** - conflict resolution (override | skip | **auto** | index | fail)
* **CLEAN** - remove junk from INPUT_DIR

# usage
Clone project `git clone https://github.com/jbfreels/auto-filebot-amc.git`

```bash
$ cd auto-filebot-amc
$ ./auto-filebot-amc <PATH_TO_MEDIA>
```
