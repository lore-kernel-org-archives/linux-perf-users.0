Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2423907E;
	Mon,  3 Mar 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023491; cv=none; b=Yfjze8ZX1xTok9v9B1F/3JS/toRf0BChgMK7UUqbX5pWxyR3PT3jZlAgg3FxuCHstL1c+LmCuk+1s0qAsQPTOey/xNpskAmdj8ckT1+co1k9cfVRL2ZFlG4+VKnHH7ybdnGV6Xg2mmd24l4G02QtyhZJtN0/7wHCjSf9QuvKkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023491; c=relaxed/simple;
	bh=famquw8nYkbZxiu+CNFHV8taHaNDrhKSZuh6JvxAAas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4eRP4oF+8erpJ+nv0b6uorRPbGxKsMjB2gT85MHEnFigc9HC+0Yii0g4cEgHB7JDT/M+noU5cBa/YGZo+Ke8/y3icLsmC7zxxhvjQcevezbsmKwxq/ZOk5Cl9fdH9pOCfcrC9KUmVuDmx06+HIFwAS3DPkXfay/XOYCPmjU73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNPQER4Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNPQER4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54E4C4CEE6;
	Mon,  3 Mar 2025 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023491;
	bh=famquw8nYkbZxiu+CNFHV8taHaNDrhKSZuh6JvxAAas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNPQER4Yu064hP2ExPwZX8dUlj8Op3aYOXKPc22OYWMvHSKF0e5xKC83JXxw4FN5K
	 WqklQRn0wfQqQkR5Tdfg64lyGTgaIS4HN2XfnUFy5ELYLEKfwsVBBVbcu0CZcongft
	 cx+t/+iAm6g9LyLOfo8rz+sT67786ojmlyAOE1zaqsHu6XmS6/5OKuoUF12++B8nhV
	 Cdp7h5YUposCFjQlPXtcJ06Ctj9cVCSfa0FgmCgpqUFujs8EAsDqKCBolK7vWRjUKm
	 VhZK0hscCbUM/egtTmqoLCI7H2Dx0hkLNvy3wfUTU0J3NIUnz5UKct/AEcdFY3V6IY
	 rbhX6B7oAFarQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 6/7] perf annotate: Implement code + data type annotation
Date: Mon,  3 Mar 2025 09:38:06 -0800
Message-ID: <20250303173807.1765098-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303173807.1765098-1-namhyung@kernel.org>
References: <20250303173807.1765098-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes it's useful to see both instructions and their data type
together.  Let's extend the annotate code to use data type profiling
functions.

To make it easy to pass more argument, introduce a struct to carry
necessary information together.  Also add a new annotation_option called
'code_with_type' to control the behavior.  This is not enabled yet but
it'll be set later from the command line.

For simplicity, this is implemented for --stdio only.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 73 ++++++++++++++++++++++++++++++--------
 tools/perf/util/annotate.h |  1 +
 2 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8a67340a64b94c39..1e59b9e5339d393b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -760,11 +760,26 @@ static int disasm_line__print(struct disasm_line *dl, u64 start, int addr_fmt_wi
 	return 0;
 }
 
+static struct annotated_data_type *
+__hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
+			    struct debuginfo *dbg, struct disasm_line *dl,
+			    int *type_offset);
+
+struct annotation_print_data {
+	struct hist_entry *he;
+	struct evsel *evsel;
+	struct arch *arch;
+	struct debuginfo *dbg;
+	u64 start;
+	int addr_fmt_width;
+};
+
 static int
-annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
-		       struct evsel *evsel, struct annotation_options *opts,
-		       int printed, struct annotation_line *queue, int addr_fmt_width)
+annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
+		       struct annotation_options *opts, int printed,
+		       struct annotation_line *queue)
 {
+	struct symbol *sym = apd->he->ms.sym;
 	struct disasm_line *dl = container_of(al, struct disasm_line, al);
 	struct annotation *notes = symbol__annotation(sym);
 	static const char *prev_line;
@@ -804,10 +819,8 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 			list_for_each_entry_from(queue, &notes->src->source, node) {
 				if (queue == al)
 					break;
-				annotation_line__print(queue, sym, start, evsel,
-						       &queue_opts, /*printed=*/0,
-						       /*queue=*/NULL,
-						       addr_fmt_width);
+				annotation_line__print(queue, apd, &queue_opts,
+						       /*printed=*/0, /*queue=*/NULL);
 			}
 		}
 
@@ -832,7 +845,31 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 
 		printf(" : ");
 
-		disasm_line__print(dl, start, addr_fmt_width);
+		disasm_line__print(dl, apd->start, apd->addr_fmt_width);
+
+		if (opts->code_with_type && apd->dbg) {
+			struct annotated_data_type *data_type;
+			int offset = 0;
+
+			data_type = __hist_entry__get_data_type(apd->he, apd->arch,
+								apd->dbg, dl, &offset);
+			if (data_type && data_type != NO_TYPE) {
+				char buf[4096];
+
+				printf("\t\t# data-type: %s",
+				       data_type->self.type_name);
+
+				if (data_type != &stackop_type &&
+				    data_type != &canary_type)
+					printf(" +%#x", offset);
+
+				if (annotated_data_type__get_member_name(data_type,
+									 buf,
+									 sizeof(buf),
+									 offset))
+					printf(" (%s)", buf);
+			}
+		}
 
 		/*
 		 * Also color the filename and line if needed, with
@@ -858,7 +895,8 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		if (!*al->line)
 			printf(" %*s:\n", width, " ");
 		else
-			printf(" %*s: %-*d %s\n", width, " ", addr_fmt_width, al->line_nr, al->line);
+			printf(" %*s: %-*d %s\n", width, " ", apd->addr_fmt_width,
+			       al->line_nr, al->line);
 	}
 
 	return 0;
@@ -1189,8 +1227,12 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	struct sym_hist *h = annotation__histogram(notes, evsel);
 	struct annotation_line *pos, *queue = NULL;
 	struct annotation_options *opts = &annotate_opts;
-	u64 start = map__rip_2objdump(map, sym->start);
-	int printed = 2, queue_len = 0, addr_fmt_width;
+	struct annotation_print_data apd = {
+		.he = he,
+		.evsel = evsel,
+		.start = map__rip_2objdump(map, sym->start),
+	};
+	int printed = 2, queue_len = 0;
 	int more = 0;
 	bool context = opts->context;
 	int width = annotation__pcnt_width(notes);
@@ -1224,7 +1266,10 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 	if (verbose > 0)
 		symbol__annotate_hits(sym, evsel);
 
-	addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source, start);
+	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
+							      apd.start);
+	evsel__get_arch(evsel, &apd.arch);
+	apd.dbg = debuginfo__new(filename);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
 		int err;
@@ -1234,8 +1279,7 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 			queue_len = 0;
 		}
 
-		err = annotation_line__print(pos, sym, start, evsel,
-					     opts, printed, queue, addr_fmt_width);
+		err = annotation_line__print(pos, &apd, opts, printed, queue);
 
 		switch (err) {
 		case 0:
@@ -1266,6 +1310,7 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 		}
 	}
 
+	debuginfo__delete(apd.dbg);
 	free(filename);
 
 	return more;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 4fba7cde4968db74..03a7cc24058ff5a2 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -55,6 +55,7 @@ struct annotation_options {
 	     show_asm_raw,
 	     show_br_cntr,
 	     annotate_src,
+	     code_with_type,
 	     full_addr;
 	u8   offset_level;
 	u8   disassemblers[MAX_DISASSEMBLERS];
-- 
2.48.1.711.g2feabab25a-goog

