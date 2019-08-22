From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/25] perf bpf: Add missing xyarray.h header
Date: Thu, 22 Aug 2019 18:00:45 -0300
Message-ID: <20190822210100.3461-11-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This was being obtained indirectly via evsel.h -> counts.h, since we
don't need xyarray in counts.h, we need to add it here explicitely
before removing it from counts.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-jirmxg527i82yz31bwad9we7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 9c219d413e57..e20d7c5e1925 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -26,6 +26,8 @@
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
 
+#include <internal/xyarray.h>
+
 static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
 			      const char *fmt, va_list args)
 {
-- 
2.21.0
