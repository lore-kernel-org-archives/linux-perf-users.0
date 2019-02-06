From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/53] perf tools: Add missing include <callchain.h> in various places
Date: Wed,  6 Feb 2019 15:48:23 -0300
Message-ID: <20190206184903.24054-14-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its getting it from hist.h and that will go away, as that header doesn't
need callchain.h at all.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6ebl3mwwiqocl79yts44qltu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 1 +
 tools/perf/ui/gtk/hists.c      | 1 +
 tools/perf/ui/hist.c           | 1 +
 tools/perf/ui/stdio/hist.c     | 1 +
 tools/perf/util/config.c       | 1 +
 tools/perf/util/hist.c         | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ac176b48178c..aef800d97ea1 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include <sys/ttydefaults.h>
 
+#include "../../util/callchain.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/hist.h"
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 74414ccd8c84..0c08890f006a 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../evlist.h"
 #include "../cache.h"
+#include "../callchain.h"
 #include "../evsel.h"
 #include "../sort.h"
 #include "../hist.h"
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index fe3dfaa64a91..412d6f1626e3 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -3,6 +3,7 @@
 #include <math.h>
 #include <linux/compiler.h>
 
+#include "../util/callchain.h"
 #include "../util/hist.h"
 #include "../util/util.h"
 #include "../util/sort.h"
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index f25116f70878..a60f2993d390 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <linux/string.h>
 
+#include "../../util/callchain.h"
 #include "../../util/util.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 1ea8f898f1a1..fa092511c52b 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -13,6 +13,7 @@
 #include <sys/param.h>
 #include "util.h"
 #include "cache.h"
+#include "callchain.h"
 #include <subcmd/exec-cmd.h>
 #include "util/event.h"  /* proc_map_timeout */
 #include "util/hist.h"  /* perf_hist_config */
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3560ad2e5551..7f9df74ab893 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "callchain.h"
 #include "util.h"
 #include "build-id.h"
 #include "hist.h"
-- 
2.20.1
