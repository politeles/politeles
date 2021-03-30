# Stop start sap ECC:
For instance number 10:

```bash

stopsap 

sapcontrol -nr 10 -function StopService

cleanipc 10 remove
```

# Stop start securex cluster SEP 

SEP/SJP
 
Note: before stopping any database you need to send an email to euhreka.products@northgatearinso.com to inform of the maintenance.
 
## STOP:

```bash 

stopsap - v scxecpa1 (sepadm)                           => stop the SAP Application Server on scxsrv03
ClusterService RDN group_CI_java_SJP               => command to stop Resource Group JAVA CI
crmadmin -S $(crmadmin -D | awk '{print $4}')       => check the state is S_IDLE, if not re-execute this command until the state returns to S_IDLE
ClusterService CSS                                            => check the status of the Resource Group, it should be stopped
ClusterService RDN master_SCS_java_SJP
crmadmin -S $(crmadmin -D | awk '{print $4}')
ClusterService CSS
ClusterService RDN group_CI_abap_SEP                       => this never works, we have to stop the resource manually
crmadmin -S $(crmadmin -D | awk '{print $4}')
ClusterService CSS
ClusterService RDN master_ASCS_abap_SEP
crmadmin -S $(crmadmin -D | awk '{print $4}')
ClusterService CSS
ClusterService RDN group_DB_oracle_SEP
crmadmin -S $(crmadmin -D | awk '{print $4}')
ClusterService CSS
```


## START:

```bash

ClusterService RUP group_DB_oracle_SEP          => command to start Resource Group DB SEP
crmadmin -S $(crmadmin -D | awk '{print $4}')        => check the state is S_IDLE, if not re-execute this command until the state returns to S_IDLE
ClusterService CSS                                            => check the status of the Resource Group, it should be started
ClusterService RUP master_ASCS_abap_SEP
crmadmin -S $(crmadmin -D | awk '{print $4}')
ClusterService CSS
ClusterService RUP group_CI_abap_SEP                 => this never works, we have to start each resource by hand.
crmadmin -S $(crmadmin -D | awk '{print $4}')
ClusterService CSS
ClusterService RUP master_SCS_java_SJP
crmadmin -S $(crmadmin -D | awk '{print $4}')
ClusterService CSS
ClusterService RUP group_CI_java_SJP
crmadmin -S $(crmadmin -D | awk '{print $4}')
ClusterService CSS
startsap -v scxecpa1 (sepadm)           

```

## Stop abap manually
To stop resource Resource Group: group_CI_abap_SEP we have to stop the following services:
````bash

22 )res_CI_abap_SEP
21 )res_IP_virtual_host_scxecpca
20 )res_SFEX_abap_SEP

```

To start them, we have to start the other way around:

```bash

20 )res_SFEX_abap_SEP
21 )res_IP_virtual_host_scxecpca
22 )res_CI_abap_SEP

```
Log for startup:

```bash
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_IDLE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP

Please choose (or press enter for status update) : rup

Please select the resource type

 RG | 1 )Resource Group
 SR | 2 )Single Resource
 CS | 3 )Clone Set

Please select: 2

Please select a resource

 1 )res_STONITH_of_scxsrv01a_over_ipmi_by_scxsrv01b
 2 )res_STONITH_of_scxsrv01b_over_ipmi_by_scxsrv01a
 3 )res_SFEX_oracle_SEP
 4 )res_NFSFS_oracle_SEP
 5 )res_NFSFS_oracle_SEP_origlog
 6 )res_NFSFS_oracle_SEP_sapdata1
 7 )res_NFSFS_oracle_SEP_mirrlog
 8 )res_NFSFS_oracle_SEP_sapdata2
 9 )res_NFSFS_oracle_SEP_oraarch
 10 )res_IP_virtual_host_scxecpdb
 11 )res_DB_oracle_SEP_instance
 12 )res_IP_virtual_host_scxecpas
 13 )Master/Slave
 14 )res_ASCS_abap_SEP:0
 15 )res_ASCS_abap_SEP:1
 16 )res_IP_virtual_host_scxecpjs
 17 )Master/Slave
 18 )res_SCS_java_SJP:0
 19 )res_SCS_java_SJP:1
 20 )res_SFEX_abap_SEP
 21 )res_IP_virtual_host_scxecpca
 22 )res_CI_abap_SEP
 23 )res_SFEX_java_SJP
 24 )res_IP_virtual_host_scxecpcj
 25 )res_CI_java_SJP
 26 )res_SFEX_oracle_SXP
 27 )res_NFSFS_oracle_SXP
 28 )res_NFSFS_oracle_SXP_origlog
 29 )res_NFSFS_oracle_SXP_mirrlog
 30 )res_NFSFS_oracle_SXP_oraarch
 31 )res_NFSFS_oracle_SXP_sapdata1
 32 )res_NFSFS_oracle_SXP_sapdata2
 33 )res_IP_virtual_host_scxxipdb
 34 )res_DB_oracle_SXP_instance
 35 )res_IP_virtual_host_scxxipas
 36 )Master/Slave
 37 )res_ASCS_abap_SXP:0
 38 )res_ASCS_abap_SXP:1
 39 )res_IP_virtual_host_scxxipjs
 40 )Master/Slave
 41 )res_SCS_java_SXP:0
 42 )res_SCS_java_SXP:1
 43 )res_SFEX_abap_SXP
 44 )res_IP_virtual_host_scxxipca
 45 )res_CI_abap_SXP

 0 )exit

Please select: 20
-> Setting target role of resource res_SFEX_abap_SEP: target_role="started"
 
Command executed. Please press <enter>
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_TRANSITION_ENGINE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP


Please choose (or press enter for status update) : 
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_IDLE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP

Please choose (or press enter for status update) : css


============
Last updated: Fri Oct  9 23:22:18 2015
Current DC: scxsrv01b (a4b45465-b10f-4f33-9bdd-7b84c48fa3a6)
2 Nodes configured.
15 Resources configured.
============

Node: scxsrv01a (796832b4-43b7-4b82-85f4-2cd7ca93c658): online
Node: scxsrv01b (a4b45465-b10f-4f33-9bdd-7b84c48fa3a6): online

Full list of resources:

res_STONITH_of_scxsrv01a_over_ipmi_by_scxsrv01b(stonith:external/ipmi):Started scxsrv01b
res_STONITH_of_scxsrv01b_over_ipmi_by_scxsrv01a(stonith:external/ipmi):Started scxsrv01a
Resource Group: group_DB_oracle_SEP
    res_SFEX_oracle_SEP(ocf::heartbeat:sfex):Started scxsrv01a
    res_NFSFS_oracle_SEP(ocf::heartbeat:Filesystem):Started scxsrv01a
    res_NFSFS_oracle_SEP_origlog(ocf::heartbeat:Filesystem):Started scxsrv01a
    res_NFSFS_oracle_SEP_sapdata1(ocf::heartbeat:Filesystem):Started scxsrv01a
    res_NFSFS_oracle_SEP_mirrlog(ocf::heartbeat:Filesystem):Started scxsrv01a
    res_NFSFS_oracle_SEP_sapdata2(ocf::heartbeat:Filesystem):Started scxsrv01a
    res_NFSFS_oracle_SEP_oraarch(ocf::heartbeat:Filesystem):Started scxsrv01a
    res_IP_virtual_host_scxecpdb(ocf::heartbeat:IPaddr2):Started scxsrv01a
    res_DB_oracle_SEP_instance(ocf::heartbeat:SAPDatabase):Started scxsrv01a
res_IP_virtual_host_scxecpas(ocf::heartbeat:IPaddr2):Started scxsrv01b
Master/Slave Set: master_ASCS_abap_SEP
    res_ASCS_abap_SEP:0(ocf::heartbeat:SAPInstance):Master scxsrv01b
    res_ASCS_abap_SEP:1(ocf::heartbeat:SAPInstance):Started scxsrv01a
res_IP_virtual_host_scxecpjs(ocf::heartbeat:IPaddr2):Stopped 
Master/Slave Set: master_SCS_java_SJP
    res_SCS_java_SJP:0(ocf::heartbeat:SAPInstance):Stopped 
    res_SCS_java_SJP:1(ocf::heartbeat:SAPInstance):Stopped 
Resource Group: group_CI_abap_SEP
    res_SFEX_abap_SEP(ocf::heartbeat:sfex):Started scxsrv01b
    res_IP_virtual_host_scxecpca(ocf::heartbeat:IPaddr2):Stopped 
    res_CI_abap_SEP(ocf::heartbeat:SAPInstance):Stopped 
Resource Group: group_CI_java_SJP
    res_SFEX_java_SJP(ocf::heartbeat:sfex):Stopped 
    res_IP_virtual_host_scxecpcj(ocf::heartbeat:IPaddr2):Stopped 
    res_CI_java_SJP(ocf::heartbeat:SAPInstance):Stopped 
Resource Group: group_DB_oracle_SXP
    res_SFEX_oracle_SXP(ocf::heartbeat:sfex):Started scxsrv01b
    res_NFSFS_oracle_SXP(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_origlog(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_mirrlog(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_oraarch(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_sapdata1(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_sapdata2(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_IP_virtual_host_scxxipdb(ocf::heartbeat:IPaddr2):Started scxsrv01b
    res_DB_oracle_SXP_instance(ocf::heartbeat:SAPDatabase):Started scxsrv01b
res_IP_virtual_host_scxxipas(ocf::heartbeat:IPaddr2):Started scxsrv01a
Master/Slave Set: master_ASCS_abap_SXP
    res_ASCS_abap_SXP:0(ocf::heartbeat:SAPInstance):Master scxsrv01a
    res_ASCS_abap_SXP:1(ocf::heartbeat:SAPInstance):Started scxsrv01b
res_IP_virtual_host_scxxipjs(ocf::heartbeat:IPaddr2):Started scxsrv01a
Master/Slave Set: master_SCS_java_SXP
    res_SCS_java_SXP:0(ocf::heartbeat:SAPInstance):Master scxsrv01a
    res_SCS_java_SXP:1(ocf::heartbeat:SAPInstance):Started scxsrv01b
Resource Group: group_CI_abap_SXP
    res_SFEX_abap_SXP(ocf::heartbeat:sfex):Started scxsrv01a
    res_IP_virtual_host_scxxipca(ocf::heartbeat:IPaddr2):Started scxsrv01a
    res_CI_abap_SXP(ocf::heartbeat:SAPInstance):Started scxsrv01a
 
Command executed. Please press <enter>rup   
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_IDLE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP

Please choose (or press enter for status update) : rup

Please select the resource type

 RG | 1 )Resource Group
 SR | 2 )Single Resource
 CS | 3 )Clone Set

Please select: 2

Please select a resource

 1 )res_STONITH_of_scxsrv01a_over_ipmi_by_scxsrv01b
 2 )res_STONITH_of_scxsrv01b_over_ipmi_by_scxsrv01a
 3 )res_SFEX_oracle_SEP
 4 )res_NFSFS_oracle_SEP
 5 )res_NFSFS_oracle_SEP_origlog
 6 )res_NFSFS_oracle_SEP_sapdata1
 7 )res_NFSFS_oracle_SEP_mirrlog
 8 )res_NFSFS_oracle_SEP_sapdata2
 9 )res_NFSFS_oracle_SEP_oraarch
 10 )res_IP_virtual_host_scxecpdb
 11 )res_DB_oracle_SEP_instance
 12 )res_IP_virtual_host_scxecpas
 13 )Master/Slave
 14 )res_ASCS_abap_SEP:0
 15 )res_ASCS_abap_SEP:1
 16 )res_IP_virtual_host_scxecpjs
 17 )Master/Slave
 18 )res_SCS_java_SJP:0
 19 )res_SCS_java_SJP:1
 20 )res_SFEX_abap_SEP
 21 )res_IP_virtual_host_scxecpca
 22 )res_CI_abap_SEP
 23 )res_SFEX_java_SJP
 24 )res_IP_virtual_host_scxecpcj
 25 )res_CI_java_SJP
 26 )res_SFEX_oracle_SXP
 27 )res_NFSFS_oracle_SXP
 28 )res_NFSFS_oracle_SXP_origlog
 29 )res_NFSFS_oracle_SXP_mirrlog
 30 )res_NFSFS_oracle_SXP_oraarch
 31 )res_NFSFS_oracle_SXP_sapdata1
 32 )res_NFSFS_oracle_SXP_sapdata2
 33 )res_IP_virtual_host_scxxipdb
 34 )res_DB_oracle_SXP_instance
 35 )res_IP_virtual_host_scxxipas
 36 )Master/Slave
 37 )res_ASCS_abap_SXP:0
 38 )res_ASCS_abap_SXP:1
 39 )res_IP_virtual_host_scxxipjs
 40 )Master/Slave
 41 )res_SCS_java_SXP:0
 42 )res_SCS_java_SXP:1
 43 )res_SFEX_abap_SXP
 44 )res_IP_virtual_host_scxxipca
 45 )res_CI_abap_SXP

 0 )exit

Please select: 21
-> Setting target role of resource res_IP_virtual_host_scxecpca: target_role="started"
 
Command executed. Please press <enter>
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_TRANSITION_ENGINE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP

Please choose (or press enter for status update) : 
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_IDLE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP

Please choose (or press enter for status update) : rup

Please select the resource type

 RG | 1 )Resource Group
 SR | 2 )Single Resource
 CS | 3 )Clone Set

Please select: 2

Please select a resource

 1 )res_STONITH_of_scxsrv01a_over_ipmi_by_scxsrv01b
 2 )res_STONITH_of_scxsrv01b_over_ipmi_by_scxsrv01a
 3 )res_SFEX_oracle_SEP
 4 )res_NFSFS_oracle_SEP
 5 )res_NFSFS_oracle_SEP_origlog
 6 )res_NFSFS_oracle_SEP_sapdata1
 7 )res_NFSFS_oracle_SEP_mirrlog
 8 )res_NFSFS_oracle_SEP_sapdata2
 9 )res_NFSFS_oracle_SEP_oraarch
 10 )res_IP_virtual_host_scxecpdb
 11 )res_DB_oracle_SEP_instance
 12 )res_IP_virtual_host_scxecpas
 13 )Master/Slave
 14 )res_ASCS_abap_SEP:0
 15 )res_ASCS_abap_SEP:1
 16 )res_IP_virtual_host_scxecpjs
 17 )Master/Slave
 18 )res_SCS_java_SJP:0
 19 )res_SCS_java_SJP:1
 20 )res_SFEX_abap_SEP
 21 )res_IP_virtual_host_scxecpca
 22 )res_CI_abap_SEP
 23 )res_SFEX_java_SJP
 24 )res_IP_virtual_host_scxecpcj
 25 )res_CI_java_SJP
 26 )res_SFEX_oracle_SXP
 27 )res_NFSFS_oracle_SXP
 28 )res_NFSFS_oracle_SXP_origlog
 29 )res_NFSFS_oracle_SXP_mirrlog
 30 )res_NFSFS_oracle_SXP_oraarch
 31 )res_NFSFS_oracle_SXP_sapdata1
 32 )res_NFSFS_oracle_SXP_sapdata2
 33 )res_IP_virtual_host_scxxipdb
 34 )res_DB_oracle_SXP_instance
 35 )res_IP_virtual_host_scxxipas
 36 )Master/Slave
 37 )res_ASCS_abap_SXP:0
 38 )res_ASCS_abap_SXP:1
 39 )res_IP_virtual_host_scxxipjs
 40 )Master/Slave
 41 )res_SCS_java_SXP:0
 42 )res_SCS_java_SXP:1
 43 )res_SFEX_abap_SXP
 44 )res_IP_virtual_host_scxxipca
 45 )res_CI_abap_SXP

 0 )exit

Please select: 22


```

## Troubleshooinng of database:

```bash

hacadm@scxsrv01a:~> Clusterservice
hacadm@scxsrv01a:~> ClusterserviceService
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_IDLE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP

Please choose (or press enter for status update) : css


============
Last updated: Fri Oct  9 23:11:26 2015
Current DC: scxsrv01b (a4b45465-b10f-4f33-9bdd-7b84c48fa3a6)
2 Nodes configured.
15 Resources configured.
============

Node: scxsrv01a (796832b4-43b7-4b82-85f4-2cd7ca93c658): online
Node: scxsrv01b (a4b45465-b10f-4f33-9bdd-7b84c48fa3a6): online

Full list of resources:

res_STONITH_of_scxsrv01a_over_ipmi_by_scxsrv01b(stonith:external/ipmi):Started scxsrv01b
res_STONITH_of_scxsrv01b_over_ipmi_by_scxsrv01a(stonith:external/ipmi):Started scxsrv01a
Resource Group: group_DB_oracle_SEP
    res_SFEX_oracle_SEP(ocf::heartbeat:sfex):Stopped 
    res_NFSFS_oracle_SEP(ocf::heartbeat:Filesystem):Stopped 
    res_NFSFS_oracle_SEP_origlog(ocf::heartbeat:Filesystem):Stopped 
    res_NFSFS_oracle_SEP_sapdata1(ocf::heartbeat:Filesystem):Stopped 
    res_NFSFS_oracle_SEP_mirrlog(ocf::heartbeat:Filesystem):Stopped 
    res_NFSFS_oracle_SEP_sapdata2(ocf::heartbeat:Filesystem):Stopped 
    res_NFSFS_oracle_SEP_oraarch(ocf::heartbeat:Filesystem):Stopped 
    res_IP_virtual_host_scxecpdb(ocf::heartbeat:IPaddr2):Stopped 
    res_DB_oracle_SEP_instance(ocf::heartbeat:SAPDatabase):Stopped 
res_IP_virtual_host_scxecpas(ocf::heartbeat:IPaddr2):Stopped 
Master/Slave Set: master_ASCS_abap_SEP
    res_ASCS_abap_SEP:0(ocf::heartbeat:SAPInstance):Stopped 
    res_ASCS_abap_SEP:1(ocf::heartbeat:SAPInstance):Stopped 
res_IP_virtual_host_scxecpjs(ocf::heartbeat:IPaddr2):Stopped 
Master/Slave Set: master_SCS_java_SJP
    res_SCS_java_SJP:0(ocf::heartbeat:SAPInstance):Stopped 
    res_SCS_java_SJP:1(ocf::heartbeat:SAPInstance):Stopped 
Resource Group: group_CI_abap_SEP
    res_SFEX_abap_SEP(ocf::heartbeat:sfex):Stopped 
    res_IP_virtual_host_scxecpca(ocf::heartbeat:IPaddr2):Stopped 
    res_CI_abap_SEP(ocf::heartbeat:SAPInstance):Stopped 
Resource Group: group_CI_java_SJP
    res_SFEX_java_SJP(ocf::heartbeat:sfex):Stopped 
    res_IP_virtual_host_scxecpcj(ocf::heartbeat:IPaddr2):Stopped 
    res_CI_java_SJP(ocf::heartbeat:SAPInstance):Stopped 
Resource Group: group_DB_oracle_SXP
    res_SFEX_oracle_SXP(ocf::heartbeat:sfex):Started scxsrv01b
    res_NFSFS_oracle_SXP(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_origlog(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_mirrlog(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_oraarch(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_sapdata1(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_NFSFS_oracle_SXP_sapdata2(ocf::heartbeat:Filesystem):Started scxsrv01b
    res_IP_virtual_host_scxxipdb(ocf::heartbeat:IPaddr2):Started scxsrv01b
    res_DB_oracle_SXP_instance(ocf::heartbeat:SAPDatabase):Started scxsrv01b
res_IP_virtual_host_scxxipas(ocf::heartbeat:IPaddr2):Started scxsrv01a
Master/Slave Set: master_ASCS_abap_SXP
    res_ASCS_abap_SXP:0(ocf::heartbeat:SAPInstance):Master scxsrv01a
    res_ASCS_abap_SXP:1(ocf::heartbeat:SAPInstance):Started scxsrv01b
res_IP_virtual_host_scxxipjs(ocf::heartbeat:IPaddr2):Started scxsrv01a
Master/Slave Set: master_SCS_java_SXP
    res_SCS_java_SXP:0(ocf::heartbeat:SAPInstance):Master scxsrv01a
    res_SCS_java_SXP:1(ocf::heartbeat:SAPInstance):Started scxsrv01b
Resource Group: group_CI_abap_SXP
    res_SFEX_abap_SXP(ocf::heartbeat:sfex):Started scxsrv01a
    res_IP_virtual_host_scxxipca(ocf::heartbeat:IPaddr2):Started scxsrv01a
    res_CI_abap_SXP(ocf::heartbeat:SAPInstance):Started scxsrv01a
 
Command executed. Please press <enter>
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_IDLE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP

Please choose (or press enter for status update) : rup

Please select the resource type

 RG | 1 )Resource Group
 SR | 2 )Single Resource
 CS | 3 )Clone Set

Please select: 2

Please select a resource

 1 )res_STONITH_of_scxsrv01a_over_ipmi_by_scxsrv01b
 2 )res_STONITH_of_scxsrv01b_over_ipmi_by_scxsrv01a
 3 )res_SFEX_oracle_SEP
 4 )res_NFSFS_oracle_SEP
 5 )res_NFSFS_oracle_SEP_origlog
 6 )res_NFSFS_oracle_SEP_sapdata1
 7 )res_NFSFS_oracle_SEP_mirrlog
 8 )res_NFSFS_oracle_SEP_sapdata2
 9 )res_NFSFS_oracle_SEP_oraarch
 10 )res_IP_virtual_host_scxecpdb
 11 )res_DB_oracle_SEP_instance
 12 )res_IP_virtual_host_scxecpas
 13 )Master/Slave
 14 )res_ASCS_abap_SEP:0
 15 )res_ASCS_abap_SEP:1
 16 )res_IP_virtual_host_scxecpjs
 17 )Master/Slave
 18 )res_SCS_java_SJP:0
 19 )res_SCS_java_SJP:1
 20 )res_SFEX_abap_SEP
 21 )res_IP_virtual_host_scxecpca
 22 )res_CI_abap_SEP
 23 )res_SFEX_java_SJP
 24 )res_IP_virtual_host_scxecpcj
 25 )res_CI_java_SJP
 26 )res_SFEX_oracle_SXP
 27 )res_NFSFS_oracle_SXP
 28 )res_NFSFS_oracle_SXP_origlog
 29 )res_NFSFS_oracle_SXP_mirrlog
 30 )res_NFSFS_oracle_SXP_oraarch
 31 )res_NFSFS_oracle_SXP_sapdata1
 32 )res_NFSFS_oracle_SXP_sapdata2
 33 )res_IP_virtual_host_scxxipdb
 34 )res_DB_oracle_SXP_instance
 35 )res_IP_virtual_host_scxxipas
 36 )Master/Slave
 37 )res_ASCS_abap_SXP:0
 38 )res_ASCS_abap_SXP:1
 39 )res_IP_virtual_host_scxxipjs
 40 )Master/Slave
 41 )res_SCS_java_SXP:0
 42 )res_SCS_java_SXP:1
 43 )res_SFEX_abap_SXP
 44 )res_IP_virtual_host_scxxipca
 45 )res_CI_abap_SXP

 0 )exit

Please select: 3
-> Setting target role of resource res_SFEX_oracle_SEP: target_role="started"
 
Command executed. Please press <enter>
 Maintain cluster services on SAP Cluster
 ----------------------------------------

 Ressource Start / Stop

 RDN  )Stop a Resource / Clone / Group
 RUP  )Start a Resource / Clone / Group

 Ressource Migration

 RMI  )Migrate a Resource / Clone / Group
 RUM  )Delete Migration rules

 Cluster Maintenance

 NSS  )Set node to standby
 NSA  )Set node to active

 RSU  )Set a Resource / Clone / Group to unmanaged
 RSM  )Set a Resoruce / Clone / Group to managed

 RCN  )Cleanup resource

 RSF  )Show resource failcounts
 RSS  )     Resource show scores
 RRF  )Reset resource failcounts

 RCF  )Reset status / failcounts for all failed resources

 Cluster Monitoring

 CSS  )Show resource status (crm_mon)
 CSF  )Show detailed cluster failure status (clusterstate)
 CSH  )Show detailed cluster action history (clusterstate)
 CSL  )Show detailed heartbeat link status  (linkstate)

 EXIT )Exit program


Cluster transition status (crm): S_TRANSITION_ENGINE
Cluster failure status: GREEN
Heartbeat link status: ALL HEARTBEAT LINKS UP

Please choose (or press enter for status update) :+1: 

```
