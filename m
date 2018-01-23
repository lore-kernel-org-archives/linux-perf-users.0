From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/43] perf trace beauty flock: Move to separate object file
Date: Tue, 23 Jan 2018 10:12:51 -0300
Message-ID: <20180123131251.28197-44-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To resolve some header conflicts that were preventing the build to
succeed in the Alpine Linux distribution.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-bvud0dvzvip3kibeplupdbmc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       |  1 -
 tools/perf/trace/beauty/Build    |  1 +
 tools/perf/trace/beauty/beauty.h |  3 +++
 tools/perf/trace/beauty/flock.c  | 10 +++++-----
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 868306ccd8b8..17d11deeb88d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -548,7 +548,6 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 #include "trace/beauty/arch_errno_names.c"
 #include "trace/beauty/eventfd.c"
-#include "trace/beauty/flock.c"
 #include "trace/beauty/futex_op.c"
 #include "trace/beauty/futex_val3.c"
 #include "trace/beauty/mmap.c"
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 066bbf0f4a74..66330d4b739b 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1,5 +1,6 @@
 libperf-y += clone.o
 libperf-y += fcntl.o
+libperf-y += flock.o
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
 libperf-y += ioctl.o
 endif
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index d8f6b2ec7fc5..984a504d335c 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -79,6 +79,9 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FCNTL_ARG syscall_arg__scnprintf_fcntl_arg
 
+size_t syscall_arg__scnprintf_flock(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FLOCK syscall_arg__scnprintf_flock
+
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_IOCTL_CMD syscall_arg__scnprintf_ioctl_cmd
 
diff --git a/tools/perf/trace/beauty/flock.c b/tools/perf/trace/beauty/flock.c
index f9707f57566c..c4ff6ad30b06 100644
--- a/tools/perf/trace/beauty/flock.c
+++ b/tools/perf/trace/beauty/flock.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <fcntl.h>
+
+#include "trace/beauty/beauty.h"
+#include <linux/kernel.h>
+#include <uapi/linux/fcntl.h>
 
 #ifndef LOCK_MAND
 #define LOCK_MAND	 32
@@ -17,8 +20,7 @@
 #define LOCK_RW		192
 #endif
 
-static size_t syscall_arg__scnprintf_flock(char *bf, size_t size,
-					   struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_flock(char *bf, size_t size, struct syscall_arg *arg)
 {
 	int printed = 0, op = arg->val;
 
@@ -45,5 +47,3 @@ static size_t syscall_arg__scnprintf_flock(char *bf, size_t size,
 
 	return printed;
 }
-
-#define SCA_FLOCK syscall_arg__scnprintf_flock
-- 
2.14.3
