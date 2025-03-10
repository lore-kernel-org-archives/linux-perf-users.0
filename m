Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86A22173D;
	Mon, 10 Mar 2025 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646969; cv=none; b=d0IZs34fXRNMePmjBa38KjC3OjUhab+eU927y5KpeiJitt+P4ctGg47bYUtqWLZ9m6Qb8piqDkFklnIqZAWZJxsFTTvqlWkNRFqhzfROgI/FZg2yeHCN7GQER1OAhQjiJBdY88lH35nD/GL2gvXA0HIBN6JD0ebV9cQyfcRaiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646969; c=relaxed/simple;
	bh=rRoUd6tc+/G0sMXTFIDgeSq+7nNRMG/V3IoW7k2ManE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEy4HO2L6CgLIsHYh0DwrDuWBUXAmxpCKxUHkCvdJr4vGjiPSYfcH8xEe9299v9o8yx9uDQm9L29eslQsK5/gt3JC9AI1A6FpLtdlZO6gLT8CVJgBIbMAIPRKRxgAemvwhn2xgkfzFMuBZbyiW2kn8JbpZmKvWDqUdhqBU9Pn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvCJe8pI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvCJe8pI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE30C4CEF0;
	Mon, 10 Mar 2025 22:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741646969;
	bh=rRoUd6tc+/G0sMXTFIDgeSq+7nNRMG/V3IoW7k2ManE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvCJe8pIUPR4S3D/LNQorA/J794pAOGM2SCddU7yM24EjIRXQNXbILoLhoxCn+XbW
	 T5EAGw95ya1MaIfdoYoL56VEkWqI9sQOdTwkONmyHAufnRD4rJ1pHLPSiFTI2ATQVk
	 uII26XjUvu2CG6ZFWaWyKdICpZyQsGbzfRncA0Ao1a28kJwwqjLvxpJkW3yrXA1QqZ
	 dIB4UPPQOqIt0nJrcENk71eJnoLmjR4bUKT1N+MdqWE3ZB/0y6ruXLDQM0+gGOEZSn
	 urNc25H+rNXTP9OsJokLnGqkgQqmbfH42c7pgKRX6hBvuC8MBhAvGPBt/kgzYszzJR
	 s8mGLw+ptnIIQ==
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
Subject: [PATCH v2 6/7] perf annotate: Implement code + data type annotation
Date: Mon, 10 Mar 2025 15:49:24 -0700
Message-ID: <20250310224925.799005-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250310224925.799005-1-namhyung@kernel.org>
References: <20250310224925.799005-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
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
index 4eda409bfe0ea859..0e6e3f60a897b850 100644
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
2.49.0.rc0.332.g42c0ae87b1-goog

