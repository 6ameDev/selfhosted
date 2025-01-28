# WatchTower Guide

By default monitoring and auto-updates are enabled for all docker containers. However labels can be added to containers which should only be monitored and notified about, or completely skipped by watchtower.

Add the following labels for specific watchtower behaviour.

To only monitor updates and notify:
```
    labels:
      com.centurylinklabs.watchtower.monitor-only: "true"
```

To disable monitoring:
```
    labels:
      com.centurylinklabs.watchtower.enable: "false"
```
