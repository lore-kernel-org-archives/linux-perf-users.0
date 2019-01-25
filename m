From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/29] perf symbols: Remove some unnecessary includes from symbol.h
Date: Sat, 26 Jan 2019 00:18:20 +0100
Message-ID: <20190125231843.2895-7-acme@kernel.org>
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

And fixup the fallout in places like annotation and jitdump that were
using things like dirname() but weren't including libgen.h, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7ji9igrauh6ylt3p6i03bjlf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c |  1 +
 tools/perf/util/jitdump.c  |  1 +
 tools/perf/util/symbol.h   | 10 ++++------
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 70de8f6b3aee..3d79add5f7ae 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -9,6 +9,7 @@
 
 #include <errno.h>
 #include <inttypes.h>
+#include <libgen.h>
 #include "util.h"
 #include "ui/ui.h"
 #include "sort.h"
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index bf249552a9b0..eda28d3570bc 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -2,6 +2,7 @@
 #include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <errno.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 956d9916e364..2162a5d9b3ac 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -5,16 +5,10 @@
 #include <linux/types.h>
 #include <stdbool.h>
 #include <stdint.h>
-#include "map.h"
-#include "../perf.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
-#include <byteswap.h>
-#include <libgen.h>
 #include "branch.h"
-#include "build-id.h"
-#include "event.h"
 #include "path.h"
 #include "symbol_conf.h"
 
@@ -26,6 +20,10 @@
 
 #include "dso.h"
 
+struct map;
+struct map_groups;
+struct option;
+
 /*
  * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
  * for newer versions we can use mmap to reduce memory usage:
-- 
2.20.1
