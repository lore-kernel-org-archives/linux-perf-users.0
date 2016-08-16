From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf record: Allow to disable callchains by setting mode to "none"
Date: Tue, 16 Aug 2016 12:34:27 +0200
Message-ID: <20160816103427.5567-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:41246 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbcHPKel (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Aug 2016 06:34:41 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Milian Wolff <milian.wolff@kdab.com>

This change is mostly useful for symmetry purposes. Before, we could:

    --event foo/call-graph=fp/
    --event bar/call-graph=dwarf/
    --event asdf/call-graph=lbr/

Now, we can also use

    --event xyz/call-graph=none/

The latter is equivalent to

    --event xyz

when the `perf record` invocation does not specify a global call-graph
option. If it does, then this patch also allows us to selectively
disable the call-graph for single events.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/util.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 85c5680..a549fee 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -536,6 +536,14 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 				pr_err("callchain: No more arguments "
 					"needed for --call-graph lbr\n");
 			break;
+		} else if (!strncmp(name, "none", sizeof("none"))) {
+			if (!strtok_r(NULL, ",", &saveptr)) {
+				param->record_mode = CALLCHAIN_NONE;
+				ret = 0;
+			} else
+				pr_err("callchain: No more arguments "
+					"needed for --call-graph none\n");
+			break;
 		} else {
 			pr_err("callchain: Unknown --call-graph option "
 			       "value: %s\n", arg);
-- 
2.9.3
