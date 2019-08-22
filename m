From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/25] perf evsel: Remove needless counts.h header from util/evsel.h
Date: Thu, 22 Aug 2019 18:00:52 -0300
Message-ID: <20190822210100.3461-18-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need only a struct forward declaration, so prune the header
dependency tree a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-oqvgf04w4ku8xasrz79zquim@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 1 +
 tools/perf/util/evsel.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 477c47c84971..7b4350681d64 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -26,6 +26,7 @@
 #include "asm/bug.h"
 #include "callchain.h"
 #include "cgroup.h"
+#include "counts.h"
 #include "event.h"
 #include "evsel.h"
 #include "evlist.h"
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index da91d6f57f44..296390541030 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -11,7 +11,6 @@
 #include <perf/evsel.h>
 #include "symbol_conf.h"
 #include "cpumap.h"
-#include "counts.h"
 
 struct evsel;
 
@@ -93,6 +92,7 @@ enum perf_tool_event {
 };
 
 struct bpf_object;
+struct perf_counts;
 struct xyarray;
 
 /** struct evsel - event selector
-- 
2.21.0
