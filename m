From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/43] perf symbols: We need util.h in symbol-elf.c for zfree()
Date: Mon,  1 Jul 2019 23:25:51 -0300
Message-ID: <20190702022616.1259-19-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Continuing to untangle the headers, we're about to remove the old odd
baggage that is tools/perf/util/include/linux/ctype.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-gapezcq3p8bzrsi96vdtq0o0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index fdc5bd7dbb90..f04ef851ae86 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -14,6 +14,7 @@
 #include "machine.h"
 #include "vdso.h"
 #include "debug.h"
+#include "util.h"
 #include "sane_ctype.h"
 #include <symbol/kallsyms.h>
 
-- 
2.20.1
