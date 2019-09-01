From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/47] perf tools: Remove needless thread_map.h include directives
Date: Sun,  1 Sep 2019 09:23:12 -0300
Message-ID: <20190901122326.5793-34-acme@kernel.org>
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

Now that thread_map.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fyzvg64cz1ikvyxp8d6nrhz1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 1 -
 tools/perf/builtin-top.c          | 1 -
 tools/perf/util/cs-etm.c          | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 197041fcba25..59e44f90dc46 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -24,7 +24,6 @@
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
 #include "../../util/pmu.h"
-#include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 #include "../../util/util.h"
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index eb941213fa0c..726e3f2dd8c7 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -32,7 +32,6 @@
 #include "util/map.h"
 #include "util/session.h"
 #include "util/symbol.h"
-#include "util/thread_map.h"
 #include "util/top.h"
 #include "util/util.h"
 #include <linux/rbtree.h>
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3ed1d3bb7089..30c2048ce67d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -30,7 +30,6 @@
 #include "symbol.h"
 #include "tool.h"
 #include "thread.h"
-#include "thread_map.h"
 #include "thread-stack.h"
 #include <tools/libc_compat.h>
 #include "util.h"
-- 
2.21.0
