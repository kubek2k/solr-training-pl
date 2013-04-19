package se.aos.search.solr;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.WebAppContext;

import java.net.InetAddress;
import java.net.URL;
import java.security.ProtectionDomain;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) throws Exception {
        if (args.length < 3) {
            System.err.println(Main.class.getName() + " <solrHome> <solrWebContext> <httpPort>");
            System.exit(2);
        }

        // FIXME - this is the easiest way to pass solr home to solr webapp - couln't find
        // a better way to do it though
        String solrHome = args[0];
        System.setProperty("solr.solr.home", solrHome);

        String solrContext = args[1];
        Integer httpPort = Integer.valueOf(args[2]);

        Server server = createAServerWithSolrWebapp(solrContext, httpPort);

        server.start();

        System.out.println("You should be able to access SOLR instance under http://"
                + InetAddress.getLocalHost().getHostName() + ":" + httpPort + "/" + solrContext);

        server.join();
    }

    private static Server createAServerWithSolrWebapp(String solrContext, Integer httpPort) {
        Server server = new Server(httpPort);

        ProtectionDomain protectionDomain = Main.class.getProtectionDomain();
        URL location = protectionDomain.getCodeSource().getLocation();

        WebAppContext webAppContext = new WebAppContext();
        webAppContext.setContextPath(solrContext);
        webAppContext.setDescriptor(location.toExternalForm() + "/WEB-INF/web.xml");
        webAppContext.setServer(server);
        webAppContext.setParentLoaderPriority(true);
        webAppContext.setWar(location.toExternalForm());

        server.setHandler(webAppContext);

        server.setStopAtShutdown(true);
        return server;
    }
}
