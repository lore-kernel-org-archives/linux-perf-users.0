From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/24] perf utils: Move perf_config using routines from color.c to separate object
Date: Mon, 21 Jan 2019 20:57:06 -0300
Message-ID: <20190121235706.20005-25-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To untangle objects a bit more, avoiding rebuilding the color_fprintf
routines when changes are made to the perf config headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-8qvu2ek26antm3a8jyl4ocbq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build          |  1 +
 tools/perf/util/color.c        | 39 ----------------------------
 tools/perf/util/color_config.c | 47 ++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 39 deletions(-)
 create mode 100644 tools/perf/util/color_config.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c359af408334..b69d6294c88c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -35,6 +35,7 @@ libperf-y += dso.o
 libperf-y += symbol.o
 libperf-y += symbol_fprintf.o
 libperf-y += color.o
+libperf-y += color_config.o
 libperf-y += metricgroup.o
 libperf-y += header.o
 libperf-y += callchain.o
diff --git a/tools/perf/util/color.c b/tools/perf/util/color.c
index 39e628b8938e..39b8c4ec4e2e 100644
--- a/tools/perf/util/color.c
+++ b/tools/perf/util/color.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include "cache.h"
-#include "config.h"
 #include <stdlib.h>
 #include <stdio.h>
 #include "color.h"
@@ -10,44 +9,6 @@
 
 int perf_use_color_default = -1;
 
-int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty)
-{
-	if (value) {
-		if (!strcasecmp(value, "never"))
-			return 0;
-		if (!strcasecmp(value, "always"))
-			return 1;
-		if (!strcasecmp(value, "auto"))
-			goto auto_color;
-	}
-
-	/* Missing or explicit false to turn off colorization */
-	if (!perf_config_bool(var, value))
-		return 0;
-
-	/* any normal truth value defaults to 'auto' */
- auto_color:
-	if (stdout_is_tty < 0)
-		stdout_is_tty = isatty(1);
-	if (stdout_is_tty || pager_in_use()) {
-		char *term = getenv("TERM");
-		if (term && strcmp(term, "dumb"))
-			return 1;
-	}
-	return 0;
-}
-
-int perf_color_default_config(const char *var, const char *value,
-			      void *cb __maybe_unused)
-{
-	if (!strcmp(var, "color.ui")) {
-		perf_use_color_default = perf_config_colorbool(var, value, -1);
-		return 0;
-	}
-
-	return 0;
-}
-
 static int __color_vsnprintf(char *bf, size_t size, const char *color,
 			     const char *fmt, va_list args, const char *trail)
 {
diff --git a/tools/perf/util/color_config.c b/tools/perf/util/color_config.c
new file mode 100644
index 000000000000..817dc56e7e95
--- /dev/null
+++ b/tools/perf/util/color_config.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include "cache.h"
+#include "config.h"
+#include <stdlib.h>
+#include <stdio.h>
+#include "color.h"
+#include <math.h>
+#include <unistd.h>
+
+int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty)
+{
+	if (value) {
+		if (!strcasecmp(value, "never"))
+			return 0;
+		if (!strcasecmp(value, "always"))
+			return 1;
+		if (!strcasecmp(value, "auto"))
+			goto auto_color;
+	}
+
+	/* Missing or explicit false to turn off colorization */
+	if (!perf_config_bool(var, value))
+		return 0;
+
+	/* any normal truth value defaults to 'auto' */
+ auto_color:
+	if (stdout_is_tty < 0)
+		stdout_is_tty = isatty(1);
+	if (stdout_is_tty || pager_in_use()) {
+		char *term = getenv("TERM");
+		if (term && strcmp(term, "dumb"))
+			return 1;
+	}
+	return 0;
+}
+
+int perf_color_default_config(const char *var, const char *value,
+			      void *cb __maybe_unused)
+{
+	if (!strcmp(var, "color.ui")) {
+		perf_use_color_default = perf_config_colorbool(var, value, -1);
+		return 0;
+	}
+
+	return 0;
+}
-- 
2.20.1
