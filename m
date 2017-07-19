From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/86] perf trace beauty: Mask ignored fcntl 'arg' parameter
Date: Wed, 19 Jul 2017 10:55:59 -0300
Message-ID: <20170719135717.1285-9-acme@kernel.org>
References: <20170719135717.1285-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753610AbdGSOBf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Jul 2017 10:01:35 -0400
In-Reply-To: <20170719135717.1285-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A series of fcntl cmds ignore the third argument, so mask it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-6vtl3zq1tauamrhm8o380ptn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       |  2 +-
 tools/perf/trace/beauty/Build    |  1 +
 tools/perf/trace/beauty/beauty.h |  3 +++
 tools/perf/trace/beauty/fcntl.c  | 23 +++++++++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/trace/beauty/fcntl.c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ef1b1d4ea007..b7f79dea3c44 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -661,7 +661,7 @@ static struct syscall_fmt {
 	{ .name	    = "fchownat",   .errmsg = true,
 	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
 	{ .name	    = "fcntl",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_STRARRAYS, /* cmd */ },
+	  .arg_scnprintf = { [1] = SCA_FCNTL_CMD, /* cmd */ },
 	  .arg_parm	 = { [1] = &strarrays__fcntl_cmds_arrays, /* cmd */ }, },
 	{ .name	    = "fdatasync",  .errmsg = true, },
 	{ .name	    = "flock",	    .errmsg = true,
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index be95ac6ce845..c9e215b806f1 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1 +1,2 @@
+libperf-y += fcntl.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index a6348073a6e9..ce01079d8422 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -18,6 +18,9 @@ struct syscall_arg {
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
 
+size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FCNTL_CMD syscall_arg__scnprintf_fcntl_cmd
+
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
 
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
new file mode 100644
index 000000000000..7e4582c9308e
--- /dev/null
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -0,0 +1,23 @@
+/*
+ * trace/beauty/fcntl.c
+ *
+ *  Copyright (C) 2017, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ *
+ * Released under the GPL v2. (and only v2, not any later version)
+ */
+
+#include "trace/beauty/beauty.h"
+#include <uapi/linux/fcntl.h>
+
+size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg)
+{
+	/*
+	 * Some commands ignore the third fcntl argument, "arg", so mask it
+	 */
+	if (arg->val == F_GETFD	   || arg->val == F_GETFL     ||
+	    arg->val == F_GETOWN   || arg->val == F_GET_SEALS ||
+	    arg->val == F_GETLEASE || arg->val == F_GETSIG)
+		arg->mask |= (1 << 2);
+
+	return syscall_arg__scnprintf_strarrays(bf, size, arg);
+}
-- 
2.9.4
