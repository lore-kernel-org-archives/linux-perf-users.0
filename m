From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/13] perf evsel: Fix max perf_event_attr.precise_ip detection
Date: Fri, 29 Mar 2019 10:37:51 -0300
Message-ID: <20190329133801.21004-4-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

After a discussion with Andi, move the perf_event_attr.precise_ip
detection for maximum precise config (via :P modifier or for default
cycles event) to perf_evsel__open().

The current detection in perf_event_attr__set_max_precise_ip() is
tricky, because precise_ip config is specific for given event and it
currently checks only hw cycles.

We now check for valid precise_ip value right after failing
sys_perf_event_open() for specific event, before any of the
perf_event_attr fallback code gets executed.

This way we get the proper config in perf_event_attr together with
allowed precise_ip settings.

We can see that code activity with -vv, like:

  $ perf record -vv ls
  ...
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    ...
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
  ------------------------------------------------------------
  sys_perf_event_open: pid 9926  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -95
  decreasing precise_ip by one (2)
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    ...
    precise_ip                       2
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
  ------------------------------------------------------------
  sys_perf_event_open: pid 9926  cpu 0  group_fd -1  flags 0x8 = 4
  ...

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/n/tip-dkvxxbeg7lu74155d4jhlmc9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 29 ----------------
 tools/perf/util/evlist.h |  2 --
 tools/perf/util/evsel.c  | 72 ++++++++++++++++++++++++++++++++--------
 3 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ec78e93085de..6689378ee577 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -231,35 +231,6 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 	}
 }
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
-{
-	struct perf_event_attr attr = {
-		.type		= PERF_TYPE_HARDWARE,
-		.config		= PERF_COUNT_HW_CPU_CYCLES,
-		.exclude_kernel	= 1,
-		.precise_ip	= 3,
-	};
-
-	event_attr_init(&attr);
-
-	/*
-	 * Unnamed union member, not supported as struct member named
-	 * initializer in older compilers such as gcc 4.4.7
-	 */
-	attr.sample_period = 1;
-
-	while (attr.precise_ip != 0) {
-		int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
-		if (fd != -1) {
-			close(fd);
-			break;
-		}
-		--attr.precise_ip;
-	}
-
-	pattr->precise_ip = attr.precise_ip;
-}
-
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
 {
 	struct perf_evsel *evsel = perf_evsel__new_cycles(precise);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dcb68f34d2cd..6a94785b9100 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -315,8 +315,6 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
 void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
 				     struct perf_evsel *tracking_evsel);
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr);
-
 struct perf_evsel *
 perf_evlist__find_evsel_by_str(struct perf_evlist *evlist, const char *str);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7835e05f0c0a..66d066f18b5b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -295,7 +295,6 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 	if (!precise)
 		goto new_event;
 
-	perf_event_attr__set_max_precise_ip(&attr);
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
@@ -305,6 +304,8 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 	if (evsel == NULL)
 		goto out;
 
+	evsel->precise_max = true;
+
 	/* use asprintf() because free(evsel) assumes name is allocated */
 	if (asprintf(&evsel->name, "cycles%s%s%.*s",
 		     (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
@@ -1083,7 +1084,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	}
 
 	if (evsel->precise_max)
-		perf_event_attr__set_max_precise_ip(attr);
+		attr->precise_ip = 3;
 
 	if (opts->all_user) {
 		attr->exclude_kernel = 1;
@@ -1749,6 +1750,59 @@ static bool ignore_missing_thread(struct perf_evsel *evsel,
 	return true;
 }
 
+static void display_attr(struct perf_event_attr *attr)
+{
+	if (verbose >= 2) {
+		fprintf(stderr, "%.60s\n", graph_dotted_line);
+		fprintf(stderr, "perf_event_attr:\n");
+		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);
+		fprintf(stderr, "%.60s\n", graph_dotted_line);
+	}
+}
+
+static int perf_event_open(struct perf_evsel *evsel,
+			   pid_t pid, int cpu, int group_fd,
+			   unsigned long flags)
+{
+	int precise_ip = evsel->attr.precise_ip;
+	int fd;
+
+	while (1) {
+		pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
+			  pid, cpu, group_fd, flags);
+
+		fd = sys_perf_event_open(&evsel->attr, pid, cpu, group_fd, flags);
+		if (fd >= 0)
+			break;
+
+		/*
+		 * Do quick precise_ip fallback if:
+		 *  - there is precise_ip set in perf_event_attr
+		 *  - maximum precise is requested
+		 *  - sys_perf_event_open failed with ENOTSUP error,
+		 *    which is associated with wrong precise_ip
+		 */
+		if (!precise_ip || !evsel->precise_max || (errno != ENOTSUP))
+			break;
+
+		/*
+		 * We tried all the precise_ip values, and it's
+		 * still failing, so leave it to standard fallback.
+		 */
+		if (!evsel->attr.precise_ip) {
+			evsel->attr.precise_ip = precise_ip;
+			break;
+		}
+
+		pr_debug2("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
+		evsel->attr.precise_ip--;
+		pr_debug2("decreasing precise_ip by one (%d)\n", evsel->attr.precise_ip);
+		display_attr(&evsel->attr);
+	}
+
+	return fd;
+}
+
 int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		     struct thread_map *threads)
 {
@@ -1824,12 +1878,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
 
-	if (verbose >= 2) {
-		fprintf(stderr, "%.60s\n", graph_dotted_line);
-		fprintf(stderr, "perf_event_attr:\n");
-		perf_event_attr__fprintf(stderr, &evsel->attr, __open_attr__fprintf, NULL);
-		fprintf(stderr, "%.60s\n", graph_dotted_line);
-	}
+	display_attr(&evsel->attr);
 
 	for (cpu = 0; cpu < cpus->nr; cpu++) {
 
@@ -1841,13 +1890,10 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 
 			group_fd = get_group_fd(evsel, cpu, thread);
 retry_open:
-			pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				  pid, cpus->map[cpu], group_fd, flags);
-
 			test_attr__ready();
 
-			fd = sys_perf_event_open(&evsel->attr, pid, cpus->map[cpu],
-						 group_fd, flags);
+			fd = perf_event_open(evsel, pid, cpus->map[cpu],
+					     group_fd, flags);
 
 			FD(evsel, cpu, thread) = fd;
 
-- 
2.20.1
