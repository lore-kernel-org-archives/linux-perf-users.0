From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/57] perf test: Avoid infinite loop for task exit case
Date: Mon, 21 Oct 2019 10:37:42 -0300
Message-ID: <20191021133834.25998-6-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

When executing the task exit testing case, perf gets stuck in an endless
loop this case and doesn't return back on Arm64 Juno board.

After digging into this issue, since Juno board has Arm's big.LITTLE
CPUs, thus the PMUs are not compatible between the big CPUs and little
CPUs.  This leads to a PMU event that cannot be enabled properly when
the traced task is migrated from one variant's CPU to another variant.
Finally, the test case runs into infinite loop for cannot read out any
event data after return from polling.

Eventually, we need to work out formal solution to allow PMU events can
be freely migrated from one CPU variant to another, but this is a
difficult task and a different topic.  This patch tries to fix the Perf
test case to avoid infinite loop, when the testing detects 1000 times
retrying for reading empty events, it will directly bail out and return
failure.  This allows the Perf tool can continue its other test cases.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191011091942.29841-2-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/task-exit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 19fa7cb429fd..adaff9044331 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -54,6 +54,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
 	struct mmap *md;
+	int retry_count = 0;
 
 	signal(SIGCHLD, sig_handler);
 
@@ -133,6 +134,13 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 out_init:
 	if (!exited || !nr_exit) {
 		evlist__poll(evlist, -1);
+
+		if (retry_count++ > 1000) {
+			pr_debug("Failed after retrying 1000 times\n");
+			err = -1;
+			goto out_free_maps;
+		}
+
 		goto retry;
 	}
 
-- 
2.21.0
