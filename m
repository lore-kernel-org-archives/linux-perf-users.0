From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/86] perf trace beauty: Export the fd beautifier for use in more places
Date: Wed, 19 Jul 2017 11:28:48 -0300
Message-ID: <20170719142950.3747-25-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that the beautifiers are being split into multiple source and object
files, we will need more of them exported, do it for the 'fd' one, will
be used to augment the return of some syscalls that may return an 'fd',
such as fcntl(fd, F_DUPFD).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-39sosu12hhywyunqf5s74ewf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 8 +-------
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cfa8bf1cca43..65fa0126e939 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -365,11 +365,6 @@ static size_t syscall_arg__scnprintf_strhexarray(char *bf, size_t size,
 #define SCA_STRHEXARRAY syscall_arg__scnprintf_strhexarray
 #endif /* defined(__i386__) || defined(__x86_64__) */
 
-static size_t syscall_arg__scnprintf_fd(char *bf, size_t size,
-					struct syscall_arg *arg);
-
-#define SCA_FD syscall_arg__scnprintf_fd
-
 #ifndef AT_FDCWD
 #define AT_FDCWD	-100
 #endif
@@ -1057,8 +1052,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 	return ttrace->paths.table[fd];
 }
 
-static size_t syscall_arg__scnprintf_fd(char *bf, size_t size,
-					struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	int fd = arg->val;
 	size_t printed = scnprintf(bf, size, "%d", fd);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index b64c4116cdc4..790e8307fc6a 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -31,6 +31,9 @@ unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
 
+size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FD syscall_arg__scnprintf_fd
+
 size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_HEX syscall_arg__scnprintf_hex
 
-- 
2.9.4
