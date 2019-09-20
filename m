From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/31] perf python: Remove debug.h
Date: Fri, 20 Sep 2019 11:25:28 -0300
Message-ID: <20190920142542.12047-18-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We only need to have the prototype for the eprintf() replacement we use
in the python binding, provide it and avoid dragging debug.h as a
dependency.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-s0gy4ur3drmhsknsddwjco59@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 96dd3333c911..0ba19dd75510 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -6,7 +6,6 @@
 #include <linux/err.h>
 #include <perf/cpumap.h>
 #include <traceevent/event-parse.h>
-#include "debug.h"
 #include "evlist.h"
 #include "callchain.h"
 #include "evsel.h"
@@ -60,6 +59,8 @@ int parse_callchain_record(const char *arg __maybe_unused,
  */
 int verbose;
 
+int eprintf(int level, int var, const char *fmt, ...);
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 	va_list args;
-- 
2.21.0
