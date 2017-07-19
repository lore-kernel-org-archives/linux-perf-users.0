From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/86] perf beauty open: Detach the syscall_arg agnostic bits from the flags formatter
Date: Wed, 19 Jul 2017 11:28:39 -0300
Message-ID: <20170719142950.3747-16-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We may want to use this in other contexts, like when formatting the
return of fcntl(fd, F_GETFL).

Make it have the following signature, so that we can set the formatter
for the return argument while processing the arguments of a syscall, as
fcntl, for instance, may return fds, flags, etc, so need different
return value formatters:

	size_t formatter(unsigned long value, char *bf, size_t size);

This gets so detached from 'perf trace' internals that we may well get
all these and move to a tools/lib/syscall_beauty/ library at some point
and use it in other tools/ living utilities.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-9aw8t22ztvnkuv26l6sw1c18@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h     |  2 ++
 tools/perf/trace/beauty/open_flags.c | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index d76f903bf2ed..c05bb2ecf502 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -52,4 +52,6 @@ size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_
 size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_MASK syscall_arg__scnprintf_statx_mask
 
+size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size);
+
 #endif /* _PERF_TRACE_BEAUTY_H */
diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index f55a4597fc38..b3c7f1155d80 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -14,13 +14,9 @@
 #define O_NOATIME	01000000
 #endif
 
-static size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size,
-					       struct syscall_arg *arg)
+size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 {
-	int printed = 0, flags = arg->val;
-
-	if (!(flags & O_CREAT))
-		arg->mask |= 1 << (arg->idx + 1); /* Mask the mode parm */
+	int printed = 0;
 
 	if (flags == 0)
 		return scnprintf(bf, size, "RDONLY");
@@ -68,4 +64,15 @@ static size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size,
 	return printed;
 }
 
+static size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	int flags = arg->val;
+
+	if (!(flags & O_CREAT))
+		arg->mask |= 1 << (arg->idx + 1); /* Mask the mode parm */
+
+	return open__scnprintf_flags(flags, bf, size);
+}
+
+
 #define SCA_OPEN_FLAGS syscall_arg__scnprintf_open_flags
-- 
2.9.4
