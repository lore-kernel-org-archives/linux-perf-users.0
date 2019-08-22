From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/25] perf evsel: Add missing perf/evsel.h header in util/evsel.h
Date: Thu, 22 Aug 2019 18:00:51 -0300
Message-ID: <20190822210100.3461-17-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since util/evsel.h uses perf_evsel__cpus() that has its prototype in
libperf's perf/evsel.h file, we need it explicitely included.

This was working by luck as util/evsel.h includes counts.h, but that is
not necessary, just some forward declarations, so, before we remove
counts.h from util/evsel.h, add what is realli needed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nfb9e0t4jm9zhvr0q86hc29d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2928eee78427..da91d6f57f44 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -8,6 +8,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
+#include <perf/evsel.h>
 #include "symbol_conf.h"
 #include "cpumap.h"
 #include "counts.h"
-- 
2.21.0
