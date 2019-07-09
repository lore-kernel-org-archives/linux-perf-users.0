From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/25] perf tools: Move get_current_dir_name() cond prototype out of util.h
Date: Tue,  9 Jul 2019 15:31:13 -0300
Message-ID: <20190709183126.30257-13-acme@kernel.org>
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

And in a separate header, so that we erode util.h a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xpzvuu9d0gei9jl9bkzgobln@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/get_current_dir_name.c | 6 +++---
 tools/perf/util/get_current_dir_name.h | 8 ++++++++
 tools/perf/util/namespaces.c           | 1 +
 tools/perf/util/util.h                 | 4 ----
 4 files changed, 12 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/util/get_current_dir_name.h

diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
index 267aa609a582..01f32f26552d 100644
--- a/tools/perf/util/get_current_dir_name.c
+++ b/tools/perf/util/get_current_dir_name.c
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+// SPDX-License-Identifier: LGPL-2.1
+// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 //
 #ifndef HAVE_GET_CURRENT_DIR_NAME
-#include "util.h"
+#include "get_current_dir_name.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdlib.h>
diff --git a/tools/perf/util/get_current_dir_name.h b/tools/perf/util/get_current_dir_name.h
new file mode 100644
index 000000000000..69f7d5537d32
--- /dev/null
+++ b/tools/perf/util/get_current_dir_name.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.1
+// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+//
+#ifndef __PERF_GET_CURRENT_DIR_NAME_H
+#ifndef HAVE_GET_CURRENT_DIR_NAME
+char *get_current_dir_name(void);
+#endif // HAVE_GET_CURRENT_DIR_NAME
+#endif // __PERF_GET_CURRENT_DIR_NAME_H
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 023c4efd788d..fda2fa1e8819 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -7,6 +7,7 @@
 #include "namespaces.h"
 #include "util.h"
 #include "event.h"
+#include "get_current_dir_name.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 59fe33708090..cfc4d85bbd42 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -59,10 +59,6 @@ int fetch_kernel_version(unsigned int *puint,
 
 const char *perf_tip(const char *dirpath);
 
-#ifndef HAVE_GET_CURRENT_DIR_NAME
-char *get_current_dir_name(void);
-#endif
-
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
 int sched_getcpu(void);
 #endif
-- 
2.21.0
