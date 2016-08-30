From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 1/2] perf report: Accept report.sort-order as synonym to report.sort_order
Date: Tue, 30 Aug 2016 15:41:05 +0200
Message-ID: <20160830134106.21240-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:52100 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbcH3NlL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Aug 2016 09:41:11 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

The other config keys use dashes but report.sort_order used to only
allow an underline which is confusing. This patch allows the
dash syntax as a synonym to the underline syntax, making the
following .perfconfig file completely valid:

    [report]
    sort-order = dso,sym,srcline

    [call-graph]
    record-mode = dwarf
    print-type = graph
    sort-key = address

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/Documentation/perf-config.txt | 1 +
 tools/perf/builtin-report.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 68c8919..c7031bc 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -382,6 +382,7 @@ call-graph.*::
 		histogram entry. Default is 0 which means no limitation.
 
 report.*::
+	report.sort-order::
 	report.sort_order::
 		Allows changing the default sort order from "comm,dso,symbol" to
 		some other default, for instance "sym,dso" may be more fitting for
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b9e046b..3842b59 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -89,7 +89,7 @@ static int report__config(const char *var, const char *value, void *cb)
 		rep->queue_size = perf_config_u64(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "report.sort_order")) {
+	if (!strcmp(var, "report.sort_order") || !strcmp(var, "report.sort-order")) {
 		default_sort_order = strdup(value);
 		return 0;
 	}
-- 
2.9.3
