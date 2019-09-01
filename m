From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/47] perf tools: Remove needless map.h include directives
Date: Sun,  1 Sep 2019 09:23:10 -0300
Message-ID: <20190901122326.5793-32-acme@kernel.org>
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

Now that map.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-iu8ylqky7g1i9i54v3y7qovw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/sym-handling.c | 8 +++-----
 tools/perf/tests/thread-mg-share.c        | 1 -
 tools/perf/util/intel-bts.c               | 1 -
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
index 27fcf24d6850..5df788985130 100644
--- a/tools/perf/arch/arm64/util/sym-handling.c
+++ b/tools/perf/arch/arm64/util/sym-handling.c
@@ -4,11 +4,9 @@
  * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
  */
 
-#include "debug.h"
-#include "symbol.h"
-#include "map.h"
-#include "probe-event.h"
-#include "probe-file.h"
+#include "symbol.h" // for the elf__needs_adjust_symbols() prototype
+#include <stdbool.h>
+#include <gelf.h>
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
index b1d1bbafe7ae..cbac71716dec 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-mg-share.c
@@ -2,7 +2,6 @@
 #include "tests.h"
 #include "machine.h"
 #include "thread.h"
-#include "map.h"
 #include "debug.h"
 
 int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_unused)
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index a30427aa1de0..aacffa2b0362 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -19,7 +19,6 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "machine.h"
-#include "map.h"
 #include "symbol.h"
 #include "session.h"
 #include "tool.h"
-- 
2.21.0
