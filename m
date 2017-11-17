From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/83] perf buildid-cache: Update help text for purge command
Date: Fri, 17 Nov 2017 17:15:24 -0300
Message-ID: <20171117201601.24110-47-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758709AbdKQUSs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:48 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>

Clarify the perf buildid-cache help text for the purge operation.  The
purge subcommand takes a list of files (binaries) as option parameter.
Make the wording the same as for the add and remove operation.

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
LPU-Reference: 20171107144853.12925-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-buildid-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 3d354ba6e9c5..41db2cba77eb 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -325,8 +325,8 @@ int cmd_buildid_cache(int argc, const char **argv)
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
2.13.6
