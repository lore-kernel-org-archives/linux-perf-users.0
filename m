From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/6] tools: Fix off-by 1 relative directory includes
Date: Fri,  6 Mar 2020 16:11:44 -0300
Message-ID: <20200306191144.12762-12-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexios Zavras <alexios.zavras@intel.com>, Andi Kleen <ak@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Igor Lubashev <ilubashe@akamai.com>, Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Wei Li <liw>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

This is currently working due to extra include paths in the build.

Committer testing:

  $ cd tools/include/uapi/asm/

Before this patch:

  $ ls -la ../../arch/x86/include/uapi/asm/errno.h
  ls: cannot access '../../arch/x86/include/uapi/asm/errno.h': No such file or directory
  $

After this patch;

  $ ls -la ../../../arch/x86/include/uapi/asm/errno.h
  -rw-rw-r--. 1 acme acme 31 Feb 20 12:42 ../../../arch/x86/include/uapi/asm/errno.h
  $

Check that that is still under tools/, i.e. hasn't escaped into the main
kernel sources:

  $ cd ../../../arch/x86/include/uapi/asm/
  $ pwd
  /home/acme/git/perf/tools/arch/x86/include/uapi/asm
  $

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Link: http://lore.kernel.org/lkml/20200306071110.130202-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm/errno.h           | 14 +++++------
 tools/perf/arch/arm64/util/arm-spe.c     | 20 ++++++++--------
 tools/perf/arch/arm64/util/perf_regs.c   |  2 +-
 tools/perf/arch/powerpc/util/perf_regs.c |  4 ++--
 tools/perf/arch/x86/util/auxtrace.c      | 14 +++++------
 tools/perf/arch/x86/util/event.c         | 12 +++++-----
 tools/perf/arch/x86/util/header.c        |  4 ++--
 tools/perf/arch/x86/util/intel-bts.c     | 24 +++++++++----------
 tools/perf/arch/x86/util/intel-pt.c      | 30 ++++++++++++------------
 tools/perf/arch/x86/util/machine.c       |  6 ++---
 tools/perf/arch/x86/util/perf_regs.c     |  8 +++----
 tools/perf/arch/x86/util/pmu.c           |  6 ++---
 12 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/tools/include/uapi/asm/errno.h b/tools/include/uapi/asm/errno.h
index ce3c5945a1c4..637189ec1ab9 100644
--- a/tools/include/uapi/asm/errno.h
+++ b/tools/include/uapi/asm/errno.h
@@ -1,18 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #if defined(__i386__) || defined(__x86_64__)
-#include "../../arch/x86/include/uapi/asm/errno.h"
+#include "../../../arch/x86/include/uapi/asm/errno.h"
 #elif defined(__powerpc__)
-#include "../../arch/powerpc/include/uapi/asm/errno.h"
+#include "../../../arch/powerpc/include/uapi/asm/errno.h"
 #elif defined(__sparc__)
-#include "../../arch/sparc/include/uapi/asm/errno.h"
+#include "../../../arch/sparc/include/uapi/asm/errno.h"
 #elif defined(__alpha__)
-#include "../../arch/alpha/include/uapi/asm/errno.h"
+#include "../../../arch/alpha/include/uapi/asm/errno.h"
 #elif defined(__mips__)
-#include "../../arch/mips/include/uapi/asm/errno.h"
+#include "../../../arch/mips/include/uapi/asm/errno.h"
 #elif defined(__ia64__)
-#include "../../arch/ia64/include/uapi/asm/errno.h"
+#include "../../../arch/ia64/include/uapi/asm/errno.h"
 #elif defined(__xtensa__)
-#include "../../arch/xtensa/include/uapi/asm/errno.h"
+#include "../../../arch/xtensa/include/uapi/asm/errno.h"
 #else
 #include <asm-generic/errno.h>
 #endif
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 8d6821d9c3f6..27653be24447 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -11,17 +11,17 @@
 #include <linux/zalloc.h>
 #include <time.h>
 
-#include "../../util/cpumap.h"
-#include "../../util/event.h"
-#include "../../util/evsel.h"
-#include "../../util/evlist.h"
-#include "../../util/session.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/event.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evlist.h"
+#include "../../../util/session.h"
 #include <internal/lib.h> // page_size
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/auxtrace.h"
-#include "../../util/record.h"
-#include "../../util/arm-spe.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/record.h"
+#include "../../../util/arm-spe.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 2864e2e3776d..2833e101a7c6 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../../util/perf_regs.h"
+#include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG_END
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index e9c436eeffc9..0a5242900248 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -4,8 +4,8 @@
 #include <regex.h>
 #include <linux/zalloc.h>
 
-#include "../../util/perf_regs.h"
-#include "../../util/debug.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/debug.h"
 
 #include <linux/kernel.h>
 
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 7abc9fd4cbec..3da506e13f49 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -7,13 +7,13 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include "../../util/header.h"
-#include "../../util/debug.h"
-#include "../../util/pmu.h"
-#include "../../util/auxtrace.h"
-#include "../../util/intel-pt.h"
-#include "../../util/intel-bts.h"
-#include "../../util/evlist.h"
+#include "../../../util/header.h"
+#include "../../../util/debug.h"
+#include "../../../util/pmu.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/intel-pt.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/evlist.h"
 
 static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index ac45015cc6ba..047dc00eafa6 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -3,12 +3,12 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-#include "../../util/event.h"
-#include "../../util/synthetic-events.h"
-#include "../../util/machine.h"
-#include "../../util/tool.h"
-#include "../../util/map.h"
-#include "../../util/debug.h"
+#include "../../../util/event.h"
+#include "../../../util/synthetic-events.h"
+#include "../../../util/machine.h"
+#include "../../../util/tool.h"
+#include "../../../util/map.h"
+#include "../../../util/debug.h"
 
 #if defined(__x86_64__)
 
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index aa6deb463bf3..578c8c568ffd 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -7,8 +7,8 @@
 #include <string.h>
 #include <regex.h>
 
-#include "../../util/debug.h"
-#include "../../util/header.h"
+#include "../../../util/debug.h"
+#include "../../../util/header.h"
 
 static inline void
 cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 26cee1052179..09f93800bffd 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -11,18 +11,18 @@
 #include <linux/log2.h>
 #include <linux/zalloc.h>
 
-#include "../../util/cpumap.h"
-#include "../../util/event.h"
-#include "../../util/evsel.h"
-#include "../../util/evlist.h"
-#include "../../util/mmap.h"
-#include "../../util/session.h"
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/record.h"
-#include "../../util/tsc.h"
-#include "../../util/auxtrace.h"
-#include "../../util/intel-bts.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/event.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evlist.h"
+#include "../../../util/mmap.h"
+#include "../../../util/session.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/record.h"
+#include "../../../util/tsc.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/intel-bts.h"
 #include <internal/lib.h> // page_size
 
 #define KiB(x) ((x) * 1024)
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 7eea4fd7ce58..1643aed8c4c8 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -13,23 +13,23 @@
 #include <linux/zalloc.h>
 #include <cpuid.h>
 
-#include "../../util/session.h"
-#include "../../util/event.h"
-#include "../../util/evlist.h"
-#include "../../util/evsel.h"
-#include "../../util/evsel_config.h"
-#include "../../util/cpumap.h"
-#include "../../util/mmap.h"
+#include "../../../util/session.h"
+#include "../../../util/event.h"
+#include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
+#include "../../../util/evsel_config.h"
+#include "../../../util/cpumap.h"
+#include "../../../util/mmap.h"
 #include <subcmd/parse-options.h>
-#include "../../util/parse-events.h"
-#include "../../util/pmu.h"
-#include "../../util/debug.h"
-#include "../../util/auxtrace.h"
-#include "../../util/record.h"
-#include "../../util/target.h"
-#include "../../util/tsc.h"
+#include "../../../util/parse-events.h"
+#include "../../../util/pmu.h"
+#include "../../../util/debug.h"
+#include "../../../util/auxtrace.h"
+#include "../../../util/record.h"
+#include "../../../util/target.h"
+#include "../../../util/tsc.h"
 #include <internal/lib.h> // page_size
-#include "../../util/intel-pt.h"
+#include "../../../util/intel-pt.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index e17e080e76f4..31679c35d493 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -5,9 +5,9 @@
 #include <stdlib.h>
 
 #include <internal/lib.h> // page_size
-#include "../../util/machine.h"
-#include "../../util/map.h"
-#include "../../util/symbol.h"
+#include "../../../util/machine.h"
+#include "../../../util/map.h"
+#include "../../../util/symbol.h"
 #include <linux/ctype.h>
 
 #include <symbol/kallsyms.h>
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index c218b83e063b..fca81b39b09f 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -5,10 +5,10 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
-#include "../../perf-sys.h"
-#include "../../util/perf_regs.h"
-#include "../../util/debug.h"
-#include "../../util/event.h"
+#include "../../../perf-sys.h"
+#include "../../../util/perf_regs.h"
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
 
 const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(AX, PERF_REG_X86_AX),
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index e33ef5bc31c5..d48d608517fd 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -4,9 +4,9 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../util/intel-pt.h"
-#include "../../util/intel-bts.h"
-#include "../../util/pmu.h"
+#include "../../../util/intel-pt.h"
+#include "../../../util/intel-bts.h"
+#include "../../../util/pmu.h"
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
-- 
2.21.1
