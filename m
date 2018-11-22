From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/28] perf bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h
Date: Thu, 22 Nov 2018 00:36:00 -0300
Message-ID: <20181122033611.15890-18-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Jason Baron <jbaron@akamai.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Both futex and epoll need this call, and can cause build failure on
systems that don't have it pthread_attr_setaffinity_np().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Link: http://lkml.kernel.org/r/20181109210719.pr7ohayuwqmfp2wl@linux-r8p5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/bench.h | 11 +++++++++++
 tools/perf/bench/futex.h | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 6c9fcd757f31..8299c76046cd 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -48,4 +48,15 @@ int bench_futex_lock_pi(int argc, const char **argv);
 extern int bench_format;
 extern unsigned int bench_repeat;
 
+#ifndef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
+#include <pthread.h>
+#include <linux/compiler.h>
+static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
+					      size_t cpusetsize __maybe_unused,
+					      cpu_set_t *cpuset __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index db4853f209c7..31b53cc7d5bc 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -86,16 +86,4 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wak
 	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
 		 val, opflags);
 }
-
-#ifndef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
-#include <pthread.h>
-#include <linux/compiler.h>
-static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
-					      size_t cpusetsize __maybe_unused,
-					      cpu_set_t *cpuset __maybe_unused)
-{
-	return 0;
-}
-#endif
-
 #endif /* _FUTEX_H */
-- 
2.14.5
