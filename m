From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/43] perf time-utils: Use skip_spaces()
Date: Mon,  1 Jul 2019 23:25:59 -0300
Message-ID: <20190702022616.1259-27-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour intended.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cpugv7qd5vzhbtvnlydo90jv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 369fa19dd596..c2abc259b51d 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <string.h>
+#include <linux/string.h>
 #include <sys/time.h>
 #include <linux/time64.h>
 #include <time.h>
@@ -141,10 +142,7 @@ static int perf_time__parse_strs(struct perf_time_interval *ptime,
 	for (i = 0, p = str; i < num - 1; i++) {
 		arg = p;
 		/* Find next comma, there must be one */
-		p = strchr(p, ',') + 1;
-		/* Skip white space */
-		while (isspace(*p))
-			p++;
+		p = skip_spaces(strchr(p, ',') + 1);
 		/* Skip the value, must not contain space or comma */
 		while (*p && !isspace(*p)) {
 			if (*p++ == ',') {
-- 
2.20.1
