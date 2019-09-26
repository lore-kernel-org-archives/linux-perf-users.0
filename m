From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 60/66] perf tools: Replace needless mmap.h with what is needed, event.h
Date: Wed, 25 Sep 2019 21:32:38 -0300
Message-ID: <20190926003244.13962-61-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The perf_sample struct definition and the event_attr_init() are in
util/event.h, but some places were getting it thru an otherwise needless
util/mmap.h header, fix it by including util/event.h directly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p1anwyjdbbvghrkl9dlxv7h5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c     | 2 +-
 tools/perf/util/parse-events.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 69d0a1991b29..e830eadfca2a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -34,7 +34,7 @@
 #include "bpf-event.h"
 #include "block-range.h"
 #include "string2.h"
-#include "util/mmap.h"
+#include "util/event.h"
 #include "arch/common.h"
 #include <regex.h>
 #include <pthread.h>
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 50737046fa63..b5e2adef49de 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -35,7 +35,7 @@
 #include "util/parse-branch-options.h"
 #include "metricgroup.h"
 #include "util/evsel_config.h"
-#include "util/mmap.h"
+#include "util/event.h"
 
 #define MAX_NAME_LEN 100
 
-- 
2.21.0
