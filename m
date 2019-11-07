From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/63] perf evsel: Avoid close(-1)
Date: Thu,  7 Nov 2019 15:59:18 -0300
Message-ID: <20191107190011.23924-11-acme@kernel.org>
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

In some weak fallback cases close can be called a lot with -1. Check for
this case and avoid calling close then.

This is mainly to shut up valgrind which complains about this case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191020175202.32456-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c  | 3 ++-
 tools/perf/util/evsel.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index a8cb582e2721..5a89857b0381 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -120,7 +120,8 @@ void perf_evsel__close_fd(struct perf_evsel *evsel)
 
 	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
-			close(FD(evsel, cpu, thread));
+			if (FD(evsel, cpu, thread) >= 0)
+				close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d831038b55f2..d4451846af93 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1815,7 +1815,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	old_errno = errno;
 	do {
 		while (--thread >= 0) {
-			close(FD(evsel, cpu, thread));
+			if (FD(evsel, cpu, thread) >= 0)
+				close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
 		thread = nthreads;
-- 
2.21.0
