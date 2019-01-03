From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/29] perf trace: Rename thread_thread->paths to thread_trace->files
Date: Thu,  3 Jan 2019 09:45:48 -0300
Message-ID: <20190103124609.29672-9-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can add more per file attributes besides the pathname, such
as which ioctl beautifier to use, for cases such as the sound and
usbdeffs ioctls, that both use the 'U' command, so we have to
differentiate at the major number for the device file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1895cmhrdz2dkl5prf2cj2yj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 42 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1e9e886b2811..d4bca74f282c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -957,6 +957,10 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 	return printed + fprintf(fp, "): ");
 }
 
+struct file {
+	char *pathname;
+};
+
 /**
  * filename.ptr: The filename char pointer that will be vfs_getname'd
  * filename.entry_str_pos: Where to insert the string translated from
@@ -980,9 +984,9 @@ struct thread_trace {
 		char	      *name;
 	} filename;
 	struct {
-		int	  max;
-		char	  **table;
-	} paths;
+		int	      max;
+		struct file   *table;
+	} files;
 
 	struct intlist *syscall_stats;
 };
@@ -992,7 +996,7 @@ static struct thread_trace *thread_trace__new(void)
 	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
 
 	if (ttrace)
-		ttrace->paths.max = -1;
+		ttrace->files.max = -1;
 
 	ttrace->syscall_stats = intlist__new(NULL);
 
@@ -1040,26 +1044,26 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 {
 	struct thread_trace *ttrace = thread__priv(thread);
 
-	if (fd > ttrace->paths.max) {
-		char **npath = realloc(ttrace->paths.table, (fd + 1) * sizeof(char *));
+	if (fd > ttrace->files.max) {
+		struct file *nfiles = realloc(ttrace->files.table, (fd + 1) * sizeof(struct file));
 
-		if (npath == NULL)
+		if (nfiles == NULL)
 			return -1;
 
-		if (ttrace->paths.max != -1) {
-			memset(npath + ttrace->paths.max + 1, 0,
-			       (fd - ttrace->paths.max) * sizeof(char *));
+		if (ttrace->files.max != -1) {
+			memset(nfiles + ttrace->files.max + 1, 0,
+			       (fd - ttrace->files.max) * sizeof(struct file));
 		} else {
-			memset(npath, 0, (fd + 1) * sizeof(char *));
+			memset(nfiles, 0, (fd + 1) * sizeof(struct file));
 		}
 
-		ttrace->paths.table = npath;
-		ttrace->paths.max   = fd;
+		ttrace->files.table = nfiles;
+		ttrace->files.max   = fd;
 	}
 
-	ttrace->paths.table[fd] = strdup(pathname);
+	ttrace->files.table[fd].pathname = strdup(pathname);
 
-	return ttrace->paths.table[fd] != NULL ? 0 : -1;
+	return ttrace->files.table[fd].pathname != NULL ? 0 : -1;
 }
 
 static int thread__read_fd_path(struct thread *thread, int fd)
@@ -1099,7 +1103,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 	if (fd < 0)
 		return NULL;
 
-	if ((fd > ttrace->paths.max || ttrace->paths.table[fd] == NULL)) {
+	if ((fd > ttrace->files.max || ttrace->files.table[fd].pathname == NULL)) {
 		if (!trace->live)
 			return NULL;
 		++trace->stats.proc_getname;
@@ -1107,7 +1111,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 			return NULL;
 	}
 
-	return ttrace->paths.table[fd];
+	return ttrace->files.table[fd].pathname;
 }
 
 size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
@@ -1146,8 +1150,8 @@ static size_t syscall_arg__scnprintf_close_fd(char *bf, size_t size,
 	size_t printed = syscall_arg__scnprintf_fd(bf, size, arg);
 	struct thread_trace *ttrace = thread__priv(arg->thread);
 
-	if (ttrace && fd >= 0 && fd <= ttrace->paths.max)
-		zfree(&ttrace->paths.table[fd]);
+	if (ttrace && fd >= 0 && fd <= ttrace->files.max)
+		zfree(&ttrace->files.table[fd].pathname);
 
 	return printed;
 }
-- 
2.19.2
