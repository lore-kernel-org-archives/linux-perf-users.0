From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/25] perf namespaces: Move the conditional setns() prototype to namespaces.h
Date: Tue,  9 Jul 2019 15:31:12 -0300
Message-ID: <20190709183126.30257-12-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Out of util.h, to reduce its scope, and since we have a namespaces.h
header, much better to have it there, where it is related to.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zlu81bbtccuzygh7m8nmgybc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/namespaces.h | 4 ++++
 tools/perf/util/setns.c      | 4 +++-
 tools/perf/util/util.h       | 4 ----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 15a5a276c478..004430c0de93 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -13,6 +13,10 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 
+#ifndef HAVE_SETNS_SUPPORT
+int setns(int fd, int nstype);
+#endif
+
 struct namespaces_event;
 
 struct namespaces {
diff --git a/tools/perf/util/setns.c b/tools/perf/util/setns.c
index ce8fc290fce8..48f9c0af63b2 100644
--- a/tools/perf/util/setns.c
+++ b/tools/perf/util/setns.c
@@ -1,4 +1,6 @@
-#include "util.h"
+// SPDX-License-Identifier: LGPL-2.1
+
+#include "namespaces.h"
 #include <unistd.h>
 #include <sys/syscall.h>
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 125e215dd3d8..59fe33708090 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -67,10 +67,6 @@ char *get_current_dir_name(void);
 int sched_getcpu(void);
 #endif
 
-#ifndef HAVE_SETNS_SUPPORT
-int setns(int fd, int nstype);
-#endif
-
 extern bool perf_singlethreaded;
 
 void perf_set_singlethreaded(void);
-- 
2.21.0
