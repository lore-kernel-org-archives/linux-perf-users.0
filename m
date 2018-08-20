From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/21] perf tools: Add lzma_is_compressed function
Date: Mon, 20 Aug 2018 13:15:56 -0300
Message-ID: <20180820161602.6830-16-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add implementation of the is_compressed callback for lzma.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/lzma.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 7032caaf75eb..b1dd29a9d915 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -3,9 +3,13 @@
 #include <lzma.h>
 #include <stdio.h>
 #include <linux/compiler.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include "compress.h"
 #include "util.h"
 #include "debug.h"
+#include <unistd.h>
 
 #define BUFSIZE 8192
 
@@ -100,7 +104,18 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 	return err;
 }
 
-bool lzma_is_compressed(const char *input __maybe_unused)
+bool lzma_is_compressed(const char *input)
 {
-	return true;
+	int fd = open(input, O_RDONLY);
+	const uint8_t magic[6] = { 0xFD, '7', 'z', 'X', 'Z', 0x00 };
+	char buf[6] = { 0 };
+	ssize_t rc;
+
+	if (fd < 0)
+		return -1;
+
+	rc = read(fd, buf, sizeof(buf));
+	close(fd);
+	return rc == sizeof(buf) ?
+	       memcmp(buf, magic, sizeof(buf)) == 0 : false;
 }
-- 
2.14.4
