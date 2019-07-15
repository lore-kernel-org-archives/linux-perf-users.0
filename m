From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/28] perf tools: Introduce rlimit__bump_memlock() helper
Date: Mon, 15 Jul 2019 18:11:33 -0300
Message-ID: <20190715211200.10984-2-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like the BPF guys did when faced with failures with map creation,
etc, i.e. their solution is:

  tools/testing/selftests/bpf/bpf_rlimit.h

For perf use this function in 'perf test' and in 'perf trace'.

Make it bump to 4 times the current value, if it fails twice the current
value and if it still fails, warn that things like BPF map creation may
fail, to help in diagnosing the problem.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-muvqef2i7n6pzqbmu7tn2d2y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build    |  1 +
 tools/perf/util/rlimit.c | 29 +++++++++++++++++++++++++++++
 tools/perf/util/rlimit.h |  6 ++++++
 3 files changed, 36 insertions(+)
 create mode 100644 tools/perf/util/rlimit.c
 create mode 100644 tools/perf/util/rlimit.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index d7e3b008a613..14f812bb07a7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -20,6 +20,7 @@ perf-y += parse-events.o
 perf-y += perf_regs.o
 perf-y += path.o
 perf-y += print_binary.o
+perf-y += rlimit.o
 perf-y += argv_split.o
 perf-y += rbtree.o
 perf-y += libstring.o
diff --git a/tools/perf/util/rlimit.c b/tools/perf/util/rlimit.c
new file mode 100644
index 000000000000..13521d392a22
--- /dev/null
+++ b/tools/perf/util/rlimit.c
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+
+#include "util/debug.h"
+#include "util/rlimit.h"
+#include <sys/time.h>
+#include <sys/resource.h>
+
+/*
+ * Bump the memlock so that we can get bpf maps of a reasonable size,
+ * like the ones used with 'perf trace' and with 'perf test bpf',
+ * improve this to some specific request if needed.
+ */
+void rlimit__bump_memlock(void)
+{
+	struct rlimit rlim;
+
+	if (getrlimit(RLIMIT_MEMLOCK, &rlim) == 0) {
+		rlim.rlim_cur *= 4;
+		rlim.rlim_max *= 4;
+
+		if (setrlimit(RLIMIT_MEMLOCK, &rlim) < 0) {
+			rlim.rlim_cur /= 2;
+			rlim.rlim_max /= 2;
+
+			if (setrlimit(RLIMIT_MEMLOCK, &rlim) < 0)
+				pr_debug("Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc\n");
+		}
+	}
+}
diff --git a/tools/perf/util/rlimit.h b/tools/perf/util/rlimit.h
new file mode 100644
index 000000000000..9f59d8e710a3
--- /dev/null
+++ b/tools/perf/util/rlimit.h
@@ -0,0 +1,6 @@
+#ifndef __PERF_RLIMIT_H_
+#define __PERF_RLIMIT_H_
+/* SPDX-License-Identifier: LGPL-2.1 */
+
+void rlimit__bump_memlock(void);
+#endif // __PERF_RLIMIT_H_
-- 
2.21.0
