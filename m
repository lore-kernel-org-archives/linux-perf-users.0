From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 81/83] perf top: Fix crash when annotating symbol
Date: Fri, 17 Nov 2017 17:15:59 -0300
Message-ID: <20171117201601.24110-82-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965630AbdKQUUj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:20:39 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Ravi reported crash in perf top --stdio when annotating a function [1].
The issue was, that we don't pass evsel pointer into symbol__annotate()
function, which got over looked in the last annotation changes.

[1] https://marc.info/?l=linux-kernel&m=151060884412702&w=2

Committer note:

This fixes the crash, but makes it stumble into another bug, double
locking the annotation data structures, that is in turn fixed by the
next patch in this series.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-6eol035redpoqvxqnuiqudtc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a29a98334f33..0077724fb24f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -99,6 +99,7 @@ static void perf_top__resize(struct perf_top *top)
 
 static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 {
+	struct perf_evsel *evsel = hists_to_evsel(he->hists);
 	struct symbol *sym;
 	struct annotation *notes;
 	struct map *map;
@@ -137,7 +138,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(sym, map, NULL, 0, NULL, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, NULL, NULL);
 	if (err == 0) {
 out_assign:
 		top->sym_filter_entry = he;
-- 
2.13.6
