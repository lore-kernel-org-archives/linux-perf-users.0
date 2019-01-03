From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/29] perf trace: Move the files table resizing to outside set_pathname()
Date: Thu,  3 Jan 2019 09:45:49 -0300
Message-ID: <20190103124609.29672-10-acme@kernel.org>
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

So that we can have that table expanded when setting other attributes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hzvpe3qwafe6sqcq3bhtbxds@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d4bca74f282c..41ab524e128b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1040,15 +1040,13 @@ void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 
 static const size_t trace__entry_str_size = 2048;
 
-static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
+static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int fd)
 {
-	struct thread_trace *ttrace = thread__priv(thread);
-
 	if (fd > ttrace->files.max) {
 		struct file *nfiles = realloc(ttrace->files.table, (fd + 1) * sizeof(struct file));
 
 		if (nfiles == NULL)
-			return -1;
+			return NULL;
 
 		if (ttrace->files.max != -1) {
 			memset(nfiles + ttrace->files.max + 1, 0,
@@ -1061,9 +1059,21 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 		ttrace->files.max   = fd;
 	}
 
-	ttrace->files.table[fd].pathname = strdup(pathname);
+	return ttrace->files.table + fd;
+}
+
+static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
+{
+	struct thread_trace *ttrace = thread__priv(thread);
+	struct file *file = thread_trace__files_entry(ttrace, fd);
+
+	if (file != NULL) {
+		file->pathname = strdup(pathname);
+		if (file->pathname)
+			return 0;
+	}
 
-	return ttrace->files.table[fd].pathname != NULL ? 0 : -1;
+	return -1;
 }
 
 static int thread__read_fd_path(struct thread *thread, int fd)
-- 
2.19.2
