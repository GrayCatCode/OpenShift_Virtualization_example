# Prerequisites

- OpenShift 4.x cluster with cluster-admin access.
- StorageClass capable of provisioning disk volumes (block or filesystem) for PVCs.
- OpenShift Virtualization (KubeVirt) operator installed (via operator/ manifests or OperatorHub).
- (Optional) Multus CNI if you need secondary networks.
- (Optional) CDI (Containerized Data Importer) installed for DataVolume imports.
