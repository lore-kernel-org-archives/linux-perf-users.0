From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/31] perf tools: Remove debug.h from places where it is not needed
Date: Fri, 20 Sep 2019 11:25:20 -0300
Message-ID: <20190920142542.12047-10-acme@kernel.org>
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

Pruning a bit more the includes dependency tree. Building this thing on
lots of containers takes time, we better reduce the time per build, each
container is doing 6 builds when clang and clang-devel are available,
and the plan is to do a 'make -C tools/perf build-test' that have many
more.

Also helps when doing normal development, as touching some random file
will have a much reduced chance of triggering lots of rebuilds.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-r889ur2cxe16m91m2a4pl15p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/unwind-libunwind.c | 2 +-
 tools/perf/arch/powerpc/util/sym-handling.c   | 1 -
 tools/perf/tests/clang.c                      | 1 -
 tools/perf/ui/browsers/header.c               | 1 -
 tools/perf/ui/gtk/helpline.c                  | 1 -
 tools/perf/ui/gtk/util.c                      | 1 -
 tools/perf/ui/helpline.c                      | 1 -
 tools/perf/ui/tui/helpline.c                  | 1 -
 tools/perf/ui/tui/util.c                      | 1 -
 tools/perf/util/branch.c                      | 1 -
 tools/perf/util/demangle-java.c               | 1 -
 tools/perf/util/libunwind/arm64.c             | 1 -
 tools/perf/util/libunwind/x86_32.c            | 1 -
 tools/perf/util/target.c                      | 1 -
 tools/perf/util/usage.c                       | 1 -
 tools/perf/util/zlib.c                        | 2 --
 16 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/tools/perf/arch/arm64/util/unwind-libunwind.c b/tools/perf/arch/arm64/util/unwind-libunwind.c
index 002520d4036b..1495a9523a23 100644
--- a/tools/perf/arch/arm64/util/unwind-libunwind.c
+++ b/tools/perf/arch/arm64/util/unwind-libunwind.c
@@ -5,8 +5,8 @@
 #include <libunwind.h>
 #include "perf_regs.h"
 #include "../../util/unwind.h"
-#include "../../util/debug.h"
 #endif
+#include "../../util/debug.h"
 
 int LIBUNWIND__ARCH_REG_ID(int regnum)
 {
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 8a4b717e0a53..abb7a12d8f93 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
  */
 
-#include "debug.h"
 #include "dso.h"
 #include "symbol.h"
 #include "map.h"
diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
index f45fe11dcf50..ff2711a40940 100644
--- a/tools/perf/tests/clang.c
+++ b/tools/perf/tests/clang.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tests.h"
-#include "debug.h"
 #include "util.h"
 #include "c++/clang-c.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/ui/browsers/header.c b/tools/perf/ui/browsers/header.c
index 0f59a7001479..57e6e4332f74 100644
--- a/tools/perf/ui/browsers/header.c
+++ b/tools/perf/ui/browsers/header.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util/debug.h"
 #include "ui/browser.h"
 #include "ui/keysyms.h"
 #include "ui/ui.h"
diff --git a/tools/perf/ui/gtk/helpline.c b/tools/perf/ui/gtk/helpline.c
index e166da9ec767..e40a006aead8 100644
--- a/tools/perf/ui/gtk/helpline.c
+++ b/tools/perf/ui/gtk/helpline.c
@@ -6,7 +6,6 @@
 #include "gtk.h"
 #include "../ui.h"
 #include "../helpline.h"
-#include "../../util/debug.h"
 
 static void gtk_helpline_pop(void)
 {
diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
index c2c558958b9c..c47f5c387838 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../util.h"
-#include "../../util/debug.h"
 #include "gtk.h"
 
 #include <stdlib.h>
diff --git a/tools/perf/ui/helpline.c b/tools/perf/ui/helpline.c
index 54bcd08df87e..e00901450f91 100644
--- a/tools/perf/ui/helpline.c
+++ b/tools/perf/ui/helpline.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "../util/debug.h"
 #include "helpline.h"
 #include "ui.h"
 #include "../util/util.h"
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 5f188f678c55..298d6af82fdd 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -6,7 +6,6 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 
-#include "../../util/debug.h"
 #include "../helpline.h"
 #include "../ui.h"
 #include "../libslang.h"
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 087d9ab054c8..b98dd0e31dc1 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -5,7 +5,6 @@
 #include <stdlib.h>
 #include <sys/ttydefaults.h>
 
-#include "../../util/debug.h"
 #include "../browser.h"
 #include "../keysyms.h"
 #include "../helpline.h"
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 9d1e090084a2..52261e5f718a 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,5 +1,4 @@
 #include "util/util.h"
-#include "util/debug.h"
 #include "util/map_symbol.h"
 #include "util/branch.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index 763328c151e9..6fb7f34c0814 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -3,7 +3,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include "debug.h"
 #include "symbol.h"
 
 #include "demangle-java.h"
diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
index 66756e6be111..6b4e5a0892f8 100644
--- a/tools/perf/util/libunwind/arm64.c
+++ b/tools/perf/util/libunwind/arm64.c
@@ -22,7 +22,6 @@
 #define LIBUNWIND__ARCH_REG_SP PERF_REG_ARM64_SP
 
 #include "unwind.h"
-#include "debug.h"
 #include "libunwind-aarch64.h"
 #include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
 #include "../../arch/arm64/util/unwind-libunwind.c"
diff --git a/tools/perf/util/libunwind/x86_32.c b/tools/perf/util/libunwind/x86_32.c
index c5e568188e19..21c216c40a3b 100644
--- a/tools/perf/util/libunwind/x86_32.c
+++ b/tools/perf/util/libunwind/x86_32.c
@@ -22,7 +22,6 @@
 #define LIBUNWIND__ARCH_REG_SP PERF_REG_X86_SP
 
 #include "unwind.h"
-#include "debug.h"
 #include "libunwind-x86.h"
 #include <../../../../arch/x86/include/uapi/asm/perf_regs.h>
 
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 565f7aef7e6c..e152d2bbe3a3 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -7,7 +7,6 @@
 
 #include "target.h"
 #include "util.h"
-#include "debug.h"
 
 #include <pwd.h>
 #include <stdio.h>
diff --git a/tools/perf/util/usage.c b/tools/perf/util/usage.c
index 3949a60b00ae..196438ee4c9d 100644
--- a/tools/perf/util/usage.c
+++ b/tools/perf/util/usage.c
@@ -8,7 +8,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "util.h"
-#include "debug.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/compiler.h>
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 59d456f716e9..deb6e69adb5a 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -10,8 +10,6 @@
 
 #include "util/compress.h"
 #include "util/util.h"
-#include "util/debug.h"
-
 
 #define CHUNK_SIZE  16384
 
-- 
2.21.0
