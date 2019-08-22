From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/25] perf stat: Add missing counts.h
Date: Thu, 22 Aug 2019 18:00:49 -0300
Message-ID: <20190822210100.3461-15-acme@kernel.org>
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

It is getting this via evsel.h, that don't strictly need counts.h, just
forward declarations for some structs, so add it here before we remove
it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-jwcbm9gv9llloe3he5qkdefs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 1 +
 tools/perf/util/stat.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 3df0e39ccd52..605a1fdbda7a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -4,6 +4,7 @@
 #include <linux/time64.h>
 #include <math.h>
 #include "color.h"
+#include "counts.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "stat.h"
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 2715112290cf..1e6a25abe00f 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <math.h>
+#include "counts.h"
 #include "stat.h"
 #include "evlist.h"
 #include "evsel.h"
-- 
2.21.0
