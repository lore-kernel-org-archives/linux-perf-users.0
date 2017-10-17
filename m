From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCHv2] perf buildid-cache: option -p does not delete anything
Date: Tue, 17 Oct 2017 09:33:32 +0200
Message-ID: <20171017073332.96122-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752529AbdJQHdj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Oct 2017 03:33:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9H7XVlT134072
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2017 03:33:39 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dn67y8xrk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2017 03:33:39 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 17 Oct 2017 08:33:37 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Command perf buildid-cache -p <path> should delete all entries
in the buildid cache which start with path.  However this does not happen.

When perf buildid-cache -p /usr/bin is invoked, tracing shows in detail
function
build_id_cache__purge_path() is called and
build_id_cache__list_build_ids() creates a list of file names
	located in directory /usr/bin of the buildid-cache.
build_id_cache__remove_s() is called for each name in the list
	and tries to locate each file name
	in directory .buildid/YY/ZZZ..ZZZ which fails because
build_id_cache__linkname() expects a buildid and gets a file name.
The file name bash is treated as .buildid/ba/sh which does not exist.

Fix this by walking along the specified path and test for the
object type. If it is a directory, scan this subdirectory.
If this is a file, convert the file name to a buildid and
call function build_id_cache__remove_file().

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/builtin-buildid-cache.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index e3eb624..bcd2b0e 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -8,6 +8,7 @@
  */
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/stat.h>
 #include <time.h>
 #include <dirent.h>
 #include <errno.h>
@@ -197,6 +198,7 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 
 	int err;
 
 	nsinfo__mountns_enter(nsi, &nsc);
 	err = filename__read_build_id(filename, &build_id, sizeof(build_id));
 	nsinfo__mountns_exit(&nsc);
@@ -224,8 +226,18 @@ static int build_id_cache__purge_path(const char *pathname, struct nsinfo *nsi)
 		goto out;
 
 	strlist__for_each_entry(pos, list) {
-		err = build_id_cache__remove_s(pos->s);
-		pr_debug("Removing %s %s: %s\n", pos->s, pathname,
+		char filename[PATH_MAX];
+		struct stat st;
+
+		scnprintf(filename, sizeof(filename), "%s/%s",
+			  pathname, pos->s);
+		if (stat(filename, &st))
+			continue;
+		if (S_ISDIR(st.st_mode))
+			err = build_id_cache__purge_path(filename, nsi);
+		else
+			err = build_id_cache__remove_file(filename, nsi);
+		pr_debug("Removing %s %s: %s\n", filename, pathname,
 			 err ? "FAIL" : "Ok");
 		if (err)
 			break;
-- 
2.9.4
