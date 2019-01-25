From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/29] perf symbols: Remove include map.h from dso.h
Date: Sat, 26 Jan 2019 00:18:19 +0100
Message-ID: <20190125231843.2895-6-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Disentangling the dependency tree, to reduce build time.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-n2gcrfmh480rm44p7fra13vv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/map.c     | 1 +
 tools/perf/util/dso.h            | 4 +++-
 tools/perf/util/symbol_fprintf.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 5b8b8c637686..c70d9337405b 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include "../../util/util.h"
 #include "../../util/debug.h"
+#include "../../util/map.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../helpline.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index af2eda29660f..56001b82d448 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -7,12 +7,14 @@
 #include <linux/rbtree.h>
 #include <sys/types.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include "rwsem.h"
 #include <linux/bitops.h>
-#include "map.h"
 #include "namespaces.h"
 #include "build-id.h"
 
+struct map;
+
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index ed0205cc7942..50472c75da59 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 
+#include "map.h"
 #include "symbol.h"
 
 size_t symbol__fprintf(struct symbol *sym, FILE *fp)
-- 
2.20.1
