From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/47] perf probe: No need for symbol.h, symbol_conf is enough
Date: Sun,  1 Sep 2019 09:23:09 -0300
Message-ID: <20190901122326.5793-31-acme@kernel.org>
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

Remove one more unneeded use of symbol.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vrda1tuem1o8pk82t2kfjtun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 6dce1724a378..26bc5923e6b5 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -21,7 +21,7 @@
 #include "util/build-id.h"
 #include "util/strlist.h"
 #include "util/strfilter.h"
-#include "util/symbol.h"
+#include "util/symbol_conf.h"
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
 #include "util/probe-finder.h"
-- 
2.21.0
