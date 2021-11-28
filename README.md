# Algorand Indexer Server

Automation for setting up Algorand node, indexer, and indexer DB in a Google Cloud VM.  Can be adapted for other cloud providers or running locally with small changes.

Highlights of solution:

* The server setup is automated via [https://www.vagrantup.com](Vagrant)
* Algorand node, indexer, and DB run in Docker containers, orchestrated by docker-compose
* Algorand node data and PostgreSQL data mounted as volumes from VM

See https://medium.com/@rcodesmith/exploring-algorand-preparing-to-query-blockchain-data-bf754d6d7159 for more details.