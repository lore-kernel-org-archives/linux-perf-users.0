From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/91] perf bench: Fix div-by-zero if runtime is zero
Date: Wed,  6 May 2020 12:21:05 -0300
Message-ID: <20200506152234.21977-3-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tommi Rantala <tommi.t.rantala@nokia.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Fix div-by-zero if runtime is zero:

  $ perf bench futex hash --runtime=0
  # Running 'futex/hash' benchmark:
  Run summary [PID 12090]: 4 threads, each operating on 1024 [private] futexes for 0 secs.
  Floating point exception (core dumped)

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200417132330.119407-4-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/epoll-wait.c    | 3 ++-
 tools/perf/bench/futex-hash.c    | 3 ++-
 tools/perf/bench/futex-lock-pi.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index f938c585d512..cf797362675b 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -519,7 +519,8 @@ int bench_epoll_wait(int argc, const char **argv)
 		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 
 		update_stats(&throughput_stats, t);
 
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 65eebe06c04d..915bf3da7ce2 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -205,7 +205,8 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 		update_stats(&throughput_stats, t);
 		if (!silent) {
 			if (nfutexes == 1)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 89fd8f325f38..bb25d8beb3b8 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -211,7 +211,8 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 
 		update_stats(&throughput_stats, t);
 		if (!silent)
-- 
2.21.1
