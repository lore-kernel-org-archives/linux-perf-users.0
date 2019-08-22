From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/25] perf script: Add missing counts.h
Date: Thu, 22 Aug 2019 18:00:47 -0300
Message-ID: <20190822210100.3461-13-acme@kernel.org>
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

It is getting this via evsel.h, that don't strictly need counts.h, just
forward declarations for some structs, so add it here before we remove
it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q4shpvlxyjqz7val1hyrdak9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1764efd16cd4..e957b870869b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3,6 +3,7 @@
 
 #include "perf.h"
 #include "util/cache.h"
+#include "util/counts.h"
 #include "util/debug.h"
 #include <subcmd/exec-cmd.h>
 #include "util/header.h"
-- 
2.21.0
