From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/43] perf tools: Use linux/ctype.h in more places
Date: Mon,  1 Jul 2019 23:25:55 -0300
Message-ID: <20190702022616.1259-23-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There were a few places where we still were using the libc version of
ctype.h, switch to the one in tools/lib/ctype.c that the rest of perf
uses.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wa4nz4kt61eze88eprk20tfd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/header.c | 2 +-
 tools/perf/util/metricgroup.c      | 2 +-
 tools/perf/util/time-utils.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 3db85cd2069e..a25896135abe 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 #include "../../util/header.h"
 #include "../../util/util.h"
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 699e020737d9..a0cf3cd95ced 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -17,7 +17,7 @@
 #include "pmu-events/pmu-events.h"
 #include "strlist.h"
 #include <assert.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct perf_evsel *evsel,
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 2b48816a2d2e..369fa19dd596 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -7,7 +7,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <math.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 #include "perf.h"
 #include "debug.h"
-- 
2.20.1
