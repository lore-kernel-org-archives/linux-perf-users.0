From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/37] perf symbols: Use CAP_SYSLOG with kptr_restrict checks
Date: Thu, 29 Aug 2019 11:38:45 -0300
Message-ID: <20190829143917.29745-6-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Igor Lubashev <ilubashe@akamai.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, James Morris <jmorris@namei.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

The kernel is using CAP_SYSLOG capability instead of uid==0 and euid==0
when checking kptr_restrict. Make perf do the same.

Also, the kernel is a more restrictive than "no restrictions" in case of
kptr_restrict==0, so add the same logic to perf.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1566869956-7154-5-git-send-email-ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4efde7879474..035f2e75728c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/mman.h>
 #include <linux/time64.h>
@@ -15,8 +16,10 @@
 #include <inttypes.h>
 #include "annotate.h"
 #include "build-id.h"
+#include "cap.h"
 #include "util.h"
 #include "debug.h"
+#include "event.h"
 #include "machine.h"
 #include "map.h"
 #include "symbol.h"
@@ -2195,13 +2198,19 @@ static bool symbol__read_kptr_restrict(void)
 		char line[8];
 
 		if (fgets(line, sizeof(line), fp) != NULL)
-			value = ((geteuid() != 0) || (getuid() != 0)) ?
-					(atoi(line) != 0) :
-					(atoi(line) == 2);
+			value = perf_cap__capable(CAP_SYSLOG) ?
+					(atoi(line) >= 2) :
+					(atoi(line) != 0);
 
 		fclose(fp);
 	}
 
+	/* Per kernel/kallsyms.c:
+	 * we also restrict when perf_event_paranoid > 1 w/o CAP_SYSLOG
+	 */
+	if (perf_event_paranoid() > 1 && !perf_cap__capable(CAP_SYSLOG))
+		value = true;
+
 	return value;
 }
 
-- 
2.21.0
