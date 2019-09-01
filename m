From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/47] perf tools: Remove needless evlist.h include directives
Date: Sun,  1 Sep 2019 09:23:13 -0300
Message-ID: <20190901122326.5793-35-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that evlist.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6d7kape36m94a266md0d3xbh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-lock.c       | 2 +-
 tools/perf/builtin-timechart.c  | 2 +-
 tools/perf/tests/hists_common.c | 1 -
 tools/perf/tests/sdt.c          | 3 ++-
 tools/perf/ui/gtk/browser.c     | 1 -
 tools/perf/util/arm-spe.c       | 3 ++-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 38500bff4423..b0ff952be9db 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 #include "perf.h"
 
-#include "util/evlist.h"
+#include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
 #include "util/cache.h"
 #include "util/symbol.h"
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1a74499f3311..65560a86f643 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -15,7 +15,7 @@
 #include "util/color.h"
 #include <linux/list.h>
 #include "util/cache.h"
-#include "util/evlist.h"
+#include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index cdde41c03056..de110d8f169b 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -6,7 +6,6 @@
 #include "util/symbol.h"
 #include "util/sort.h"
 #include "util/evsel.h"
-#include "util/evlist.h"
 #include "util/machine.h"
 #include "util/thread.h"
 #include "tests/hists_common.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index dbc35a8912ed..cf1bd57d3023 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <limits.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/epoll.h>
-#include <util/evlist.h>
 #include <util/symbol.h>
 #include <linux/filter.h>
 #include "tests.h"
diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index 4820e25ac68d..06a6a1ebaef0 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../evlist.h"
 #include "../cache.h"
 #include "../evsel.h"
 #include "../sort.h"
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 6bee59946c4f..8a7340f6a2a2 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -8,6 +8,8 @@
 #include <errno.h>
 #include <byteswap.h>
 #include <inttypes.h>
+#include <unistd.h>
+#include <stdlib.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
@@ -17,7 +19,6 @@
 #include "cpumap.h"
 #include "color.h"
 #include "evsel.h"
-#include "evlist.h"
 #include "machine.h"
 #include "session.h"
 #include "debug.h"
-- 
2.21.0
