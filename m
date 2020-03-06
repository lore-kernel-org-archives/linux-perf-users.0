From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/6] perf bench: Clear struct sigaction before sigaction() syscall
Date: Fri,  6 Mar 2020 16:11:40 -0300
Message-ID: <20200306191144.12762-8-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tommi Rantala <tommi.t.rantala@nokia.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Changbin Du <changbin.du@intel.com>, Darren Hart <dvhart@infradead.org>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Avoid garbage in sigaction structs used in sigaction() syscalls.
Valgrind is complaining about it.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200305083714.9381-4-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/epoll-ctl.c           | 1 +
 tools/perf/bench/epoll-wait.c          | 1 +
 tools/perf/bench/futex-hash.c          | 1 +
 tools/perf/bench/futex-lock-pi.c       | 1 +
 tools/perf/bench/futex-requeue.c       | 1 +
 tools/perf/bench/futex-wake-parallel.c | 1 +
 tools/perf/bench/futex-wake.c          | 1 +
 7 files changed, 7 insertions(+)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index a7526c05df38..cadc18d42aa4 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -312,6 +312,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index d1c5cb526b9f..f938c585d512 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -426,6 +426,7 @@ int bench_epoll_wait(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 21776862e940..65eebe06c04d 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -137,6 +137,7 @@ int bench_futex_hash(int argc, const char **argv)
 	if (!cpu)
 		goto errmem;
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 30d97121dc4f..89fd8f325f38 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -160,6 +160,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index a00a6891447a..7a15c2e61022 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -128,6 +128,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "cpu_map__new");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index a053cf2b7039..cd2b81a845ac 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -234,6 +234,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 58906e9499bb..2dfcef3e371e 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -136,6 +136,7 @@ int bench_futex_wake(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
-- 
2.21.1
