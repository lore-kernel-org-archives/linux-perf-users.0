From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/43] perf trace beauty futex: Beautify FUTEX_BITSET_MATCH_ANY
Date: Tue, 23 Jan 2018 10:12:49 -0300
Message-ID: <20180123131251.28197-42-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

E.g.:

  # strace -e futex -p 14437
  strace: Process 14437 attached
  futex(0x7f46f4808d70, FUTEX_WAKE_PRIVATE, 1) = 0
  futex(0x7f46f24e68b0, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0, {tv_sec=1516636744, tv_nsec=221969000}, 0xffffffff) = -1 ETIMEDOUT (Connection timed out)
 <detached ...>
  #

Should pretty print that 0xffffffff value, like:

  # trace -e futex --tid 14437
     0.028 (   0.005 ms): futex(uaddr: 0x7f46f4808d70, op: WAKE|PRIV, val: 1                    ) = 0
     0.037 (1000.092 ms): futex(uaddr: 0x7f46f24e68b0, op: WAIT_BITSET|PRIV|CLKRT, utime: 0x7f46f23fedf0, val3: MATCH_ANY) = -1 ETIMEDOUT Connection timed out
^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-raef6e352la90600yksthao1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c           |  4 +++-
 tools/perf/trace/beauty/futex_val3.c | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/trace/beauty/futex_val3.c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ab00096328e4..46d3ff09440c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -549,6 +549,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/flock.c"
 #include "trace/beauty/futex_op.c"
+#include "trace/beauty/futex_val3.c"
 #include "trace/beauty/mmap.c"
 #include "trace/beauty/mode_t.c"
 #include "trace/beauty/msg_flags.c"
@@ -611,7 +612,8 @@ static struct syscall_fmt {
 	{ .name	    = "fstat", .alias = "newfstat", },
 	{ .name	    = "fstatat", .alias = "newfstatat", },
 	{ .name	    = "futex",
-	  .arg = { [1] = { .scnprintf = SCA_FUTEX_OP, /* op */ }, }, },
+	  .arg = { [1] = { .scnprintf = SCA_FUTEX_OP, /* op */ },
+		   [5] = { .scnprintf = SCA_FUTEX_VAL3, /* val3 */ }, }, },
 	{ .name	    = "futimesat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "getitimer",
diff --git a/tools/perf/trace/beauty/futex_val3.c b/tools/perf/trace/beauty/futex_val3.c
new file mode 100644
index 000000000000..26f6b3253511
--- /dev/null
+++ b/tools/perf/trace/beauty/futex_val3.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/futex.h>
+
+#ifndef FUTEX_BITSET_MATCH_ANY
+#define FUTEX_BITSET_MATCH_ANY 0xffffffff
+#endif
+
+static size_t syscall_arg__scnprintf_futex_val3(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned int bitset = arg->val;
+
+	if (bitset == FUTEX_BITSET_MATCH_ANY)
+		return scnprintf(bf, size, "MATCH_ANY");
+
+	return scnprintf(bf, size, "%#xd", bitset);
+}
+
+#define SCA_FUTEX_VAL3  syscall_arg__scnprintf_futex_val3
-- 
2.14.3
