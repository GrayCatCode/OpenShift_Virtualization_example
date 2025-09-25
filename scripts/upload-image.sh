#!/usr/bin/env bash
# Upload a local qcow2/.img to a PVC using virtctl image-upload (KubeVirt) OR create a DataVolume pointing to a URL.
# Usage:
#   ./upload-image.sh --method=virtctl --namespace=vm-workloads --pvc=vm-root-disk --file=./images/ubuntu.qcow2
#   ./upload-image.sh --method=datavolume --namespace=vm-workloads --url=https://.../image.img --name=vm-boot-image
set -euo pipefail
method=virtctl
namespace=vm-workloads
pvc=vm-root-disk
file=""
url=""
dvname=vm-boot-image

while [[ $# -gt 0 ]]; do
  case $1 in
    --method) method="$2"; shift 2;;
    --namespace) namespace="$2"; shift 2;;
    --pvc) pvc="$2"; shift 2;;
    --file) file="$2"; shift 2;;
    --url) url="$2"; shift 2;;
    --name) dvname="$2"; shift 2;;
    *) echo "Unknown $1"; exit 1;;
  esac
done

if [[ "$method" == "virtctl" ]]; then
  if [[ -z "$file" ]]; then
    echo "file required for virtctl method"; exit 1
  fi
  echo "Uploading ${file} to PVC ${pvc} in namespace ${namespace} using virtctl..."
  virtctl image-upload $pvc --namespace $namespace --image-path $file --insecure
  echo "Upload complete."
else
  if [[ -z "$url" ]]; then
    echo "url required for datavolume method"; exit 1
  fi
  echo "Creating DataVolume ${dvname} in ${namespace} that imports ${url}..."
  cat <<EOF | oc apply -f -
apiVersion: cdi.kubevirt.io/v1beta1
kind: DataVolume
metadata:
  name: ${dvname}
  namespace: ${namespace}
spec:
  source:
    http:
      url: "${url}"
  pvc:
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
        storage: 10Gi
    storageClassName: my-block-storage
EOF
  echo "DataVolume created. Monitor import with: oc get dv -n ${namespace} ${dvname} -o yaml"
fi
