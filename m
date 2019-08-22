From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/25] perf evsel: Switch to libperf's cpumap.h
Date: Thu, 22 Aug 2019 18:00:56 -0300
Message-ID: <20190822210100.3461-22-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We don't need what is in perf's util/cpumap.h, just the struct cpu_map
that is in libperf's internal/cpumap.h file to cover this one case:

  tools/perf/util/evsel.h:215:27: error: dereferencing pointer to incomplete type ‘struct perf_cpu_map’
  215 |  return evsel__cpus(evsel)->nr;

So switch to libperf's cpumap.h and add some missing struct foward
declarations and include sys/types.h to get pid_t.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ufjkpohijti05ggk69s91ktf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cd336cf2eaa9..5a351cae66df 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -5,14 +5,17 @@
 #include <linux/list.h>
 #include <stdbool.h>
 #include <stdio.h>
+#include <sys/types.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
-#include "cpumap.h"
+#include <internal/cpumap.h>
 
+struct addr_location;
 struct evsel;
+union perf_event;
 
 /*
  * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
-- 
2.21.0
