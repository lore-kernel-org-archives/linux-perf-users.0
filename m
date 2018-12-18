From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/63] perf auxtrace: Alter addr_filter__entire_dso() to work if there are no symbols
Date: Tue, 18 Dec 2018 19:06:32 -0300
Message-ID: <20181218220733.15839-3-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

addr_filter__entire_dso() uses the first and last symbols from a dso,
and so does not work when there are no symbols.  Alter it to filter the
whole file instead.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Fixes: 1b36c03e3569 ("perf record: Add support for using symbols in address filters")
Link: http://lkml.kernel.org/r/20181127084634.12469-1-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 72d5ba2479bf..f69961c4a4f3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1983,17 +1983,14 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 
 static int addr_filter__entire_dso(struct addr_filter *filt, struct dso *dso)
 {
-	struct symbol *first_sym = dso__first_symbol(dso);
-	struct symbol *last_sym = dso__last_symbol(dso);
-
-	if (!first_sym || !last_sym) {
-		pr_err("Failed to determine filter for %s\nNo symbols found.\n",
+	if (dso__data_file_size(dso, NULL)) {
+		pr_err("Failed to determine filter for %s\nCannot determine file size.\n",
 		       filt->filename);
 		return -EINVAL;
 	}
 
-	filt->addr = first_sym->start;
-	filt->size = last_sym->end - first_sym->start;
+	filt->addr = 0;
+	filt->size = dso->data.file_size;
 
 	return 0;
 }
-- 
2.19.2
