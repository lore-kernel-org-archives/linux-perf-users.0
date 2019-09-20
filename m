From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/31] perf annotate: Add missing machine.h include directive
Date: Fri, 20 Sep 2019 11:25:30 -0300
Message-ID: <20190920142542.12047-20-acme@kernel.org>
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

We use what is defined there, were getting it by luck, indirectly, fix
it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-56g4jshmktniundmiw7h845k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 4e4d2e76232e..553c651fa0a2 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -27,6 +27,7 @@
 #include "util/sort.h"
 #include "util/hist.h"
 #include "util/dso.h"
+#include "util/machine.h"
 #include "util/map.h"
 #include "util/session.h"
 #include "util/tool.h"
-- 
2.21.0
