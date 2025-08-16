Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203EC1F2B8D;
	Sat, 16 Aug 2025 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314211; cv=none; b=H8JVBfYFRNHzDBjRKmE67GmISwybd1IH9EZy3LNqJJywA5taKGJ+oa1G1Z3AmvmkrvSP9A+Tl42Jz9bc1a8wNmX7PTdbE1vlIShd3StjOOcwrxFgYH7jWBhYkrFOo7ms74BPZf5zzRvD8/y9Pi17oosueIkJAYjwhEncmnnfAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314211; c=relaxed/simple;
	bh=d4MR7IarDUQWcMZzNUI3SIJc3F04Njj30gYOkDquj+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnsWFG8+aRjQVYFcgyyafcYeDQy2XWIuozIWXlh+3qQlaznLSxUB3aWT4+mwZCkmX8W4sVVpl5WdH1lwoeXVliZ0iV3xdKwis9eiUzVQSMuWmYbnwKf9i2p1AtJt2kRzcSjQxHAM+UzjveOhQn//POxIPNzMNLicWVe/lCidBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBZ8Ur7d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBZ8Ur7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B06C4CEF5;
	Sat, 16 Aug 2025 03:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314211;
	bh=d4MR7IarDUQWcMZzNUI3SIJc3F04Njj30gYOkDquj+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBZ8Ur7d2FxufiFUAdLqc7iH6IyzGz2RMR46MZn/Z5Hi/oVfqSFfihtfep0uiszr7
	 Kugozp2I+DUeiY/JtHGyZ1sGivNDZ16/KLH6ylK92x7czhEpKax78o6UL7bQkx6/8C
	 8EgUhnx/nLfOd+JNSgb6cQkn2dXDp0R09WJsZlSOfy9UECcnIgKN83Vj54leY/JIYY
	 Ih1aCz+ibKtL0J4LzVGtR8v3eMSdueZcRpNao8MY9FzRDEZRzIfgTe+KR6wv13ucPW
	 b/zH3ysA5niWbwSXKDMqb0TIhGicQnQHIFKU+0PJjf5Uju5ibmUiNQCjKfrjni8sBT
	 1abTAwDkFkFjQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 12/12] perf annotate: Use a hashmap to save type data
Date: Fri, 15 Aug 2025 20:16:35 -0700
Message-ID: <20250816031635.25318-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816031635.25318-1-namhyung@kernel.org>
References: <20250816031635.25318-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can slowdown annotation browser if objdump is processing large DWARF
data.  Let's add a hashmap to save the data type info for each line.

Note that this is needed for TUI only because stdio only processes each
line once.  TUI will display the same line whenever it refreshes the
screen.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 34 ++++++++++++++++++++++++++++++-
 tools/perf/util/annotate.c        | 27 ++++++++++++++++++++++--
 tools/perf/util/annotate.h        |  2 ++
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 9aa3c1ba22f52789..9677a3763a290a3d 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -6,6 +6,7 @@
 #include "../../util/debug.h"
 #include "../../util/debuginfo.h"
 #include "../../util/dso.h"
+#include "../../util/hashmap.h"
 #include "../../util/hist.h"
 #include "../../util/sort.h"
 #include "../../util/map.h"
@@ -15,6 +16,7 @@
 #include "../../util/evlist.h"
 #include "../../util/thread.h"
 #include <inttypes.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -36,6 +38,7 @@ struct annotate_browser {
 	struct hist_entry	   *he;
 	struct debuginfo	   *dbg;
 	struct evsel		   *evsel;
+	struct hashmap		   *type_hash;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
@@ -43,6 +46,16 @@ struct annotate_browser {
 /* A copy of target hist_entry for perf top. */
 static struct hist_entry annotate_he;
 
+static size_t type_hash(long key, void *ctx __maybe_unused)
+{
+	return key;
+}
+
+static bool type_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 static inline struct annotation *browser__annotation(struct ui_browser *browser)
 {
 	struct map_symbol *ms = browser->priv;
@@ -130,6 +143,9 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	if (!browser->navkeypressed)
 		ops.width += 1;
 
+	if (!IS_ERR_OR_NULL(ab->type_hash))
+		apd.type_hash = ab->type_hash;
+
 	annotation_line__write(al, notes, &ops, &apd);
 
 	if (ops.current_entry)
@@ -1051,6 +1067,10 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			annotate_opts.code_with_type ^= 1;
 			if (browser->dbg == NULL)
 				browser->dbg = dso__debuginfo(map__dso(ms->map));
+			if (browser->type_hash == NULL) {
+				browser->type_hash = hashmap__new(type_hash, type_equal,
+								  /*ctx=*/NULL);
+			}
 			annotate_browser__show(&browser->b, title, help);
 			annotate_browser__debuginfo_warning(browser);
 			continue;
@@ -1145,8 +1165,10 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ui_helpline__push("Press ESC to exit");
 
-	if (annotate_opts.code_with_type)
+	if (annotate_opts.code_with_type) {
 		browser.dbg = dso__debuginfo(dso);
+		browser.type_hash = hashmap__new(type_hash, type_equal, /*ctx=*/NULL);
+	}
 
 	browser.b.width = notes->src->widths.max_line_len;
 	browser.b.nr_entries = notes->src->nr_entries;
@@ -1159,6 +1181,16 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
 	debuginfo__delete(browser.dbg);
+
+	if (!IS_ERR_OR_NULL(browser.type_hash)) {
+		struct hashmap_entry *cur;
+		size_t bkt;
+
+		hashmap__for_each_entry(browser.type_hash, cur, bkt)
+			free(cur->pvalue);
+		hashmap__free(browser.type_hash);
+	}
+
 	if (not_annotated && !notes->src->tried_source)
 		annotated_source__purge(notes->src);
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bea3457a00632fd7..77414e04d99bb4f2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1954,11 +1954,17 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
 	return -ENOMEM;
 }
 
+struct type_hash_entry {
+	struct annotated_data_type *type;
+	int offset;
+};
+
 static int disasm_line__snprint_type_info(struct disasm_line *dl,
 					  char *buf, int len,
 					  struct annotation_print_data *apd)
 {
-	struct annotated_data_type *data_type;
+	struct annotated_data_type *data_type = NULL;
+	struct type_hash_entry *entry = NULL;
 	char member[256];
 	int offset = 0;
 	int printed;
@@ -1968,7 +1974,24 @@ static int disasm_line__snprint_type_info(struct disasm_line *dl,
 	if (!annotate_opts.code_with_type || apd->dbg == NULL)
 		return 1;
 
-	data_type = __hist_entry__get_data_type(apd->he, apd->arch, apd->dbg, dl, &offset);
+	if (apd->type_hash) {
+		hashmap__find(apd->type_hash, dl->al.offset, &entry);
+		if (entry != NULL) {
+			data_type = entry->type;
+			offset = entry->offset;
+		}
+	}
+	if (data_type == NULL)
+		data_type = __hist_entry__get_data_type(apd->he, apd->arch, apd->dbg, dl, &offset);
+	if (apd->type_hash && entry == NULL) {
+		entry = malloc(sizeof(*entry));
+		if (entry != NULL) {
+			entry->type = data_type;
+			entry->offset = offset;
+			hashmap__add(apd->type_hash, dl->al.offset, entry);
+		}
+	}
+
 	if (!needs_type_info(data_type))
 		return 1;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 86e858f5bf173152..eaf6c8aa7f473959 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -204,6 +204,8 @@ struct annotation_print_data {
 	struct evsel *evsel;
 	struct arch *arch;
 	struct debuginfo *dbg;
+	/* save data type info keyed by al->offset */
+	struct hashmap *type_hash;
 	/* It'll be set in hist_entry__annotate_printf() */
 	int addr_fmt_width;
 };
-- 
2.50.1

