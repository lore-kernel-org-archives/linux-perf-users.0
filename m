From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/43] perf stat: Use recently introduced skip_spaces()
Date: Mon,  1 Jul 2019 23:25:57 -0300
Message-ID: <20190702022616.1259-25-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ncpvp4eelf8fqhuy29uv56z9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 992e327bce85..ce993d29cca5 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1,5 +1,6 @@
 #include <stdio.h>
 #include <inttypes.h>
+#include <linux/string.h>
 #include <linux/time64.h>
 #include <math.h>
 #include "color.h"
@@ -215,9 +216,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	while (isspace(*unit))
-		unit++;
-	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, unit);
+	fprintf(out, "%s%s%s%s", config->csv_sep, vals, config->csv_sep, skip_spaces(unit));
 }
 
 /* Filter out some columns that don't work well in metrics only mode */
-- 
2.20.1
