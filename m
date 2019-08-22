From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/25] perf tests: Add missing counts.h
Date: Thu, 22 Aug 2019 18:00:48 -0300
Message-ID: <20190822210100.3461-14-acme@kernel.org>
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

Those are getting counts.h via evsel.h, that don't strictly need
counts.h, just forward declarations for some structs, so add it here
before we remove it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-phldqlfxxu563txja7evd4zt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 1 +
 tools/perf/tests/openat-syscall.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 8322b6aa4047..4ae4dea07466 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -16,6 +16,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "stat.h"
+#include "util/counts.h"
 
 int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index f217972977e0..58df4bda5e12 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -10,6 +10,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "tests.h"
+#include "util/counts.h"
 
 int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-- 
2.21.0
