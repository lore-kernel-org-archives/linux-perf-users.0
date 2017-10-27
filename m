From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf buildid-cache: update help text for purge command
Date: Fri, 27 Oct 2017 13:01:26 +0200
Message-ID: <20171027110126.72520-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752161AbdJ0LBv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 Oct 2017 07:01:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9RB1UWS084823
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2017 07:01:50 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2duvcf5310-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2017 07:01:50 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 27 Oct 2017 12:01:46 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-perf-users@vger.kernel.org, mhiramat@kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Clarify the perf buildid-cache help text for the purge operation.
The purge subcommand takes a list of files (binaries) as
option parameter. Make the wording the same as for the add
and remove operation.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/builtin-buildid-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index bcd2b0e..04164d5 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -336,8 +336,8 @@ int cmd_buildid_cache(int argc, const char **argv)
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
2.9.4
