From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/22] perf maps: Rename map_groups.h to maps.h
Date: Thu, 28 Nov 2019 10:40:17 -0300
Message-ID: <20191128134027.23726-13-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step in the merge of 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9ibtn3vua76f934t7woyf26w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     | 2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c   | 2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c     | 2 +-
 tools/perf/tests/map_groups.c                | 2 +-
 tools/perf/ui/stdio/hist.c                   | 2 +-
 tools/perf/util/annotate.c                   | 2 +-
 tools/perf/util/machine.h                    | 2 +-
 tools/perf/util/{map_groups.h => maps.h}     | 6 +++---
 tools/perf/util/probe-event.c                | 2 +-
 tools/perf/util/symbol-elf.c                 | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)
 rename tools/perf/util/{map_groups.h => maps.h} (96%)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index ff0bea660cf9..ccfa87055c4a 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -3,7 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index 85108437b3af..46147a483049 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -3,7 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index 30658e3b32b2..8efd9ed9e9db 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -3,7 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 418969cd64e9..ef43be9b6ec2 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -3,7 +3,7 @@
 #include "perf_regs.h"
 #include "thread.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index 9df1d14db40e..7febd02069ae 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -3,7 +3,7 @@
 #include <linux/kernel.h>
 #include "tests.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "dso.h"
 #include "debug.h"
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 161d8342ce05..2ab2af4d4849 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -8,7 +8,7 @@
 #include "../../util/event.h"
 #include "../../util/hist.h"
 #include "../../util/map.h"
-#include "../../util/map_groups.h"
+#include "../../util/maps.h"
 #include "../../util/symbol.h"
 #include "../../util/sort.h"
 #include "../../util/evsel.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 14f3edc3c261..f5e77ed237e8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -23,7 +23,7 @@
 #include "dso.h"
 #include "env.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "symbol.h"
 #include "srcline.h"
 #include "units.h"
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index fe602cfc2163..be0a930eca89 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -4,7 +4,7 @@
 
 #include <sys/types.h>
 #include <linux/rbtree.h>
-#include "map_groups.h"
+#include "maps.h"
 #include "dsos.h"
 #include "rwsem.h"
 
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/maps.h
similarity index 96%
rename from tools/perf/util/map_groups.h
rename to tools/perf/util/maps.h
index ada2f401ebab..3dd000ddf925 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/maps.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_MAP_GROUPS_H
-#define __PERF_MAP_GROUPS_H
+#ifndef __PERF_MAPS_H
+#define __PERF_MAPS_H
 
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
@@ -84,4 +84,4 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
 void __maps__sort_by_name(struct maps *maps);
 
-#endif // __PERF_MAP_GROUPS_H
+#endif // __PERF_MAPS_H
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c06cc9764c3b..eea132f512b0 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -28,7 +28,7 @@
 #include "dso.h"
 #include "color.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "symbol.h"
 #include <api/fs/fs.h>
 #include "trace-event.h"	/* For __maybe_unused */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index fac3f585e9b4..6658fbf196e6 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -9,7 +9,7 @@
 
 #include "dso.h"
 #include "map.h"
-#include "map_groups.h"
+#include "maps.h"
 #include "symbol.h"
 #include "symsrc.h"
 #include "demangle-java.h"
-- 
2.21.0
