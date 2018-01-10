From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/27] perf tools: Enable LIBBABELTRACE by default
Date: Wed, 10 Jan 2018 18:28:30 -0300
Message-ID: <20180110212844.12441-14-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no reason anymore to treat babel trace in a special way, because
a) we no longer display its state b) the needed babeltrace library is
now out and well adopted among distros.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180107160356.28203-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 tools/perf/Makefile.perf   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f050f38d8fa3..12dec6ea5ed2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -780,7 +780,7 @@ else
   NO_PERF_READ_VDSOX32 := 1
 endif
 
-ifdef LIBBABELTRACE
+ifndef NO_LIBBABELTRACE
   $(call feature_check,libbabeltrace)
   ifeq ($(feature-libbabeltrace), 1)
     CFLAGS += -DHAVE_LIBBABELTRACE_SUPPORT $(LIBBABELTRACE_CFLAGS)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 68cf1360a3f3..9fdefd748e2e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -77,7 +77,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_ZLIB if you do not want to support compressed kernel modules
 #
-# Define LIBBABELTRACE if you DO want libbabeltrace support
+# Define NO_LIBBABELTRACE if you do not want libbabeltrace support
 # for CTF data format.
 #
 # Define NO_LZMA if you do not want to support compressed (xz) kernel modules
-- 
2.14.3
