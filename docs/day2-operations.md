# Day 2 operations

- Snapshotting: use CSI volume snapshots where supported, or KubeVirt/VMSnapshots if your cluster supports it.
- Migration: use `virtctl migrate` or VirtualMachineInstance migration APIs.
- Resizing disks: expand the underlying PVC and then the guest filesystem; ensure guest tools or cloud-init support resizing.
- Backup: use Velero with CSI snapshot support or export DataVolumes for offline backups.
