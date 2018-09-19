From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/13] perf util: Make copyfile_offset() global
Date: Wed, 19 Sep 2018 11:25:35 -0300
Message-ID: <20180919142537.29985-12-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It will be used outside of util object in following patches.

Committer note:

We need to have the header with the definition for loff_t in util.h
since we now use it in the copyfile_offset() signature.

Also move that prototype closer to the other copyfile_ prefixed
functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 2 +-
 tools/perf/util/util.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index eac5b858a371..093352e93d50 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -221,7 +221,7 @@ static int slow_copyfile(const char *from, const char *to, struct nsinfo *nsi)
 	return err;
 }
 
-static int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
 {
 	void *ptr;
 	loff_t pgoff;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index dc58254a2b69..14508ee7707a 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -6,6 +6,7 @@
 /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
 #define _DEFAULT_SOURCE 1
 
+#include <fcntl.h>
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdlib.h>
@@ -35,6 +36,7 @@ bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
 int copyfile_mode(const char *from, const char *to, mode_t mode);
 int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
+int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
-- 
2.14.4
