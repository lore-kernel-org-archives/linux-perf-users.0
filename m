Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0DF15ECD7;
	Sat, 16 Aug 2025 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314210; cv=none; b=iYluR3vu6k9ggcq402NG6hLEAT2yMTKa/NGpXqu8L3EX+zdjXuxUCDNtbJLKWyo0FsPKhLBrcnKl4UnDFq1I8didzQ8XU4GEuoSa9uAtAkogsUjpwAA1k480YLk6MZESztg7ZLD3can5gps38WDojHfzRluMvTZPqHbHgAONeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314210; c=relaxed/simple;
	bh=TFn+AkeCWJxWEIXjxpP39LZNlBV3hJRx78OUGBy8puE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcoXe53fq34zyx8Nco6vTtHcUEky0AV5NIEMjw9vmXKwooTs2KbgWnSQXyVWtM4UAM/At5wpu8DgtndwqJFr7PjvtRRh7C6jDKwHBDMrPJKOpgdwCXpiytZRy0DoWlVxjqHKIOdoVrwAiiHECmg92O5ERA0Wuck/QC1wwptPsMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmphe5G4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmphe5G4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AC2C4CEF7;
	Sat, 16 Aug 2025 03:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314210;
	bh=TFn+AkeCWJxWEIXjxpP39LZNlBV3hJRx78OUGBy8puE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmphe5G4FucFklBNAoa04onGP4LfkrGx5Alg4J42pe9d4T9tEM8WrtCxF2qztGN4X
	 6ZehTEX+VxW+gzoLArUTY/+dTiXvyAuqXKyArWPWMb2l8GseCNdaH7vIPtLdgEKkW4
	 0esctm0r9dtcQCrAiy3EEWnseVZSsh72r4dhGnHVXivYVNyNaCmmcHVXAVaFGYMnfc
	 XEgP3pne1K/wm67bONP4/NNR+bgU6i5zZpsxKiUNnIHbZW3GIYllG9H+XQkcLuWC0U
	 6wprYftWjXhgb3BIbcAgeytp6PHZiEiaKtgWaJ73cDg1SFG0T5xcf1PK1DgtI++tm0
	 dvJOMcujInE/Q==
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
Subject: [PATCH v5 11/12] perf annotate: Add dso__debuginfo() helper
Date: Fri, 15 Aug 2025 20:16:34 -0700
Message-ID: <20250816031635.25318-12-namhyung@kernel.org>
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

It'd be great if it can get the correct debug information using DSO
build-Id not just the path name.  Instead of adding new callsites of
debuginfo__new(), let's add dso__debuginfo() which can hide the access
using the pathname and help the future conversion.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  4 ++--
 tools/perf/util/annotate.c        |  6 +++---
 tools/perf/util/dso.h             | 10 ++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e3e7004f32251666..9aa3c1ba22f52789 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1050,7 +1050,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		case 'T':
 			annotate_opts.code_with_type ^= 1;
 			if (browser->dbg == NULL)
-				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
+				browser->dbg = dso__debuginfo(map__dso(ms->map));
 			annotate_browser__show(&browser->b, title, help);
 			annotate_browser__debuginfo_warning(browser);
 			continue;
@@ -1146,7 +1146,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	ui_helpline__push("Press ESC to exit");
 
 	if (annotate_opts.code_with_type)
-		browser.dbg = debuginfo__new(dso__long_name(dso));
+		browser.dbg = dso__debuginfo(dso);
 
 	browser.b.width = notes->src->widths.max_line_len;
 	browser.b.nr_entries = notes->src->nr_entries;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ea68b32da7ce584a..bea3457a00632fd7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1270,7 +1270,7 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
 							      notes->src->start);
 	evsel__get_arch(evsel, &apd.arch);
-	apd.dbg = debuginfo__new(filename);
+	apd.dbg = dso__debuginfo(dso);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
 		int err;
@@ -1375,7 +1375,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 
 	if (annotate_opts.code_with_type) {
 		evsel__get_arch(apd->evsel, &apd->arch);
-		apd->dbg = debuginfo__new(dso__long_name(map__dso(apd->he->ms.map)));
+		apd->dbg = dso__debuginfo(map__dso(apd->he->ms.map));
 	}
 
 	list_for_each_entry(al, &notes->src->source, node) {
@@ -2882,7 +2882,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		di_cache.dso = dso__get(map__dso(ms->map));
 
 		debuginfo__delete(di_cache.dbg);
-		di_cache.dbg = debuginfo__new(dso__long_name(di_cache.dso));
+		di_cache.dbg = dso__debuginfo(di_cache.dso);
 	}
 
 	if (di_cache.dbg == NULL) {
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 7df1673f08d3ddb4..fd8e95de77f78dfc 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <linux/bitops.h>
 #include "build-id.h"
+#include "debuginfo.h"
 #include "mutex.h"
 #include <internal/rc_check.h>
 
@@ -914,4 +915,13 @@ u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
 bool perf_pid_map_tid(const char *dso_name, int *tid);
 bool is_perf_pid_map_name(const char *dso_name);
 
+/*
+ * In the future, we may get debuginfo using build-ID (w/o path).
+ * Add this helper is for the smooth conversion.
+ */
+static inline struct debuginfo *dso__debuginfo(struct dso *dso)
+{
+	return debuginfo__new(dso__long_name(dso));
+}
+
 #endif /* __PERF_DSO */
-- 
2.50.1

