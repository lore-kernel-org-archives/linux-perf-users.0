From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/21] perf tools: Use compression id in decompress_kmodule()
Date: Mon, 20 Aug 2018 13:15:53 -0300
Message-ID: <20180820161602.6830-13-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Once we parsed out the compression ID, we dont need to iterate all
available compressions and we can call it directly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d875e6956a3e..54bfe1f4762f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -244,18 +244,6 @@ bool is_kernel_module(const char *pathname, int cpumode)
 	return m.kmod;
 }
 
-static bool decompress_to_file(const char *ext, const char *filename, int output_fd)
-{
-	unsigned i;
-
-	for (i = 0; compressions[i].fmt; i++) {
-		if (!strcmp(ext, compressions[i].fmt))
-			return !compressions[i].decompress(filename,
-							   output_fd);
-	}
-	return false;
-}
-
 bool dso__needs_decompress(struct dso *dso)
 {
 	return dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
@@ -265,31 +253,25 @@ bool dso__needs_decompress(struct dso *dso)
 static int decompress_kmodule(struct dso *dso, const char *name, char *tmpbuf)
 {
 	int fd = -1;
-	struct kmod_path m;
 
 	if (!dso__needs_decompress(dso))
 		return -1;
 
-	if (kmod_path__parse_ext(&m, dso->long_name))
+	if (dso->comp == COMP_ID__NONE)
 		return -1;
 
-	if (!m.comp)
-		goto out;
-
 	fd = mkstemp(tmpbuf);
 	if (fd < 0) {
 		dso->load_errno = errno;
-		goto out;
+		return -1;
 	}
 
-	if (!decompress_to_file(m.ext, name, fd)) {
+	if (compressions[dso->comp].decompress(name, fd)) {
 		dso->load_errno = DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE;
 		close(fd);
 		fd = -1;
 	}
 
-out:
-	free(m.ext);
 	return fd;
 }
 
-- 
2.14.4
