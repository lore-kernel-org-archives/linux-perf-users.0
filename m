From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/29] perf trace beauty: Export function to get the files for a thread
Date: Thu,  3 Jan 2019 09:45:54 -0300
Message-ID: <20190103124609.29672-15-acme@kernel.org>
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

So that beautifiers can access things like dev_maj.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wm5o51f206c5pi063dsaeraq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 10 +++++-----
 tools/perf/trace/beauty/beauty.h |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4b03f66b1735..adbf28183560 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -958,11 +958,6 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 	return printed + fprintf(fp, "): ");
 }
 
-struct file {
-	char *pathname;
-	int  dev_maj;
-};
-
 /**
  * filename.ptr: The filename char pointer that will be vfs_getname'd
  * filename.entry_str_pos: Where to insert the string translated from
@@ -1064,6 +1059,11 @@ static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int f
 	return ttrace->files.table + fd;
 }
 
+struct file *thread__files_entry(struct thread *thread, int fd)
+{
+	return thread_trace__files_entry(thread__priv(thread), fd);
+}
+
 static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
 {
 	struct thread_trace *ttrace = thread__priv(thread);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 83c5b202e00e..139d485a6f16 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,13 @@ size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, boo
 struct trace;
 struct thread;
 
+struct file {
+	char *pathname;
+	int  dev_maj;
+};
+
+struct file *thread__files_entry(struct thread *thread, int fd);
+
 struct strarrays {
 	int		nr_entries;
 	struct strarray **entries;
-- 
2.19.2
