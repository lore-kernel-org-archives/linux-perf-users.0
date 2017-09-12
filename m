From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/41] perf tools: Make copyfile_offset() static
Date: Tue, 12 Sep 2017 12:10:16 -0300
Message-ID: <20170912151029.6612-29-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are no usage outside util.c and this is the only remaining reason
for fcntl.h to be included in util.h, to get the loff_t definition in
Alpine Linux, so make it static.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-2dzlsao7k6ihozs5karw6kpx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 1 +
 tools/perf/util/data.c          | 1 +
 tools/perf/util/dso.c           | 1 +
 tools/perf/util/event.c         | 1 +
 tools/perf/util/evlist.h        | 1 +
 tools/perf/util/namespaces.c    | 1 +
 tools/perf/util/pmu.c           | 1 +
 tools/perf/util/probe-file.c    | 1 +
 tools/perf/util/util.c          | 3 ++-
 tools/perf/util/util.h          | 2 --
 tools/perf/util/zlib.c          | 1 +
 11 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 377bea009163..d0fee35db0e7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -3,6 +3,7 @@
  *
  * Builtin regression testing command: ever growing number of sanity tests
  */
+#include <fcntl.h>
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 263f5a906ba5..1123b30e3033 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -3,6 +3,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <unistd.h>
 #include <string.h>
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index b9e087fb8247..ffd723179a4b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -6,6 +6,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <errno.h>
+#include <fcntl.h>
 #include "compress.h"
 #include "path.h"
 #include "symbol.h"
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 17c21ea68a72..10366b87d0b5 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1,5 +1,6 @@
 #include <dirent.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <inttypes.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bf2c4936e35f..b1c14f1fdc27 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -6,6 +6,7 @@
 #include <linux/refcount.h>
 #include <linux/list.h>
 #include <api/fd/array.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include "../perf.h"
 #include "event.h"
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index a58e91197729..5be021701f34 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -11,6 +11,7 @@
 #include "event.h"
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 #include <limits.h>
 #include <sched.h>
 #include <stdlib.h>
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7070638ab600..0b11dfc0af44 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2,6 +2,7 @@
 #include <linux/compiler.h>
 #include <sys/types.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sys/stat.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index cdf8d83a484c..4ae1123c6794 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -15,6 +15,7 @@
  *
  */
 #include <errno.h>
+#include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/uio.h>
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 4c360daa4e24..3c9c39711343 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -6,6 +6,7 @@
 #include <sys/stat.h>
 #include <sys/utsname.h>
 #include <dirent.h>
+#include <fcntl.h>
 #include <inttypes.h>
 #include <signal.h>
 #include <stdio.h>
@@ -174,7 +175,7 @@ static int slow_copyfile(const char *from, const char *to, struct nsinfo *nsi)
 	return err;
 }
 
-int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
+static int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
 {
 	void *ptr;
 	loff_t pgoff;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index b136c271125f..03946d5e4741 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -5,7 +5,6 @@
 /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
 #define _DEFAULT_SOURCE 1
 
-#include <fcntl.h>
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdlib.h>
@@ -35,7 +34,6 @@ bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
 int copyfile_mode(const char *from, const char *to, mode_t mode);
 int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
-int copyfile_offset(int fromfd, loff_t from_ofs, int tofd, loff_t to_ofs, u64 size);
 
 ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 1329d843eb7b..7c1175310a12 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -1,3 +1,4 @@
+#include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/stat.h>
-- 
2.13.5
