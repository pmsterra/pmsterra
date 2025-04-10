

import functions_framework
import os
from google.auth import compute_engine
from google.auth.transport.requests import Request
from google.cloud import container_v1
from kubernetes import client, config
from kubernetes.client.rest import ApiException


def get_gke_access_token():
    credentials = compute_engine.Credentials()
    credentials.refresh(Request())
    return credentials.token


def get_gke_credentials(cluster_name, region, project_id):
    gke_client = container_v1.ClusterManagerClient()
    cluster = gke_client.get_cluster(name=f"projects/{project_id}/locations/{region}/clusters/{cluster_name}")
    
    endpoint = cluster.endpoint
    cluster_ca_certificate = cluster.master_auth.cluster_ca_certificate
    access_token = get_gke_access_token()
    
    config.load_kube_config_from_dict({
        'apiVersion': 'v1',
        'clusters': [{
            'name': cluster_name,
            'cluster': {
                'server': f'https://{endpoint}',
                'certificate-authority-data': cluster_ca_certificate,
            }
        }],
        'contexts': [{
            'name': cluster_name,
            'context': {
                'cluster': cluster_name,
                'user': 'gke-user',
            }
        }],
        'current-context': cluster_name,
        'users': [{
            'name': 'gke-user',
            'user': {
                'token': access_token,
            }
        }]
    })


def safe_delete(resource_func, resource_description):
    try:
        resource_func()
        print(f"✅ Deleted: {resource_description}")
    except ApiException as e:
        if e.status == 404:
            print(f"⚠️ Not found (already deleted?): {resource_description}")
        else:
            print(f"❌ Error deleting {resource_description}: {e}")


def cleanup_gke_resources(cluster_name, region, project_id, namespace_name, service_account_name):
    get_gke_credentials(cluster_name, region, project_id)

    # Use same naming from your original code
    daemonset_name = "example-daemonset"
    priority_class_name = "pcc-defender-ds"
    cluster_role_name = "example-defender-cluster-role"
    cluster_role_binding_name = "example-defender-cluster-role-binding"
    role_name = "example-defender-role"
    role_binding_name = "example-defender-role-binding"

    core_v1 = client.CoreV1Api()
    apps_v1 = client.AppsV1Api()
    rbac_v1 = client.RbacAuthorizationV1Api()
    scheduling_v1 = client.SchedulingV1Api()

    print("\n🧹 Starting GKE resource cleanup...\n")

    safe_delete(lambda: apps_v1.delete_namespaced_daemon_set(name=daemonset_name, namespace=namespace_name),
                f"DaemonSet: {daemonset_name}")
    
    safe_delete(lambda: rbac_v1.delete_namespaced_role_binding(name=role_binding_name, namespace=namespace_name),
                f"RoleBinding: {role_binding_name}")
    
    safe_delete(lambda: rbac_v1.delete_namespaced_role(name=role_name, namespace=namespace_name),
                f"Role: {role_name}")
    
    safe_delete(lambda: rbac_v1.delete_cluster_role_binding(name=cluster_role_binding_name),
                f"ClusterRoleBinding: {cluster_role_binding_name}")
    
    safe_delete(lambda: rbac_v1.delete_cluster_role(name=cluster_role_name),
                f"ClusterRole: {cluster_role_name}")
    
    safe_delete(lambda: core_v1.delete_namespaced_service_account(name=service_account_name, namespace=namespace_name),
                f"ServiceAccount: {service_account_name}")
    
    safe_delete(lambda: scheduling_v1.delete_priority_class(name=priority_class_name),
                f"PriorityClass: {priority_class_name}")
    
    safe_delete(lambda: core_v1.delete_namespace(name=namespace_name),
                f"Namespace: {namespace_name}")

    print("\n✅ GKE cleanup complete.\n")


@functions_framework.cloud_event
def cleanup_resources(cloud_event):
    # Reuse your existing env var names
    cluster_name = os.environ.get("GKE_CLUSTER_NAME")
    region = os.environ.get("GKE_REGION")
    project_id = os.environ.get("PROJECT_ID")
    namespace_name = os.environ.get("NAMESPACE")
    service_account_name = os.environ.get("KSA_NAME")

    if not all([cluster_name, region, project_id, namespace_name, service_account_name]):
        print("❌ Missing required environment variables.")
        return

    try:
        cleanup_gke_resources(cluster_name, region, project_id, namespace_name, service_account_name)
    except Exception as e:
        print(f"❌ General exception during cleanup: {str(e)}")




google-cloud-container
google-auth
kubernetes
functions-framework
