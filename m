From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/13] perf syscalltbl: Support glob matching on syscall names
Date: Mon,  4 Sep 2017 11:00:33 -0300
Message-ID: <20170904140044.22912-3-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753563AbdIDOEq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2017 10:04:46 -0400
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With two new methods, one to find the first match, returning its syscall
id and its index in whatever internal database it keeps the syscall
into, then one to find the next match, if any.

Implemented only on arches where we actually read the syscall table from
the kernel sources, i.e. x86-64 for now, all the others use the libaudit
method for which this returns -1, i.e. just stubs were added, with the
actual implementation using whatever libaudit functions for matching
that may be available.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-i0sj4rxk1a63pfe9gl8z8irs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/syscalltbl.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/syscalltbl.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index bbb4c1957578..19e5db90394c 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -19,6 +19,7 @@
 #ifdef HAVE_SYSCALL_TABLE
 #include <linux/compiler.h>
 #include <string.h>
+#include "string2.h"
 #include "util.h"
 
 #if defined(__x86_64__)
@@ -105,6 +106,27 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
 	return sc ? sc->id : -1;
 }
 
+int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
+{
+	int i;
+	struct syscall *syscalls = tbl->syscalls.entries;
+
+	for (i = *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
+		if (strglobmatch(syscalls[i].name, syscall_glob)) {
+			*idx = i;
+			return syscalls[i].id;
+		}
+	}
+
+	return -1;
+}
+
+int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
+{
+	*idx = -1;
+	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
+}
+
 #else /* HAVE_SYSCALL_TABLE */
 
 #include <libaudit.h>
@@ -131,4 +153,15 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
 {
 	return audit_name_to_syscall(name, tbl->audit_machine);
 }
+
+int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
+				  const char *syscall_glob __maybe_unused, int *idx __maybe_unused)
+{
+	return -1;
+}
+
+int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
+{
+	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
+}
 #endif /* HAVE_SYSCALL_TABLE */
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
index e2951510484f..e9fb8786da7c 100644
--- a/tools/perf/util/syscalltbl.h
+++ b/tools/perf/util/syscalltbl.h
@@ -17,4 +17,7 @@ void syscalltbl__delete(struct syscalltbl *tbl);
 const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
 int syscalltbl__id(struct syscalltbl *tbl, const char *name);
 
+int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
+int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
+
 #endif /* __PERF_SYSCALLTBL_H */
-- 
2.13.5
