package com.schibsted.solr.training;

import neo.xredsys.api.*;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrInputDocument;

import javax.annotation.PostConstruct;
import java.util.Arrays;

public class UpdateEventHandler implements IOEventListener, IOEventFilter {

    private SolrServer solrServer = new HttpSolrServer("http://localhost:8011/solr/aos/");

    @Override
    public void handleEvent(IOEvent ioEvent) throws Exception {
        if (ioEvent.getType() == IOEvent.OBJECT_CREATED || ioEvent.getType() == IOEvent.OBJECT_MODIFIED) {
            IOObject object = ioEvent.getObject();
            if (object.getObjectType() == IOObject.OBJECTTYPE_ARTICLE) {
                Article article = (Article) object;

                SolrInputDocument solrDocument = new SolrInputDocument();
                solrDocument.setField("title", getFieldValue(article, "title"));
                solrDocument.setField("text", getFieldValue(article, "text"));

                solrServer.add(Arrays.<SolrInputDocument>asList(solrDocument));
                solrServer.commit();
            }
        }
    }

    private String getFieldValue(Article article, String fieldName) {
        return (String) article.getField(fieldName).getValue();
    }

    @Override
    public boolean acceptEvent(IOEvent ioEvent) throws Exception {
        return true;
    }

    @PostConstruct
    public void init() {
        IOAPI.getAPI().getEventManager().registerListener(this, this);
    }
}
