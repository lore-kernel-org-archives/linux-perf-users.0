From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/29] perf trace: Store the major number for a file when storing its pathname
Date: Thu,  3 Jan 2019 09:45:50 -0300
Message-ID: <20190103124609.29672-11-acme@kernel.org>
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

We keep a table for the fds to map them back to pathnames when showing
'fd' based APIs such as write(), store as well the major number for the
device the path is in, to use in things like choosing the right ioctl
'cmd' beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qjkds7bnk7v7fk2xhqsb0a4v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 41ab524e128b..4b03f66b1735 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -60,6 +60,7 @@
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <fcntl.h>
+#include <sys/sysmacros.h>
 
 #include "sane_ctype.h"
 
@@ -959,6 +960,7 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 
 struct file {
 	char *pathname;
+	int  dev_maj;
 };
 
 /**
@@ -1068,6 +1070,9 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 	struct file *file = thread_trace__files_entry(ttrace, fd);
 
 	if (file != NULL) {
+		struct stat st;
+		if (stat(pathname, &st) == 0)
+			file->dev_maj = major(st.st_rdev);
 		file->pathname = strdup(pathname);
 		if (file->pathname)
 			return 0;
-- 
2.19.2
