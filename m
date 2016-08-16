From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf inject: Remove empty event categories from sched-stat result
Date: Tue, 16 Aug 2016 13:27:03 +0200
Message-ID: <20160816112703.17964-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:47038 "EHLO mail.kdab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbcHPL1r (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Aug 2016 07:27:47 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Milian Wolff <milian.wolff@kdab.com>

Previously, the empty sched_stat_* and sched_process_exit events
where kept in the resulting data file created by perf inject, which
is quite confusing for newcomers:

    perf record \
        --event sched:sched_stat_sleep/call-graph=none/ \
        --event sched:sched_process_exit/call-graph=none/ \
        --event sched:sched_switch/call-graph=dwarf/ \
        --output perf.data.raw \
        $@
    perf inject --sched-stat --input perf.data.raw --output perf.data
    perf report

        Available samples
        0 sched:sched_stat_sleep
        0 sched:sched_stat_iowait
        0 sched:sched_process_exit
        2K sched:sched_switch

In the TUI, one would then need to select the sched_switch result
to analyze the data. With this patch in place, the empty sched:sched_*
event categories are dropped from the resulting perf.data file, and
the actually interesting results are directly shown by `perf report`.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/builtin-inject.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f1d5a8d..7c31bc1 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -799,6 +799,23 @@ static int __cmd_inject(struct perf_inject *inject)
 			if (inject->strip)
 				strip_fini(inject);
 		}
+		if (inject->sched_stat) {
+			// remove the now empty sched_stat_* events
+			struct perf_evsel *evsel, *tmp;
+
+			evlist__for_each_entry_safe(session->evlist, tmp, evsel) {
+				const char *name = perf_evsel__name(evsel);
+
+				if (!strcmp(name, "sched:sched_switch")) {
+					// this contains the actually useful data
+					continue;
+				} else if (!strncmp(name, "sched:sched_", sizeof("sched:sched_") - 1)) {
+					// these events all got dropped
+					perf_evlist__remove(session->evlist, evsel);
+					perf_evsel__delete(evsel);
+				}
+			}
+		}
 		if (inject->trace) {
 			// remove the now empty sys_exit event list
 			struct perf_evsel *evsel, *tmp;
-- 
2.9.3
