From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 67/86] perf util: Add const modifier to buf in "writen" function
Date: Wed, 19 Jul 2017 11:29:31 -0300
Message-ID: <20170719142950.3747-68-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Make buf in helper function "writen" constant to simplify the life of
its callers.

This requires to hack a cast of buf prior to passing it to "ion" which
is simpler than the alternative of reworking the "ion" function to
provide a read and a write paths, the latter with constant buf argument.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170718042549.145161-5-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 6 ++++--
 tools/perf/util/util.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 9e4ea852f636..4c360daa4e24 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -281,6 +281,7 @@ static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
 	size_t left = n;
 
 	while (left) {
+		/* buf must be treated as const if !is_read. */
 		ssize_t ret = is_read ? read(fd, buf, left) :
 					write(fd, buf, left);
 
@@ -308,9 +309,10 @@ ssize_t readn(int fd, void *buf, size_t n)
 /*
  * Write exactly 'n' bytes or return an error.
  */
-ssize_t writen(int fd, void *buf, size_t n)
+ssize_t writen(int fd, const void *buf, size_t n)
 {
-	return ion(false, fd, buf, n);
+	/* ion does not modify buf. */
+	return ion(false, fd, (void *)buf, n);
 }
 
 size_t hex_width(u64 v)
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 062dd20437f7..b136c271125f 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -38,7 +38,7 @@ int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
 int copyfile_offset(int fromfd, loff_t from_ofs, int tofd, loff_t to_ofs, u64 size);
 
 ssize_t readn(int fd, void *buf, size_t n);
-ssize_t writen(int fd, void *buf, size_t n);
+ssize_t writen(int fd, const void *buf, size_t n);
 
 size_t hex_width(u64 v);
 int hex2u64(const char *ptr, u64 *val);
-- 
2.9.4
