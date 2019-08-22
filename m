From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/25] perf evlist: Add missing xyarray.h header
Date: Thu, 22 Aug 2019 18:00:46 -0300
Message-ID: <20190822210100.3461-12-acme@kernel.org>
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

It gets it very indirectly, via evsel.h -> counts.h, and since counts.h
doesn't need xyarray.h at all, add it here before we remove it there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hkizv6gojwfklj9ezaiiztll@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8582560b59af..68b7c949017e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -37,6 +37,8 @@
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
 
+#include <internal/xyarray.h>
+
 #ifdef LACKS_SIGQUEUE_PROTOTYPE
 int sigqueue(pid_t pid, int sig, const union sigval value);
 #endif
-- 
2.21.0
