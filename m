From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/33] perf sort: Remove needless headers from sort.h, provide fwd struct decls
Date: Mon, 26 Aug 2019 22:36:07 -0300
Message-ID: <20190827013634.3173-7-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Reducing the includes hell a bit more, speeding up the build and
avoiding needless rebuilds when just one of those files gets updated.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-u63el2vqsovsmnhebx1rcixo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/res_sample.c |  2 ++
 tools/perf/ui/browsers/scripts.c    |  2 ++
 tools/perf/ui/stdio/hist.c          |  1 +
 tools/perf/util/callchain.c         |  1 +
 tools/perf/util/sort.h              | 15 ++-------------
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 08897bd5eb0f..41a9d8923ec4 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -6,6 +6,8 @@
 #include "sort.h"
 #include "config.h"
 #include "time-utils.h"
+#include "../util.h"
+#include "../../util/util.h"
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 04f9aff5621e..f2fd9f0d7ab5 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "../../builtin.h"
 #include "../../util/sort.h"
+#include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index ee7ea6deed21..51ed67548b83 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -3,6 +3,7 @@
 #include <linux/string.h>
 
 #include "../../util/callchain.h"
+#include "../../util/debug.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
 #include "../../util/map_groups.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d077704f9afa..dd6e01000385 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -20,6 +20,7 @@
 
 #include "asm/bug.h"
 
+#include "debug.h"
 #include "hist.h"
 #include "sort.h"
 #include "machine.h"
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 4ae155c6a808..3d7cef73924c 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -1,29 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PERF_SORT_H
 #define __PERF_SORT_H
-#include "../builtin.h"
-
 #include <regex.h>
-
-#include "color.h"
+#include <stdbool.h>
 #include <linux/list.h>
-#include "cache.h"
 #include <linux/rbtree.h>
 #include "map_symbol.h"
 #include "symbol_conf.h"
-#include "string.h"
 #include "callchain.h"
 #include "values.h"
 
-#include "../perf.h"
-#include "debug.h"
-#include "header.h"
-
-#include <subcmd/parse-options.h>
-#include "parse-events.h"
 #include "hist.h"
-#include "srcline.h"
 
+struct option;
 struct thread;
 
 extern regex_t parent_regex;
-- 
2.21.0
