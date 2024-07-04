#!/bin/bash

# Function to check if the current cluster name is "my-cluster-0"
check_cluster_name() {
    local cluster_name=$(aws eks list-clusters --query 'clusters[?contains(@, `my-cluster-0`)]' --output text)
    if [ "$cluster_name" == "my-cluster-0" ]; then
        echo "Cluster name is my-cluster-0. Proceeding with port forwarding..."
        return 0
    else
        echo "Cluster name is not my-cluster-0. Exiting..."
        return 1
    fi
}

# Function to perform port forwarding
port_forward() {
    local namespace=$1
    local pod_name=$2
    local local_port=$3
    local remote_port=$4

    echo "Port forwarding $local_port:$remote_port for pod $pod_name in namespace $namespace"
    kubectl port-forward -n $namespace $pod_name $local_port:$remote_port &
}

# Main script execution
if check_cluster_name; then
    # Replace with the appropriate namespace, pod names, and ports
    namespace1="default"
    pod_name1=$(kubectl get pods -n $namespace1 -o jsonpath="{.items[0].metadata.name}")
    local_port1=8080
    remote_port1=80
    
    namespace2="default"
    pod_name2=$(kubectl get pods -n $namespace2 -o jsonpath="{.items[1].metadata.name}")
    local_port2=8081
    remote_port2=81
    
    namespace3="default"
    pod_name3=$(kubectl get pods -n $namespace3 -o jsonpath="{.items[2].metadata.name}")
    local_port3=8082
    remote_port3=82
    
    port_forward $namespace1 $pod_name1 $local_port1 $remote_port1
    port_forward $namespace2 $pod_name2 $local_port2 $remote_port2
    port_forward $namespace3 $pod_name3 $local_port3 $remote_port3

    # Wait for background port-forward processes to complete
    wait
else
    exit 1
fi
