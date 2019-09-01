From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/47] perf tools: Remove needless libtraceevent include directives
Date: Sun,  1 Sep 2019 09:22:48 -0300
Message-ID: <20190901122326.5793-10-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Tzvetomir Stoyanov <tstoyanov@vmware.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Remove traceevent/event-parse.h and traceevent/trace-seq.h from places
where it is not needed.

Should avoid rebuilding those files when these traceevent headers get
changed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Link: https://lkml.kernel.org/n/tip-26hn75jn9rdealn4uqtzend6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c | 1 -
 tools/perf/util/session.c      | 1 -
 tools/perf/util/trace-event.h  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1ff81a790931..1a74499f3311 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -10,7 +10,6 @@
 
 #include <errno.h>
 #include <inttypes.h>
-#include <traceevent/event-parse.h>
 
 #include "builtin.h"
 #include "util/color.h"
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 13486bcf74a0..9eb843e5e6f0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4,7 +4,6 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
-#include <traceevent/event-parse.h>
 #include <api/fs/fs.h>
 
 #include <byteswap.h>
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 258d79071d81..2e158387b3d7 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -3,7 +3,6 @@
 #define _PERF_UTIL_TRACE_EVENT_H
 
 #include <traceevent/event-parse.h>
-#include <traceevent/trace-seq.h>
 #include "parse-events.h"
 
 struct machine;
-- 
2.21.0
