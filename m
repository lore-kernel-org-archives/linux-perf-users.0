From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/63] perf evsel: Always preserve errno while cleaning up perf_event_open failures
Date: Thu,  7 Nov 2019 15:59:17 -0300
Message-ID: <20191107190011.23924-10-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In some cases when perf_event_open fails, it may do some closes to clean
up. In special cases these closes can fail too, which overwrites the
errno of the perf_event_open, which is then incorrectly reported.

Save/restore errno around closes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191020175202.32456-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index abc7fda4a0fe..d831038b55f2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1574,7 +1574,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
-	int pid = -1, err;
+	int pid = -1, err, old_errno;
 	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
 
 	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
@@ -1727,8 +1727,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 */
 	if (err == -EMFILE && set_rlimit < INCREASED_MAX) {
 		struct rlimit l;
-		int old_errno = errno;
 
+		old_errno = errno;
 		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
 			if (set_rlimit == NO_CHANGE)
 				l.rlim_cur = l.rlim_max;
@@ -1812,6 +1812,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err)
 		threads->err_thread = thread;
 
+	old_errno = errno;
 	do {
 		while (--thread >= 0) {
 			close(FD(evsel, cpu, thread));
@@ -1819,6 +1820,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		}
 		thread = nthreads;
 	} while (--cpu >= 0);
+	errno = old_errno;
 	return err;
 }
 
-- 
2.21.0
