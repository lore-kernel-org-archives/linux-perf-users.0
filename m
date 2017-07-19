From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 68/86] perf header: Revamp do_write()
Date: Wed, 19 Jul 2017 11:29:32 -0300
Message-ID: <20170719142950.3747-69-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Now that writen takes a const buffer, use it in do_write instead of
duplicating its functionality.

Export do_write to use it consistently in header.c and build_id.c .

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
Link: http://lkml.kernel.org/r/20170718042549.145161-6-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c |  2 +-
 tools/perf/util/header.c   | 14 +++++---------
 tools/perf/util/header.h   |  2 ++
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e9665150e9b1..4baa5329439f 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -304,7 +304,7 @@ static int write_buildid(const char *name, size_t name_len, u8 *build_id,
 	b.header.misc = misc;
 	b.header.size = sizeof(b) + len;
 
-	err = writen(fd, &b, sizeof(b));
+	err = do_write(fd, &b, sizeof(b));
 	if (err < 0)
 		return err;
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 8dda19b68ac4..954f0ef8e712 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -75,17 +75,13 @@ bool perf_header__has_feat(const struct perf_header *header, int feat)
 }
 
 /* Return: 0 if succeded, -ERR if failed. */
-static int do_write(int fd, const void *buf, size_t size)
+int do_write(int fd, const void *buf, size_t size)
 {
-	while (size) {
-		int ret = write(fd, buf, size);
-
-		if (ret < 0)
-			return -errno;
+	ssize_t ret;
 
-		size -= ret;
-		buf += ret;
-	}
+	ret  = writen(fd, buf, size);
+	if (ret != (ssize_t)size)
+		return ret < 0 ? (int)ret : -1;
 
 	return 0;
 }
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index d30109b421ee..e98489c8bba7 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -144,6 +144,8 @@ bool is_perf_magic(u64 magic);
 
 #define NAME_ALIGN 64
 
+int do_write(int fd, const void *buf, size_t size);
+
 int write_padded(int fd, const void *bf, size_t count, size_t count_aligned);
 
 /*
-- 
2.9.4
