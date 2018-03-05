From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/28] perf test: Switch to new perf_mmap__read_event() interface for task-exit
Date: Mon,  5 Mar 2018 11:29:31 -0300
Message-ID: <20180305142932.16921-28-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'task-exit' still use the legacy interface.

No functional change.

Committer notes:

Testing it:

  # perf test exit
  21: Number of exit events of a simple workload            : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-13-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/task-exit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 01b62b81751b..02b0888b72a3 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -47,6 +47,8 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	char sbuf[STRERR_BUFSIZE];
 	struct cpu_map *cpus;
 	struct thread_map *threads;
+	struct perf_mmap *md;
+	u64 end, start;
 
 	signal(SIGCHLD, sig_handler);
 
@@ -110,13 +112,19 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	perf_evlist__start_workload(evlist);
 
 retry:
-	while ((event = perf_evlist__mmap_read(evlist, 0)) != NULL) {
+	md = &evlist->mmap[0];
+	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		goto out_init;
+
+	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 		if (event->header.type == PERF_RECORD_EXIT)
 			nr_exit++;
 
-		perf_evlist__mmap_consume(evlist, 0);
+		perf_mmap__consume(md, false);
 	}
+	perf_mmap__read_done(md);
 
+out_init:
 	if (!exited || !nr_exit) {
 		perf_evlist__poll(evlist, -1);
 		goto retry;
-- 
2.14.3
