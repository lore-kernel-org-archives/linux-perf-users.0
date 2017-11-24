From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/11] perf test: Fix test 21 for s390x
Date: Fri, 24 Nov 2017 12:02:25 -0300
Message-ID: <20171124150232.18676-5-acme@kernel.org>
References: <20171124150232.18676-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753528AbdKXPCs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Nov 2017 10:02:48 -0500
In-Reply-To: <20171124150232.18676-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Test case 21 (Number of exit events of a simple workload) fails on
s390x. The reason is the invalid sample frequency supplied for this
test. On s390x the minimum sample frequency is much higher (see output
of /proc/service_levels).

Supply a save sample frequency value for s390x to fix this.  The value
will be adjusted by the s390x CPUMF frequency convertion function to a
value well below the sysctl kernel.perf_event_max_sample_rate value.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
LPU-Reference: 20171123114611.93397-1-tmricht@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-1ynblyhi1n81idpido59nt1y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/task-exit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 98c098475e71..5d06ac81f7f1 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -84,7 +84,11 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 	evsel = perf_evlist__first(evlist);
 	evsel->attr.task = 1;
+#ifdef __s390x__
+	evsel->attr.sample_freq = 1000000;
+#else
 	evsel->attr.sample_freq = 1;
+#endif
 	evsel->attr.inherit = 0;
 	evsel->attr.watermark = 0;
 	evsel->attr.wakeup_events = 1;
-- 
2.13.6
