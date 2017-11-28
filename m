From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/30] perf test: Fix test 21 for s390x
Date: Tue, 28 Nov 2017 12:02:10 -0300
Message-ID: <20171128150220.5064-21-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

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
index bc4a7344e274..89c8e1604ca7 100644
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
