From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/47] perf tools: Remove perf.h from source files not needing it
Date: Sun,  1 Sep 2019 09:22:53 -0300
Message-ID: <20190901122326.5793-15-acme@kernel.org>
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

With the movement of lots of stuff out of perf.h to other headers we
ended up not needing it in lots of places, remove it from those places.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c718m0sxxwp73lp9d8vpihb4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/perf_regs.c               | 1 -
 tools/perf/arch/x86/tests/intel-cqm.c                  | 1 -
 tools/perf/arch/x86/util/archinsn.c                    | 1 -
 tools/perf/arch/x86/util/tsc.c                         | 1 -
 tools/perf/bench/numa.c                                | 1 -
 tools/perf/bench/sched-messaging.c                     | 1 -
 tools/perf/bench/sched-pipe.c                          | 1 -
 tools/perf/builtin-bench.c                             | 1 -
 tools/perf/builtin-buildid-cache.c                     | 1 -
 tools/perf/builtin-buildid-list.c                      | 1 -
 tools/perf/builtin-config.c                            | 2 --
 tools/perf/builtin-ftrace.c                            | 1 -
 tools/perf/builtin-help.c                              | 1 -
 tools/perf/builtin-inject.c                            | 1 -
 tools/perf/builtin-list.c                              | 2 --
 tools/perf/builtin-probe.c                             | 1 -
 tools/perf/scripts/perl/Perf-Trace-Util/Context.c      | 1 -
 tools/perf/scripts/python/Perf-Trace-Util/Context.c    | 1 -
 tools/perf/tests/hists_common.c                        | 1 -
 tools/perf/tests/hists_cumulate.c                      | 1 -
 tools/perf/tests/hists_filter.c                        | 1 -
 tools/perf/tests/hists_link.c                          | 1 -
 tools/perf/tests/hists_output.c                        | 1 -
 tools/perf/ui/browser.c                                | 1 -
 tools/perf/util/bpf-loader.c                           | 1 -
 tools/perf/util/bpf-prologue.c                         | 1 -
 tools/perf/util/branch.c                               | 1 -
 tools/perf/util/cacheline.c                            | 1 -
 tools/perf/util/cgroup.c                               | 1 -
 tools/perf/util/cpumap.c                               | 1 -
 tools/perf/util/debug.c                                | 2 --
 tools/perf/util/event.c                                | 1 -
 tools/perf/util/genelf.c                               | 1 -
 tools/perf/util/genelf_debug.c                         | 1 -
 tools/perf/util/header.c                               | 1 -
 tools/perf/util/intel-pt.c                             | 1 -
 tools/perf/util/parse-branch-options.c                 | 1 -
 tools/perf/util/parse-events.c                         | 1 -
 tools/perf/util/scripting-engines/trace-event-perl.c   | 1 -
 tools/perf/util/scripting-engines/trace-event-python.c | 1 -
 tools/perf/util/svghelper.c                            | 1 -
 tools/perf/util/thread.c                               | 1 -
 tools/perf/util/time-utils.c                           | 1 -
 tools/perf/util/trace-event-info.c                     | 1 -
 tools/perf/util/trace-event-parse.c                    | 1 -
 tools/perf/util/trace-event-read.c                     | 1 -
 tools/perf/util/trace-event-scripting.c                | 1 -
 tools/perf/util/util.c                                 | 1 -
 48 files changed, 51 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index f14102b85509..e9c436eeffc9 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -4,7 +4,6 @@
 #include <regex.h>
 #include <linux/zalloc.h>
 
-#include "../../perf.h"
 #include "../../util/perf_regs.h"
 #include "../../util/debug.h"
 
diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 2a105e3b2ad1..3b5cc3373821 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tests/tests.h"
-#include "perf.h"
 #include "cloexec.h"
 #include "debug.h"
 #include "evlist.h"
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
index 4237bb2e7fa2..62e8e1820132 100644
--- a/tools/perf/arch/x86/util/archinsn.c
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "archinsn.h"
 #include "util/intel-pt-decoder/insn.h"
 #include "machine.h"
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index a6ba45d0db6e..c5197a15119b 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -5,7 +5,6 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../../perf.h"
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include "../../../util/debug.h"
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 513cb2f2fa32..62b8ef4bcb1f 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -9,7 +9,6 @@
 /* For the CLR_() macros */
 #include <pthread.h>
 
-#include "../perf.h"
 #include "../builtin.h"
 #include <subcmd/parse-options.h>
 #include "../util/cloexec.h"
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index f9d7641ae833..c63eb9a46346 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -10,7 +10,6 @@
  *
  */
 
-#include "../perf.h"
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
 #include "../builtin.h"
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 0591be008f2a..35b07f197d48 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -9,7 +9,6 @@
  *  http://people.redhat.com/mingo/cfs-scheduler/tools/pipe-test-1m.c
  * Ported to perf by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
  */
-#include "../perf.h"
 #include "../util/util.h"
 #include <subcmd/parse-options.h>
 #include "../builtin.h"
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index b8e7c38ef221..c06fe21c8613 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -16,7 +16,6 @@
  *  futex ... Futex performance
  *  epoll ... Event poll performance
  */
-#include "perf.h"
 #include <subcmd/parse-options.h>
 #include "builtin.h"
 #include "bench/bench.h"
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 7dde3ef0398f..9e756004ef28 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -14,7 +14,6 @@
 #include <errno.h>
 #include <unistd.h>
 #include "builtin.h"
-#include "perf.h"
 #include "namespaces.h"
 #include "util/cache.h"
 #include "util/debug.h"
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index f403e19488b5..72bdc0eba990 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 /*
  * builtin-buildid-list.c
  *
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 6c1284c87aaa..edfc8f76f1bd 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -7,8 +7,6 @@
  */
 #include "builtin.h"
 
-#include "perf.h"
-
 #include "util/cache.h"
 #include <subcmd/parse-options.h>
 #include "util/util.h"
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 565db782c1b9..7374f86833fd 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -6,7 +6,6 @@
  */
 
 #include "builtin.h"
-#include "perf.h"
 
 #include <errno.h>
 #include <unistd.h>
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index a83af92fb0d1..641d4a3f93c3 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -4,7 +4,6 @@
  *
  * Builtin help command
  */
-#include "perf.h"
 #include "util/config.h"
 #include "builtin.h"
 #include <subcmd/exec-cmd.h>
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 040142581d20..ae46de46e826 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -8,7 +8,6 @@
  */
 #include "builtin.h"
 
-#include "perf.h"
 #include "util/color.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e0312a1c4792..dca0d33c1343 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -10,8 +10,6 @@
  */
 #include "builtin.h"
 
-#include "perf.h"
-
 #include "util/parse-events.h"
 #include "util/cache.h"
 #include "util/pmu.h"
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 3d0ffd41fb55..f45fd7e9723e 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -16,7 +16,6 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "perf.h"
 #include "builtin.h"
 #include "namespaces.h"
 #include "util/strlist.h"
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Context.c b/tools/perf/scripts/perl/Perf-Trace-Util/Context.c
index ead521dd8d79..25c47d23a130 100644
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/perl/Perf-Trace-Util/Context.c
@@ -19,7 +19,6 @@
 #include "EXTERN.h"
 #include "perl.h"
 #include "XSUB.h"
-#include "../../../perf.h"
 #include "../../../util/trace-event.h"
 
 #ifndef PERL_UNUSED_VAR
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 217568bc29ce..0b7096847991 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -6,7 +6,6 @@
  */
 
 #include <Python.h>
-#include "../../../perf.h"
 #include "../../../util/trace-event.h"
 
 #if PY_MAJOR_VERSION < 3
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index 469958cd7fe0..96ad95d3f338 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
-#include "perf.h"
 #include "util/debug.h"
 #include "util/map.h"
 #include "util/symbol.h"
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 1f3de85ae18b..93af420ad2e4 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/map.h"
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index a274716fc438..41dede2f40d8 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "util/debug.h"
 #include "util/map.h"
 #include "util/symbol.h"
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index b25383aa2e6e..012fe8ac0b24 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "tests.h"
 #include "debug.h"
 #include "symbol.h"
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 009888adf4b3..07f4ca0704fb 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/map.h"
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index c797a853d3a0..f93d40b1c203 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -2,7 +2,6 @@
 #include "../util/util.h"
 #include "../util/string2.h"
 #include "../util/config.h"
-#include "../perf.h"
 #include "libslang.h"
 #include "ui.h"
 #include "util.h"
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 80a828e75cf6..c1a57323e25d 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <errno.h>
-#include "perf.h"
 #include "debug.h"
 #include "evlist.h"
 #include "bpf-loader.h"
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 77e4891e17b0..09e6c76e1c3b 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -8,7 +8,6 @@
  */
 
 #include <bpf/libbpf.h>
-#include "perf.h"
 #include "debug.h"
 #include "bpf-loader.h"
 #include "bpf-prologue.h"
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index a4fce2729e50..02d6d839ff24 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,4 +1,3 @@
-#include "perf.h"
 #include "util/util.h"
 #include "util/debug.h"
 #include "util/branch.h"
diff --git a/tools/perf/util/cacheline.c b/tools/perf/util/cacheline.c
index 9361d3f61f75..e98b5250a517 100644
--- a/tools/perf/util/cacheline.c
+++ b/tools/perf/util/cacheline.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "cacheline.h"
-#include "../perf.h"
 #include <unistd.h>
 
 #ifdef _SC_LEVEL1_DCACHE_LINESIZE
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index f73599f271ff..96a931c6f728 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../perf.h"
 #include <subcmd/parse-options.h>
 #include "evsel.h"
 #include "cgroup.h"
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b9301e7e9c76..a22c1114e880 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <api/fs/fs.h>
-#include "../perf.h"
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 3780fe42453b..c822c5943340 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* For general debugging purposes */
 
-#include "../perf.h"
-
 #include <inttypes.h>
 #include <string.h>
 #include <stdarg.h>
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index ef7fc574f701..54169ad335c7 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
index bc32f405b26e..f9f18b8b1df9 100644
--- a/tools/perf/util/genelf.c
+++ b/tools/perf/util/genelf.c
@@ -23,7 +23,6 @@
 #include <dwarf.h>
 #endif
 
-#include "perf.h"
 #include "genelf.h"
 #include "../util/jitdump.h"
 #include <linux/compiler.h>
diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genelf_debug.c
index 995e490c17fa..30e9f618f6cd 100644
--- a/tools/perf/util/genelf_debug.c
+++ b/tools/perf/util/genelf_debug.c
@@ -24,7 +24,6 @@
 #include <err.h>
 #include <dwarf.h>
 
-#include "perf.h"
 #include "genelf.h"
 #include "../util/jitdump.h"
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d252124f926d..20fb06162fd4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -26,7 +26,6 @@
 #include "evsel.h"
 #include "header.h"
 #include "memswap.h"
-#include "../perf.h"
 #include "trace-event.h"
 #include "session.h"
 #include "symbol.h"
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 825a6a3b03a1..825e3690940d 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
-#include "../perf.h"
 #include "session.h"
 #include "machine.h"
 #include "memswap.h"
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 4ed20c833d44..1430437b9d51 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "perf.h"
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-branch-options.h"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9101568946d2..5f1ba6820cdd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -10,7 +10,6 @@
 #include <fcntl.h>
 #include <sys/param.h>
 #include "term.h"
-#include "../perf.h"
 #include "evlist.h"
 #include "evsel.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 01ebf10b8bf4..800e82d35230 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -34,7 +34,6 @@
 #include <EXTERN.h>
 #include <perl.h>
 
-#include "../../perf.h"
 #include "../callchain.h"
 #include "../machine.h"
 #include "../map.h"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 78c8bc9380bd..abfde356be18 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -31,7 +31,6 @@
 #include <linux/compiler.h>
 #include <linux/time64.h>
 
-#include "../../perf.h"
 #include "../counts.h"
 #include "../debug.h"
 #include "../callchain.h"
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index fef0f8a40e2f..582f4a69cd48 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -20,7 +20,6 @@
 #include <perf/cpumap.h>
 
 #include "env.h"
-#include "perf.h"
 #include "svghelper.h"
 #include "cpumap.h"
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index dbcb9cfb0f2f..5ba1601e8860 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../perf.h"
 #include <errno.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index c2abc259b51d..9796a2e43f67 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -10,7 +10,6 @@
 #include <math.h>
 #include <linux/ctype.h>
 
-#include "perf.h"
 #include "debug.h"
 #include "time-utils.h"
 #include "session.h"
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 2f8a0601a546..d63d542b2cde 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 
-#include "../perf.h"
 #include "trace-event.h"
 #include <api/fs/tracing_path.h>
 #include "evsel.h"
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index b3982e1bb4c5..8e31a63045c3 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -7,7 +7,6 @@
 #include <string.h>
 #include <errno.h>
 
-#include "../perf.h"
 #include "debug.h"
 #include "trace-event.h"
 
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 13c1cf60d1bc..b6c0db068be0 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <errno.h>
 
-#include "../perf.h"
 #include "util.h"
 #include "trace-event.h"
 #include "debug.h"
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index dfd2640c763a..714581b0de65 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -10,7 +10,6 @@
 #include <string.h>
 #include <errno.h>
 
-#include "../perf.h"
 #include "debug.h"
 #include "trace-event.h"
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 44211e483fbf..607daec22943 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../perf.h"
 #include "util.h"
 #include "debug.h"
 #include "namespaces.h"
-- 
2.21.0
