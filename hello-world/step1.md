`kubectl patch deployment -n kube-system katacoda-cloud-provider --type json --patch '[	{		"op" : "replace" ,		"path" : "/spec/template/spec/containers/0/env/2/value" ,		"value" : "bla"	}]'`{{execute}}

`kubectl apply -f cloudprov.yaml`{{execute}}

`export MY_IP=[[HOST_IP]]`{{execute}}


Render port: https://[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/
