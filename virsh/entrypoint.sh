#!/bin/bash
set -x

: "${node_count:=3}"
: "${image_pool:="/var/lib/libvirt/images"}"
: "${ubuntu_release:="18.04"}"
: "${base_image:="ubuntu-18.04.qcow2"}"

addtional_block_devs=3
addtional_block_size=32G


function create_nodes() {
    echo "Creating nodes"
    abridge="br-${RANDOM}"
    brctl addbr "${abridge}"
    for aNode in $(seq 1 ${node_count}); do
        user_name="empty-${RANDOM}"

        vm_name="airshipdev"
        libvirt_domain="${user_name}-${vm_name}"

        virtinstall_addtional_block_dev_args=""
        for addtional_block_dev in $(seq 1 ${addtional_block_devs}); do
            qemu-img create \
            -f qcow2 \
            "${image_pool}/${libvirt_domain}_${addtional_block_dev}.qcow2" "${addtional_block_size}"
            virtinstall_addtional_block_dev_args="$virtinstall_addtional_block_dev_args --disk ${image_pool}/${libvirt_domain}_${addtional_block_dev}.qcow2,bus=scsi,format=qcow2"
        done

        echo ${virtinstall_addtional_block_dev_args}

        setfacl -m u:libvirt-qemu:r-x ${image_pool}

        virt-install --connect qemu:///system \
            --os-variant "ubuntu${ubuntu_release}" \
            --name "${libvirt_domain}" \
            --memory 16384 \
            --network bridge="${abridge}" \
            --cpu host-passthrough \
            --vcpus 4 \
            --import \
            ${virtinstall_addtional_block_dev_args} \
            --nographics \
            --noautoconsole \
            --print-xml > /tmp/create_vm_${libvirt_domain}.xml

        virsh define /tmp/create_vm_${libvirt_domain}.xml
done
}

function start_nodes() {
    virsh list --all | grep empty | grep 'shut off' | awk '{ print $2 }' | while read vdomain; do
        virsh start ${vdomain}
    done
}

function delete_nodes() {
    virsh list --all | grep empty | awk '{print $2}' | while read vdomain; do
        virsh destroy ${vdomain}
        virsh undefine ${vdomain}
        for addtional_block_dev in $(seq 1 ${addtional_block_devs}); do
            rm -v "${image_pool}/${vdomain}_${addtional_block_dev}.qcow2"
        done
    done
}

function print_help() {
        echo "Usage: entrypoint.sh <option>


Options:
  create_nodes        Create 3 nodes 
  start_nodes         Start all nodes currently shut off
  delete_nodes        Remove qcow images and remove all nodes 

        "
}


case $1 in

'create_nodes')
  create_nodes
  ;;
'start_nodes')
  start_nodes 
  ;;
'delete_nodes')
  delete_nodes 
  ;;
'list')
  list
  ;;
'nodeinfo')
  nodeinfo
  ;;
  *)
  print_help
  ;;

esac
