Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADD4C8E;
	Sun,  8 Jun 2025 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749343586; cv=none; b=Y2Qm2/ydT94i1Gze7iac2zUBXQbpwX2kfTk7eLKLJ9LTZ2qI8OG/B4dL3ivoxdp76MF59VlqxWp6iuTS4ks+OTshniIGqzbAokzc3/iTzL9vwyzdJ6Jueqek4J+oM3rkynFrjBtn/nKegGyvG2DUmqKVU+CZmLqmnVFz+fCpKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749343586; c=relaxed/simple;
	bh=Fp7T3V/QSAricMxCzvCPDfiMJjRar1Zwu6b6fSOeInE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3g8Pi+hZF5idrO+CB9IuUPTAy+8UhIPkzX9hs8oQsxJWzV6IegrqPh5KmJazUZlcDDsESAlGshqxJ8KZqOPG2hPdbqL5tY+gtZ3sTzXKZBpRdurv+qQ6ZTvlqpkPh5eDlkhbAiyQM014leCHsYPwk73fCj/K6wQ3DNuU/W7DJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMLxrRdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMLxrRdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E90C4CEE4;
	Sun,  8 Jun 2025 00:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749343586;
	bh=Fp7T3V/QSAricMxCzvCPDfiMJjRar1Zwu6b6fSOeInE=;
	h=From:To:Cc:Subject:Date:From;
	b=RMLxrRdwxkJ3P0hiHPjpoOgS0QC2Y4bOP0+IQwqpA10UhKE1y6Y1G988rYn4sO2vu
	 aCYMjnCFU7eC4T4J+RS8xeigASplqVcijOowS3qjRb5YGLPuiLBqDW9yuhn1OEyAj/
	 14Vw582VeyU4qZSUGw8XsmDUlocuc6hx9RK6O2HAy7QKAwtRoflc1w3KdFE8Myvd74
	 V0X6DNSN4RsDW1yiRHNHMwkD4bfNX4ZuLP5+iqwH4O0JNYvba+s9/BqTHGVIh2ac0m
	 SN16mzqaU4pGjaIlU0qtNl6hUSykQidgAfT2WsLOdG4595NayI2xIjYudUJ8RkFa15
	 Eyi8r5lJbGP0A==
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
Subject: [PATCH v2] perf annotate: Fix source code annotate with objdump
Date: Sat,  7 Jun 2025 17:46:13 -0700
Message-ID: <20250608004613.238291-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently it uses llvm and capstone to speed up annotation or disassembly
of instructions.  But they don't support source code view yet.  Until it
fixed, we can force to use objdump for source code annotation.

To prevent performance loss, it's disabled by default and turned it on
when user requests it in TUI by pressing 's' key.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2)
 * fix build error  (Arnaldo)
 * move to the first line when new asm line isn't found  (Arnaldo)

 tools/perf/ui/browsers/annotate.c | 51 +++++++++++++++++++++++++++++--
 tools/perf/util/annotate.c        |  2 ++
 tools/perf/util/annotate.h        |  1 +
 tools/perf/util/disasm.c          |  7 +++++
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ab776b1ed2d5b4ba..df518ca1117d2498 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -345,6 +345,23 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 	browser->curr_hot = rb_last(&browser->entries);
 }
 
+static struct annotation_line *annotate_browser__find_new_asm_line(
+					struct annotate_browser *browser,
+					int idx_asm)
+{
+	struct annotation_line *al;
+	struct list_head *head = browser->b.entries;
+
+	/* find an annotation line in the new list with the same idx_asm */
+	list_for_each_entry(al, head, node) {
+		if (al->idx_asm == idx_asm)
+			return al;
+	}
+
+	/* There are no asm lines */
+	return NULL;
+}
+
 static struct annotation_line *annotate_browser__find_next_asm_line(
 					struct annotate_browser *browser,
 					struct annotation_line *al)
@@ -368,7 +385,8 @@ static struct annotation_line *annotate_browser__find_next_asm_line(
 	return NULL;
 }
 
-static bool annotate_browser__toggle_source(struct annotate_browser *browser)
+static bool annotate_browser__toggle_source(struct annotate_browser *browser,
+					    struct evsel *evsel)
 {
 	struct annotation *notes = browser__annotation(&browser->b);
 	struct annotation_line *al;
@@ -377,6 +395,35 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 	browser->b.seek(&browser->b, offset, SEEK_CUR);
 	al = list_entry(browser->b.top, struct annotation_line, node);
 
+	if (!annotate_opts.annotate_src)
+		annotate_opts.annotate_src = true;
+
+	/*
+	 * It's about to get source code annotation for the first time.
+	 * Drop the existing annotation_lines and get the new one with source.
+	 * And then move to the original line at the same asm index.
+	 */
+	if (annotate_opts.hide_src_code && !notes->src->tried_source) {
+		struct map_symbol *ms = browser->b.priv;
+		int orig_idx_asm = al->idx_asm;
+
+		notes->src->tried_source = true;
+
+		/* annotate again with source code info */
+		annotate_opts.hide_src_code = false;
+		annotated_source__purge(notes->src);
+		symbol__annotate2(ms, evsel, &browser->arch);
+		annotate_opts.hide_src_code = true;
+
+		browser->b.entries = &notes->src->source;
+		al = annotate_browser__find_new_asm_line(browser, orig_idx_asm);
+		if (unlikely(al == NULL)) {
+			al = list_first_entry(&notes->src->source,
+					      struct annotation_line, node);
+		}
+		browser->b.seek(&browser->b, al->idx_asm, SEEK_SET);
+	}
+
 	if (annotate_opts.hide_src_code) {
 		if (al->idx_asm < offset)
 			offset = al->idx;
@@ -833,7 +880,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			nd = browser->curr_hot;
 			break;
 		case 's':
-			if (annotate_browser__toggle_source(browser))
+			if (annotate_browser__toggle_source(browser, evsel))
 				ui_helpline__puts(help);
 			annotate__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(&browser->b, title, help);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 264a212b47df850c..0dd475a744b6dfac 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1451,6 +1451,7 @@ void annotated_source__purge(struct annotated_source *as)
 		list_del_init(&al->node);
 		disasm_line__free(disasm_line(al));
 	}
+	as->tried_source = false;
 }
 
 static size_t disasm_line__fprintf(struct disasm_line *dl, FILE *fp)
@@ -2280,6 +2281,7 @@ void annotation_options__init(void)
 	opt->annotate_src = true;
 	opt->offset_level = ANNOTATION__OFFSET_JUMP_TARGETS;
 	opt->percent_type = PERCENT_PERIOD_LOCAL;
+	opt->hide_src_code = true;
 	opt->hide_src_code_on_title = true;
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index bbb89b32f398b3c9..8b5131d257b01e3e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -294,6 +294,7 @@ struct annotated_source {
 	int			nr_entries;
 	int			nr_asm_entries;
 	int			max_jump_sources;
+	bool			tried_source;
 	u64			start;
 	struct {
 		u8		addr;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 8f0eb56c6fc66a96..ff475a239f4b0db4 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -2284,6 +2284,13 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		}
 	}
 
+	/* FIXME: LLVM and CAPSTONE should support source code */
+	if (options->annotate_src && !options->hide_src_code) {
+		err = symbol__disassemble_objdump(symfs_filename, sym, args);
+		if (err == 0)
+			goto out_remove_tmp;
+	}
+
 	err = -1;
 	for (u8 i = 0; i < ARRAY_SIZE(options->disassemblers) && err != 0; i++) {
 		enum perf_disassembler dis = options->disassemblers[i];
-- 
2.49.0

