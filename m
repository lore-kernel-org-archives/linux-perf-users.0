From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/31] perf debug: No need to include ui/util.h
Date: Fri, 20 Sep 2019 11:25:19 -0300
Message-ID: <20190920142542.12047-9-acme@kernel.org>
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

Nothing from that file is used in util/debug.h, it is only needed in
some places that get it indirectly via including util/debug.h, remove
that entanglement.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hn9v4jdova2nt018fqsjyzun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/scripts.c | 1 +
 tools/perf/ui/gtk/setup.c        | 3 ++-
 tools/perf/util/debug.h          | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 586a21acc13d..3b81075b8da8 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -2,6 +2,7 @@
 #include "../../builtin.h"
 #include "../../perf.h"
 #include "../../util/util.h"
+#include "../util.h"
 #include "../../util/hist.h"
 #include "../../util/debug.h"
 #include "../../util/symbol.h"
diff --git a/tools/perf/ui/gtk/setup.c b/tools/perf/ui/gtk/setup.c
index 1a2616b97b5c..f5eee4d66873 100644
--- a/tools/perf/ui/gtk/setup.c
+++ b/tools/perf/ui/gtk/setup.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "gtk.h"
-#include "../../util/debug.h"
+#include <linux/compiler.h>
+#include "../util.h"
 
 extern struct perf_error_ops perf_gtk_eops;
 
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index b2deee987ffa..d25ae1c4cee9 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -3,9 +3,9 @@
 #ifndef __PERF_DEBUG_H
 #define __PERF_DEBUG_H
 
+#include <stdarg.h>
 #include <stdbool.h>
 #include <linux/compiler.h>
-#include "../ui/util.h"
 
 extern int verbose;
 extern bool quiet, dump_trace;
-- 
2.21.0
