From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/25] perf tests: Add missing SPDX headers
Date: Fri, 21 Jun 2019 14:38:24 -0300
Message-ID: <20190621173831.13780-19-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p0kg493z2m8qizjbdefzip1i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build                                    | 2 ++
 tools/perf/tests/bp_account.c                             | 1 +
 tools/perf/tests/bpf-script-example.c                     | 1 +
 tools/perf/tests/bpf-script-test-kbuild.c                 | 1 +
 tools/perf/tests/bpf-script-test-prologue.c               | 1 +
 tools/perf/tests/bpf-script-test-relocation.c             | 1 +
 tools/perf/tests/bpf.c                                    | 1 +
 tools/perf/tests/map_groups.c                             | 1 +
 tools/perf/tests/mem.c                                    | 1 +
 tools/perf/tests/mem2node.c                               | 1 +
 tools/perf/tests/shell/lib/probe.sh                       | 1 +
 tools/perf/tests/shell/probe_vfs_getname.sh               | 3 ++-
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 1 +
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 1 +
 tools/perf/tests/shell/record+zstd_comp_decomp.sh         | 2 ++
 tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 1 +
 16 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index e3ba63cef01e..e72accefd669 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 perf-y += builtin-test.o
 perf-y += parse-events.o
 perf-y += dso-data.o
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 57fc544aedb0..153624e2d0f5 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Powerpc needs __SANE_USERSPACE_TYPES__ before <linux/types.h> to select
  * 'int-ll64.h' and avoid compile warnings when printing __u64 with %llu.
diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index 1ca5106df5f1..ab4b98b3165d 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bpf-script-example.c
  * Test basic LLVM building
diff --git a/tools/perf/tests/bpf-script-test-kbuild.c b/tools/perf/tests/bpf-script-test-kbuild.c
index ff3ec8337f0a..219673aa278f 100644
--- a/tools/perf/tests/bpf-script-test-kbuild.c
+++ b/tools/perf/tests/bpf-script-test-kbuild.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bpf-script-test-kbuild.c
  * Test include from kernel header
diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
index 43f1e16486f4..bd83d364cf30 100644
--- a/tools/perf/tests/bpf-script-test-prologue.c
+++ b/tools/perf/tests/bpf-script-test-prologue.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bpf-script-test-prologue.c
  * Test BPF prologue
diff --git a/tools/perf/tests/bpf-script-test-relocation.c b/tools/perf/tests/bpf-script-test-relocation.c
index 93af77421816..74006e4b2d24 100644
--- a/tools/perf/tests/bpf-script-test-relocation.c
+++ b/tools/perf/tests/bpf-script-test-relocation.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bpf-script-test-relocation.c
  * Test BPF loader checking relocation
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 79b54f8ddebf..c9e4cdc4c9c8 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <stdio.h>
 #include <sys/epoll.h>
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
index 70d96acc6dcf..594fdaca4f71 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/map_groups.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include "tests.h"
diff --git a/tools/perf/tests/mem.c b/tools/perf/tests/mem.c
index 0f82ee9fd3f7..efe3397824d2 100644
--- a/tools/perf/tests/mem.c
+++ b/tools/perf/tests/mem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include "util/mem-events.h"
 #include "util/symbol.h"
 #include "linux/perf_event.h"
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 9e9e4d37cc77..d23ff1b68eba 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/bitmap.h>
 #include "cpumap.h"
diff --git a/tools/perf/tests/shell/lib/probe.sh b/tools/perf/tests/shell/lib/probe.sh
index e37787be672b..51e3f60baba0 100644
--- a/tools/perf/tests/shell/lib/probe.sh
+++ b/tools/perf/tests/shell/lib/probe.sh
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 skip_if_no_perf_probe() {
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 46e076e3c537..5d1b63d3f3e1 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # Add vfs_getname probe to get syscall args filenames
-#
+
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 61c9f8fc6fa1..9b7632ff70aa 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -7,6 +7,7 @@
 # This needs no debuginfo package, all is done using the libc ELF symtab
 # and the CFI info in the binaries.
 
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 9b073e7fa88c..54030c18bfc2 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -6,6 +6,7 @@
 # checks that that was captured by the vfs_getname probe in the generated
 # perf.data file, with the temp file name as the pathname argument.
 
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 5dcba800109f..899604d17b85 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # Zstd perf.data compression/decompression
 
+# SPDX-License-Identifier: GPL-2.0
+
 trace_file=$(mktemp /tmp/perf.data.XXX)
 perf_tool=perf
 
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 147efeb6b195..45d269b0157e 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -7,6 +7,7 @@
 # that already handles "probe:vfs_getname" if present, and used in the
 # "open" syscall "filename" argument beautifier.
 
+# SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
 . $(dirname $0)/lib/probe.sh
-- 
2.20.1
