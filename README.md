# Opentlc GCP Open project
These tf playbooks enable APIs in GCP and setup a DNS zone for an ACM GCP Openshift install. 

I used freenom.com to register the DNS name ( ocpacm.tk ) and pointed the namesevers to googles. Note that everytime you build out DNS in google the nameservers can change so make sure you update them in freenom or a GCP cluster build from ACM will fail

