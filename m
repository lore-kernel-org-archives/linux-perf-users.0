From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v3 13/13] perf util: enable handling of inlined frames by default
Date: Wed,  6 Sep 2017 15:55:01 +0200
Message-ID: <20170906135501.306-14-milian.wolff@kdab.com>
References: <20170906135501.306-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:37836 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932239AbdIFNzl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2017 09:55:41 -0400
In-Reply-To: <20170906135501.306-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@kernel.org>

Now that we have caches in place to speed up the process of finding
inlined frames and srcline information repeatedly, we can enable
this useful option by default.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/Documentation/perf-report.txt | 3 ++-
 tools/perf/Documentation/perf-script.txt | 3 ++-
 tools/perf/util/symbol.c                 | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 383a98d992ed..ddde2b54af57 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -434,7 +434,8 @@ include::itrace.txt[]
 
 --inline::
 	If a callgraph address belongs to an inlined function, the inline stack
-	will be printed. Each entry is function name or file/line.
+	will be printed. Each entry is function name or file/line. Enabled by
+	default, disable with --no-inline.
 
 include::callchain-overhead-calculation.txt[]
 
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 18dfcfa38454..1a80a2cc850d 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -327,7 +327,8 @@ include::itrace.txt[]
 
 --inline::
 	If a callgraph address belongs to an inlined function, the inline stack
-	will be printed. Each entry has function name and file/line.
+	will be printed. Each entry has function name and file/line. Enabled by
+	default, disable with --no-inline.
 
 SEE ALSO
 --------
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5909ee4c7ade..77872e9f5b9f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -45,6 +45,7 @@ struct symbol_conf symbol_conf = {
 	.show_hist_headers	= true,
 	.symfs			= "",
 	.event_group		= true,
+	.inline_name		= true,
 };
 
 static enum dso_binary_type binary_type_symtab[] = {
-- 
2.14.1
