From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/53] perf evsel: No need to include symbol.h in evsel.h, symbol_conf.h is enough
Date: Wed,  6 Feb 2019 15:48:21 -0300
Message-ID: <20190206184903.24054-12-acme@kernel.org>
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

To reduce the header dependency and avoid unnecessary rebuilds when
things change in symbol.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6duflwliprh2tr47w5x4t260@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 29c5eb68c44b..cc578e02e08f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -8,7 +8,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include "xyarray.h"
-#include "symbol.h"
+#include "symbol_conf.h"
 #include "cpumap.h"
 #include "counts.h"
 
-- 
2.20.1
