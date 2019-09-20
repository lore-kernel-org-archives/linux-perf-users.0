From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/31] perf probe: Add missing build-id.h header.
Date: Fri, 20 Sep 2019 11:25:22 -0300
Message-ID: <20190920142542.12047-12-acme@kernel.org>
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

It uses things defined in that header and was getting it only
indirectly, thru dso.h, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7u3sf4j5huhi3mqa1q77524b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index d13db55a2feb..b659466ea498 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -16,6 +16,7 @@
 #include "strlist.h"
 #include "strfilter.h"
 #include "debug.h"
+#include "build-id.h"
 #include "dso.h"
 #include "color.h"
 #include "symbol.h"
-- 
2.21.0
