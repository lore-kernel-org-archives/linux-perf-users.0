From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/19] perf bench: Fix numa report output code
Date: Mon, 25 Jun 2018 14:40:42 -0300
Message-ID: <20180625174045.25765-17-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we can hit following assert when running numa bench:

  $ perf bench numa mem -p 3 -t 1 -P 512 -s 100 -zZ0cm --thp 1
  perf: bench/numa.c:1577: __bench_numa: Assertion `!(!(((wait_stat) & 0x7f) == 0))' failed.

The assertion is correct, because we hit the SIGFPE in following line:

  Thread 2.2 "thread 0/0" received signal SIGFPE, Arithmetic exception.
  [Switching to Thread 0x7fffd28c6700 (LWP 11750)]
  0x000.. in worker_thread (__tdata=0x7.. ) at bench/numa.c:1257
  1257 td->speed_gbs = bytes_done / (td->runtime_ns / NSEC_PER_SEC) / 1e9;

We don't check if the runtime is actually bigger than 1 second,
and thus this might end up with zero division within FPU.

Adding the check to prevent this.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180620094036.17278-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 63eb49082774..44195514b19e 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1098,7 +1098,7 @@ static void *worker_thread(void *__tdata)
 	u8 *global_data;
 	u8 *process_data;
 	u8 *thread_data;
-	u64 bytes_done;
+	u64 bytes_done, secs;
 	long work_done;
 	u32 l;
 	struct rusage rusage;
@@ -1254,7 +1254,8 @@ static void *worker_thread(void *__tdata)
 	timersub(&stop, &start0, &diff);
 	td->runtime_ns = diff.tv_sec * NSEC_PER_SEC;
 	td->runtime_ns += diff.tv_usec * NSEC_PER_USEC;
-	td->speed_gbs = bytes_done / (td->runtime_ns / NSEC_PER_SEC) / 1e9;
+	secs = td->runtime_ns / NSEC_PER_SEC;
+	td->speed_gbs = secs ? bytes_done / secs / 1e9 : 0;
 
 	getrusage(RUSAGE_THREAD, &rusage);
 	td->system_time_ns = rusage.ru_stime.tv_sec * NSEC_PER_SEC;
-- 
2.14.3
