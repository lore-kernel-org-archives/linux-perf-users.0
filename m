From: Martin Vuille <jpmv27@aim.com>
Subject: [PATCH] perf annotate: Don't prepend symfs path to build_id_filename
Date: Sun, 11 Feb 2018 14:19:37 -0500
Message-ID: <20180211191937.9703-1-jpmv27@aim.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

build_id_filename already contains symfs path if applicable, so
don't prepend it a second time.

Signed-off-by: Martin Vuille <jpmv27@aim.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 28b233c3dcbe..425b7f0760ec 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1381,7 +1381,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (build_id_filename) {
-		__symbol__join_symfs(filename, filename_size, build_id_filename);
+		scnprintf(filename, filename_size, "%s", build_id_filename);
 		free(build_id_filename);
 	} else {
 		if (dso->has_build_id)
-- 
2.13.6
