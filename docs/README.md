# Cloud Native Toolkit 

## Install CNCF DevOps Tools using Schematics or IBM Private Catalogs

This git repository is a dirivative of the **Interation Zero** project from
 the **IBM Garage Cloud Native Toolkit**. It has been created to make the
  installation of the Toolkit CNCF DevOps tools very easy from IBM Cloud
   Schematics services or as a Tile in the IBM Private Catalog . The tools
    offer a simple
    approach to CI/CD with IBM Manage clusters OpenShift and Kubernetes. 
   
You can find out more information about the toolkit and the iteration zero
 terraform here :
    
- [IBM Garage Cloud Native Toolkit](https://cloudnativetoolkit.dev/)
- [Toolkit Iteration Zero Terraform](https://github.com/ibm-garage-cloud/ibm-garage-iteration-zero)

Follow the instructions below to install these commond cloud native tools into a

### Prerequisites

Prepare to run Terraform to install the CNCF DevOps Tools into an existing IBM Cloud managed OpenShift or Kubernetes cluster

The Developer Tools are installed by an cloud account
 administrator, who will run the IasC to create the environment in an IBM Cloud account. The scripts will run as the environment administrator's user. These instructions explain how to configure and run the Terraform (IasC) scripts to create the <Globals name="env" />.

**Note**: The Terraform scripts will clean up the cluster to remove any existing installation that may have been previously been installed.

### Confirm permissions

Optional: To help confirm that the scripts will have the permissions they'll require, the environment administrator may log into the account and test creating a couple of resources:
- [Create a cluster](https://cloud.ibm.com/kubernetes/catalog/cluster/create) -- Make it single-zone, and specify the proper data center and resource group
- Create a namespace in the image registry

As long as the user can create these resources successfully the schematics terraform script will be able to apply its state to the cluster.

Configure IBM Cloud Schematics with Terraform infrastructure-as-code (IasC) scripts that will install the tools into your IBM Cloud managed cluster

### Setup Schematics

- Create a workspace in IBM Schematics service and call it `cloud-native-toolkit` and place it in your nominate resource group.

- On the Settings view import your terraform template
    ```bash
    https://github.com/ibm-garage-cloud/cloudnative-toolkit
    ```
- select `terraform_v0.12` version from the Terraform version drop down

- click **Save template information**

### Variables 

To support the running of the Terraform for the CNCF DevSecOps installation configure your variables

The installation requires a set of terraform variables to be set for your environment. The Terraform assumes that a cluster has already been created and the CNCF tools are installed into an existing cluster.

| **Variable**   | **Description**  | **eg. Value**  |
|---|---|---|
| `ibmcloud_api_key` | The API key from IBM Cloud Console that support service creation access writes  | `{guid API key from Console}`  |
|  `resource_group_name` | The name of the resource group where the cluster is created  | `dev-team-one`  |
|  `cluster_type`       |  The name of the IKS cluster |  `kubernetes or ocp4` |
|  `cluster_name`       |  The name of the IKS cluster |  `dev-team-one-iks-117-vp` |
|  `cluster_exists`     |  Does the cluster exist already | `true`  |
|  `vpc_cluster`        | Is the cluster created in VPC  | `true`  |

### Environment variables

Set them based on the existing cluster:
- `resource_group_name` -- The existing cluster's resource group
- `cluster_exists` -- Set to `true` for an existing cluster
- `cluster_type` -- Specify the existing cluster's type
    - **kubernetes** -- Kubernetes
    - **openshift** -- OpenShift v3
    - **ocp3** -- OpenShift v3
    - **ocp4** -- OpenShift v4
- `cluster_name` -- The existing cluster's name

**Note**: The values for `resource_group_name` and `cluster_name` can be found on the Resource List
page in the IBM Cloud Console - https://cloud.ibm.com/resources


### Apply the Terraform Schematics workspace

- Having configured the variables for the workspace you can now apply it

**Note**: If you run this approach multiple times remember to delete any pre existing cloud services that were created previously

- Navigate to the Workspace you have configured `cloud-native-toolkit`
- Click on the **Apply**

- Installing the tools into an existing cluster takes about 30 minutes. You
 can view the workspace logs to see the progress of the execution of the Schematics Terraform scripts

-   You should now have your Development Tools fully provisioned and
 configured. Enjoy!

Once the Schematics scripts have finished, you can see the resources that the scripts created in IBM Cloud:
- In the IBM Cloud console, open the [Resource List](https://cloud.ibm.com/docs/overview?topic=overview-ui#dashboardview "Managing resources in the resource list")
- On the Resource List page, filter by your Resource Group (e.g. `dev-team-one`)
- You should see these resources listed:
    - **Clusters**: 1, either Kubernetes or OpenShift
- Select the cluster and open the Kubernetes dashboard or OpenShift web console. You should see:
    - Namespaces: `tools`, `dev`, `test`, and `staging`
    - Deployments in the `tools` namespace: `developer-dashboard`, `jenkins`, etc.

To get started open the Developer Dashboard or navigate to the tools using the OpenShift Tools menu.

- To complete the setup install the Developer tools into the IBM Cloud Shell [Cloud Native - Developer Tools](/ci-cd/cloud-native-setup-tools)

### Setup Private Catalog Offering

One of the nice features of the IBM Cloud Catalog is support for private
 catalog tiles. These can contain custom Terraform definitions than can
  accelerate an SRE teams in the execution of common and repetative tasks
  . The CNCF DevOps tools installation can be configured as a private catalog
   tile. This is the recommend approach for using this asset multiple times
   . When you want to transition a default kubernetes cluster into a cluster
    used cloud native development. 
    
- First step is to run the following script to register the Catalog and the
 Offering tile.
 
 ```bash
 

```
- Once complete navigate to the new Catalog and click on the **Private** menu
 on the left
- Select the **Cloud Native Toolkit** tile
- Complete the variables     

    | **Variable**   | **Description**  | **eg. Value**  |
    |---|---|---|
    | `ibmcloud_api_key` | The API key from IBM Cloud Console that support service creation access writes  | `{guid API key from Console}`  |
    |  `resource_group_name` | The name of the resource group where the cluster is created  | `dev-team-one`  |
    |  `cluster_type`       |  The name of the IKS cluster |  `kubernetes or ocp4` |
    |  `cluster_name`       |  The name of the IKS cluster |  `dev-team-one-iks-117-vp` |
    |  `cluster_exists`     |  Does the cluster exist already | `true`  |
    |  `vpc_cluster`        | Is the cluster created in VPC  | `true`  |

- Accept the License which is **Apache 2** licnese
- Click **Install**

- This will kick off the installation of the CNCF Cloud-Native DevOps tools
 into a development cluster.

- Once complete you can now start to use the development tools in your cloud
 native project.

### Post Installation steps

- Two of the default tools that were installed **Artifactory** and **ArgoCD** require some post installation configuration.
- Complete these steps documented here for [Artifactory Configuration](https://cloudnativetoolkit.dev/admin/artifactory-setup)
- Complete these steps documented here for [ArgoCD Configuration](https://cloudnativetoolkit.dev/admin/argocd-setup)

### Possible issues

If you find that that the Terraform provisioning has failed, try deleting the workshpace and configuring it again


### Summnary






