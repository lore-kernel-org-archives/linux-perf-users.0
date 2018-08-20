From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/21] perf tools: Move the temp file processing into decompress_kmodule
Date: Mon, 20 Aug 2018 13:15:54 -0300
Message-ID: <20180820161602.6830-14-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We will add a compression check in the following patch and it makes it
easier if the file processing is done in a single place. It also makes
the current code simpler.

The decompress_kmodule function now returns the fd of the uncompressed
file and the file name in the pathname arg, if it's provided.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 54bfe1f4762f..cbeecf683333 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -250,8 +250,10 @@ bool dso__needs_decompress(struct dso *dso)
 		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 }
 
-static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
+static int decompress_kmodule(struct dso *dso, const char *name,
+			      char *pathname, size_t len)
 {
+	char tmpbuf[] = KMOD_DECOMP_NAME;
 	int fd = -1;
 
 	if (!dso__needs_decompress(dso))
@@ -272,34 +274,27 @@ static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
 		fd = -1;
 	}
 
+	if (!pathname || (fd < 0))
+		unlink(tmpbuf);
+
+	if (pathname && (fd >= 0))
+		strncpy(pathname, tmpbuf, len);
+
 	return fd;
 }
 
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name)
 {
-	char tmpbuf[] = KMOD_DECOMP_NAME;
-	int fd;
-
-	fd = decompress_kmodule(dso, name, tmpbuf);
-	unlink(tmpbuf);
-	return fd;
+	return decompress_kmodule(dso, name, NULL, 0);
 }
 
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 				 char *pathname, size_t len)
 {
-	char tmpbuf[] = KMOD_DECOMP_NAME;
-	int fd;
-
-	fd = decompress_kmodule(dso, name, tmpbuf);
-	if (fd < 0) {
-		unlink(tmpbuf);
-		return -1;
-	}
+	int fd = decompress_kmodule(dso, name, pathname, len);
 
-	strncpy(pathname, tmpbuf, len);
 	close(fd);
-	return 0;
+	return fd >= 0 ? 0 : -1;
 }
 
 /*
-- 
2.14.4
