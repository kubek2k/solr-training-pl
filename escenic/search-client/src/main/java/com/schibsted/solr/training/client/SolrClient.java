package com.schibsted.solr.training.client;

import com.sun.corba.se.impl.transport.DefaultIORToSocketInfoImpl;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.params.DefaultSolrParams;

public class SolrClient {
    private SolrServer solrServer = new HttpSolrServer("http://localhost:8011/solr/miasta");

    public void queryServer() throws SolrServerException {
        SolrQuery params = new SolrQuery();
        params.setQuery("name:a*");
        params.setRows(10);
        QueryResponse result = solrServer.query(params);
        System.out.println(result);
    }

    public static void main(String[] args) throws SolrServerException {
        new SolrClient().queryServer();
    }
}
