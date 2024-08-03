Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF37A15B;
	Sat,  3 Aug 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722719616; cv=none; b=T3m+9pfYvZ4pS9wvY9gWuNqSccnEpFYkL6acbpA5asRfRZIrf02C8jXNHpK0eTq0RvyP5Ytwci6zMiiIp/tpOzlXBRF7IGKuCRWjydlDeFJz1Jz2TrwcVpmthMADZwhEeSTTyHKwRUNKzLiz3ZPuDZh8wBzFzuBOcfGudpnw8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722719616; c=relaxed/simple;
	bh=ok6PGsh/+Fs0qcgvUyNyMRF5vVVomjzdfg9xzoFAORo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDitCgvyJS+z2dCNMSdepTSD7ntCwk5VzcMFPe5Q80tpR2a/XCZwlv1uT6AAUlbIym9X8RhfL+jg9ZCs6S3tBeSLf05LuIe0bI0q2x/ZSYXtKS2M5njH4zL0KFMtwSiHVNyD7xrRzjoBeiiV3+OgBmTJ0hsnaqZIdf0SYu9eK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMtjZvvr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMtjZvvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0B6C4AF1D;
	Sat,  3 Aug 2024 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722719615;
	bh=ok6PGsh/+Fs0qcgvUyNyMRF5vVVomjzdfg9xzoFAORo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMtjZvvr0G/yrL4T01dk6hUg3726zZlHsLGUTieKY0RB/Wb5t98AQqbFAQ8xVqr1M
	 JN6M512kOxcqEWRuhXFY0QYrzWGhXPk6gL98RIKpW4kMmFwja0KvjiQl9CV6l3TCMv
	 Lu2yatIlIp3lbPAY+0mk/nk17rynShp1NSqrr1AN5PNYjwBCHWvmMyX3zdyx/3ZJ0f
	 eCjcf7hfDWf4NyfxPcafeTi5g7F3jLaXFN0edqEY8HlMPkG3i/+9wEBmHgxRRzmB+N
	 J5d3hPCXZOtDar6mRRrUHjZwTkv1Z27JcE8JP/z+hEGeHT97bi5Q9dhOp8KbRWWil9
	 oeA569INLjTDA==
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
Subject: [PATCH 3/5] perf annotate: Use annotation__pcnt_width() consistently
Date: Sat,  3 Aug 2024 14:13:30 -0700
Message-ID: <20240803211332.1107222-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240803211332.1107222-1-namhyung@kernel.org>
References: <20240803211332.1107222-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The annotation__pcnt_width() calculates the screen width for the
overhead (percent) area considering event groups properly.  Use this
function consistently so that we can make sure it has similar output
in different modes.  But there's a difference in stdio and tui output:
stdio uses 8 and tui uses 7 for a percent.

Let's use 8 and adjust the print width in __annotation_line__write()
properly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 14 +++++---------
 tools/perf/util/annotate.h |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 09e6fdf344db..917897fe44a2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -699,13 +699,13 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		       int percent_type)
 {
 	struct disasm_line *dl = container_of(al, struct disasm_line, al);
+	struct annotation *notes = symbol__annotation(sym);
 	static const char *prev_line;
 
 	if (al->offset != -1) {
 		double max_percent = 0.0;
 		int i, nr_percent = 1;
 		const char *color;
-		struct annotation *notes = symbol__annotation(sym);
 
 		for (i = 0; i < al->data_nr; i++) {
 			double percent;
@@ -775,14 +775,11 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 	} else if (max_lines && printed >= max_lines)
 		return 1;
 	else {
-		int width = symbol_conf.show_total_period ? 12 : 8;
+		int width = annotation__pcnt_width(notes);
 
 		if (queue)
 			return -1;
 
-		if (evsel__is_group_event(evsel))
-			width *= evsel->core.nr_members;
-
 		if (!*al->line)
 			printf(" %*s:\n", width, " ");
 		else
@@ -1111,7 +1108,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 	int more = 0;
 	bool context = opts->context;
 	u64 len;
-	int width = symbol_conf.show_total_period ? 12 : 8;
+	int width = annotation__pcnt_width(notes);
 	int graph_dotted_len;
 	char buf[512];
 
@@ -1127,7 +1124,6 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 	len = symbol__size(sym);
 
 	if (evsel__is_group_event(evsel)) {
-		width *= evsel->core.nr_members;
 		evsel__group_desc(evsel, buf, sizeof(buf));
 		evsel_name = buf;
 	}
@@ -1703,10 +1699,10 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 			if (symbol_conf.show_total_period) {
 				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
 			} else if (symbol_conf.show_nr_samples) {
-				obj__printf(obj, "%6" PRIu64 " ",
+				obj__printf(obj, "%7" PRIu64 " ",
 						   al->data[i].he.nr_samples);
 			} else {
-				obj__printf(obj, "%6.2f ", percent);
+				obj__printf(obj, "%7.2f ", percent);
 			}
 		}
 	} else {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 9ba772f46270..64e70d716ff1 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -339,7 +339,7 @@ static inline int annotation__cycles_width(struct annotation *notes)
 
 static inline int annotation__pcnt_width(struct annotation *notes)
 {
-	return (symbol_conf.show_total_period ? 12 : 7) * notes->src->nr_events;
+	return (symbol_conf.show_total_period ? 12 : 8) * notes->src->nr_events;
 }
 
 static inline bool annotation_line__filter(struct annotation_line *al)
-- 
2.46.0.rc2.264.g509ed76dc8-goog

