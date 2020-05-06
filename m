From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 63/91] perf mem2node: Avoid double free related to realloc
Date: Wed,  6 May 2020 12:22:06 -0300
Message-ID: <20200506152234.21977-64-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, clang-built-linux@googlegroups.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

Realloc of size zero is a free not an error, avoid this causing a double
free. Caught by clang's address sanitizer:

==2634==ERROR: AddressSanitizer: attempting double-free on 0x6020000015f0 in thread T0:
    #0 0x5649659297fd in free llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:123:3
    #1 0x5649659e9251 in __zfree tools/lib/zalloc.c:13:2
    #2 0x564965c0f92c in mem2node__exit tools/perf/util/mem2node.c:114:2
    #3 0x564965a08b4c in perf_c2c__report tools/perf/builtin-c2c.c:2867:2
    #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
    #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
    #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
    #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
    #8 0x564965942e41 in main tools/perf/perf.c:538:3

0x6020000015f0 is located 0 bytes inside of 1-byte region [0x6020000015f0,0x6020000015f1)
freed by thread T0 here:
    #0 0x564965929da3 in realloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
    #1 0x564965c0f55e in mem2node__init tools/perf/util/mem2node.c:97:16
    #2 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
    #3 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
    #4 0x564965944348 in run_builtin tools/perf/perf.c:312:11
    #5 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
    #6 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
    #7 0x564965942e41 in main tools/perf/perf.c:538:3

previously allocated by thread T0 here:
    #0 0x564965929c42 in calloc third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x5649659e9220 in zalloc tools/lib/zalloc.c:8:9
    #2 0x564965c0f32d in mem2node__init tools/perf/util/mem2node.c:61:12
    #3 0x564965a08956 in perf_c2c__report tools/perf/builtin-c2c.c:2803:8
    #4 0x564965a0616a in cmd_c2c tools/perf/builtin-c2c.c:2989:10
    #5 0x564965944348 in run_builtin tools/perf/perf.c:312:11
    #6 0x564965943235 in handle_internal_command tools/perf/perf.c:364:8
    #7 0x5649659440c4 in run_argv tools/perf/perf.c:408:2
    #8 0x564965942e41 in main tools/perf/perf.c:538:3

v2: add a WARN_ON_ONCE when the free condition arises.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200320182347.87675-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mem2node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index 797d86a1ab09..c84f5841c7ab 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -1,5 +1,6 @@
 #include <errno.h>
 #include <inttypes.h>
+#include <asm/bug.h>
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
@@ -95,7 +96,7 @@ int mem2node__init(struct mem2node *map, struct perf_env *env)
 
 	/* Cut unused entries, due to merging. */
 	tmp_entries = realloc(entries, sizeof(*entries) * j);
-	if (tmp_entries)
+	if (tmp_entries || WARN_ON_ONCE(j == 0))
 		entries = tmp_entries;
 
 	for (i = 0; i < j; i++) {
-- 
2.21.1
