From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 44/86] perf tests attr: Add test_attr__ready function
Date: Wed, 19 Jul 2017 11:29:08 -0300
Message-ID: <20170719142950.3747-45-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We create many test events before the real ones just to test specific
features. But there's no way for attr tests to separate those test
events from those it needs to check.

Adding 'ready' call from the events open interface to trigger/start
events collection for attr test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.h       |  1 +
 tools/perf/tests/attr.c | 10 ++++++++++
 tools/perf/util/evsel.c |  4 ++++
 3 files changed, 15 insertions(+)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 806c216a1078..2c010dd6a79d 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -7,6 +7,7 @@
 #include <linux/perf_event.h>
 
 extern bool test_attr__enabled;
+void test_attr__ready(void);
 void test_attr__init(void);
 void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
 		     int fd, int group_fd, unsigned long flags);
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 08b1d5ce9020..84c0eb598a67 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -36,6 +36,7 @@
 #define ENV "PERF_TEST_ATTR"
 
 static char *dir;
+static bool ready;
 
 void test_attr__init(void)
 {
@@ -67,6 +68,9 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
 	FILE *file;
 	char path[PATH_MAX];
 
+	if (!ready)
+		return 0;
+
 	snprintf(path, PATH_MAX, "%s/event-%d-%llu-%d", dir,
 		 attr->type, attr->config, fd);
 
@@ -144,6 +148,12 @@ void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
 	errno = errno_saved;
 }
 
+void test_attr__ready(void)
+{
+	if (unlikely(test_attr__enabled) && !ready)
+		ready = true;
+}
+
 static int run_dir(const char *d, const char *perf)
 {
 	char v[] = "-vvvvv";
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index df567e478a0e..6dd069a41ac3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -58,6 +58,8 @@ static int perf_evsel__no_extra_init(struct perf_evsel *evsel __maybe_unused)
 	return 0;
 }
 
+void __weak test_attr__ready(void) { }
+
 static void perf_evsel__no_extra_fini(struct perf_evsel *evsel __maybe_unused)
 {
 }
@@ -1572,6 +1574,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 			pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
 				  pid, cpus->map[cpu], group_fd, flags);
 
+			test_attr__ready();
+
 			fd = sys_perf_event_open(&evsel->attr, pid, cpus->map[cpu],
 						 group_fd, flags);
 
-- 
2.9.4
