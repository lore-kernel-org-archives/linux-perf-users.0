From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/28] perf stat: Use xyarray dimensions to iterate fds
Date: Mon,  5 Mar 2018 11:29:06 -0300
Message-ID: <20180305142932.16921-3-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Now that the xyarray stores the dimensions we can use those
to iterate over the FDs for a evsel.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171006020029.13339-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2d49eccf98f2..fadcff52cd09 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -508,14 +508,13 @@ static int perf_stat_synthesize_config(bool is_pipe)
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 
-static int __store_counter_ids(struct perf_evsel *counter,
-			       struct cpu_map *cpus,
-			       struct thread_map *threads)
+static int __store_counter_ids(struct perf_evsel *counter)
 {
 	int cpu, thread;
 
-	for (cpu = 0; cpu < cpus->nr; cpu++) {
-		for (thread = 0; thread < threads->nr; thread++) {
+	for (cpu = 0; cpu < xyarray__max_x(counter->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(counter->fd);
+		     thread++) {
 			int fd = FD(counter, cpu, thread);
 
 			if (perf_evlist__id_add_fd(evsel_list, counter,
@@ -535,7 +534,7 @@ static int store_counter_ids(struct perf_evsel *counter)
 	if (perf_evsel__alloc_id(counter, cpus->nr, threads->nr))
 		return -ENOMEM;
 
-	return __store_counter_ids(counter, cpus, threads);
+	return __store_counter_ids(counter);
 }
 
 static bool perf_evsel__should_store_id(struct perf_evsel *counter)
-- 
2.14.3
