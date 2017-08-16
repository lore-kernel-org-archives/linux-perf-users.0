From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/10] perf script python: Rename call-graph-from-postgresql.py to call-graph-from-sql.py
Date: Wed, 16 Aug 2017 17:20:47 -0300
Message-ID: <20170816202050.8865-8-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751893AbdHPUVU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Aug 2017 16:21:20 -0400
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Adrian Hunter <adrian.hunter@intel.com>

Rename call-graph-from-postgresql.py to call-graph-from-sql.py in
preparation for adding support to it for SQLite 3.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/1501749090-20357-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt                          |  2 +-
 .../{call-graph-from-postgresql.py => call-graph-from-sql.py}  | 10 +++++-----
 tools/perf/scripts/python/export-to-postgresql.py              |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)
 rename tools/perf/scripts/python/{call-graph-from-postgresql.py => call-graph-from-sql.py} (96%)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 8e8ae3ad4cbf..ab1b0825130a 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -106,7 +106,7 @@ in transaction, respectively.
 While it is possible to create scripts to analyze the data, an alternative
 approach is available to export the data to a sqlite or postgresql database.
 Refer to script export-to-sqlite.py or export-to-postgresql.py for more details,
-and to script call-graph-from-postgresql.py for an example of using the database.
+and to script call-graph-from-sql.py for an example of using the database.
 
 There is also script intel-pt-events.py which provides an example of how to
 unpack the raw data for power events and PTWRITE.
diff --git a/tools/perf/scripts/python/call-graph-from-postgresql.py b/tools/perf/scripts/python/call-graph-from-sql.py
similarity index 96%
rename from tools/perf/scripts/python/call-graph-from-postgresql.py
rename to tools/perf/scripts/python/call-graph-from-sql.py
index ed9f7f3ccf22..f18406d3faf7 100644
--- a/tools/perf/scripts/python/call-graph-from-postgresql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -1,6 +1,6 @@
 #!/usr/bin/python2
-# call-graph-from-postgresql.py: create call-graph from postgresql database
-# Copyright (c) 2014, Intel Corporation.
+# call-graph-from-sql.py: create call-graph from postgresql database
+# Copyright (c) 2014-2017, Intel Corporation.
 #
 # This program is free software; you can redistribute it and/or modify it
 # under the terms and conditions of the GNU General Public License,
@@ -17,12 +17,12 @@
 # Following on from the example in the export-to-postgresql.py script, a
 # call-graph can be displayed for the pt_example database like this:
 #
-#	python tools/perf/scripts/python/call-graph-from-postgresql.py pt_example
+#	python tools/perf/scripts/python/call-graph-from-sql.py pt_example
 #
 # Note this script supports connecting to remote databases by setting hostname,
 # port, username, password, and dbname e.g.
 #
-#	python tools/perf/scripts/python/call-graph-from-postgresql.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
+#	python tools/perf/scripts/python/call-graph-from-sql.py "hostname=myhost username=myuser password=mypassword dbname=pt_example"
 #
 # The result is a GUI window with a tree representing a context-sensitive
 # call-graph.  Expanding a couple of levels of the tree and adjusting column
@@ -291,7 +291,7 @@ class MainWindow(QMainWindow):
 
 if __name__ == '__main__':
 	if (len(sys.argv) < 2):
-		print >> sys.stderr, "Usage is: call-graph-from-postgresql.py <database name>"
+		print >> sys.stderr, "Usage is: call-graph-from-sql.py <database name>"
 		raise Exception("Too few arguments")
 
 	dbname = sys.argv[1]
diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index f57811443beb..efcaf6cac2eb 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -59,7 +59,7 @@ import datetime
 #	pt_example=# \q
 #
 # An example of using the database is provided by the script
-# call-graph-from-postgresql.py.  Refer to that script for details.
+# call-graph-from-sql.py.  Refer to that script for details.
 #
 # Tables:
 #
-- 
2.13.5
