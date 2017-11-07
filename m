From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf buildid-cache: update help text for purge command
Date: Tue,  7 Nov 2017 15:48:53 +0100
Message-ID: <20171107144853.12925-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933147AbdKGOtJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Nov 2017 09:49:09 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA7Elp3U018168
        for <linux-perf-users@vger.kernel.org>; Tue, 7 Nov 2017 09:49:08 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e3bv2kxdj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Nov 2017 09:49:07 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 7 Nov 2017 14:49:04 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, mhiramat@kernel.org, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, tmricht <tmricht@linux.vnet.ibm.com>

From: tmricht <tmricht@linux.vnet.ibm.com>

Clarify the perf buildid-cache help text for the purge operation.
The purge subcommand takes a list of files (binaries) as
option parameter. Make the wording the same as for the add
and remove operation.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/builtin-buildid-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 9eba7f1add1f..ee4fdb458e26 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -307,8 +307,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		   "file", "kcore file to add"),
 	OPT_STRING('r', "remove", &remove_name_list_str, "file list",
 		    "file(s) to remove"),
-	OPT_STRING('p', "purge", &purge_name_list_str, "path list",
-		    "path(s) to remove (remove old caches too)"),
+	OPT_STRING('p', "purge", &purge_name_list_str, "file list",
+		    "file(s) to remove (remove old caches too)"),
 	OPT_STRING('M', "missing", &missing_filename, "file",
 		   "to find missing build ids in the cache"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
-- 
2.13.4
