From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/47] perf symbols: Add missing linux/refcount.h to symbol.h
Date: Sun,  1 Sep 2019 09:23:03 -0300
Message-ID: <20190901122326.5793-25-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We use refcount_t there, so we need that header or else it'll break when
we remove dso.h, that is from where it is getting that definition now...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5albrk0uve6x9cf6x3ebwpae@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index bcc0d84a42b8..22660c7614a5 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -3,6 +3,7 @@
 #define __PERF_SYMBOL 1
 
 #include <linux/types.h>
+#include <linux/refcount.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <linux/list.h>
-- 
2.21.0
