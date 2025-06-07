Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1F21D3E3;
	Sat,  7 Jun 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338745; cv=none; b=cIRqL607j78Lmp8ZBrthCyqcJDc7RW2aZGz1lUKqyFcWLQPglzCiFAvyFAkAptxOBRoHcG3mKcM74KOH8+JSMLNsKi+Ac0BRpe6CF30uTL/l8r3eIXP6ngRtPgd97TQrWnaH6drBbWZIxfbWNtAPRfAVI5URTLMHVgOKdqvRVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338745; c=relaxed/simple;
	bh=0gAaF4tU2eoAyEorQKKKwcSIIwy3Vr9mHGFaKlgrz48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzF9Oml50a9/pUYc3Km3pejm3Pt7vWh8mUd7WhMqUXQpU/xzPXX/kckGe1ymCElcSfFdIcCTSnO78KzsbdutlqTrtMIvJvOupwCrMgjFmzbFly4mPsbxjj1T1EUV4b1vr5eABOJV82dvZx1BNI62cxNsfzbXzAXvvom5Sz6TJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gsi2vuzp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gsi2vuzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B64C4CEF0;
	Sat,  7 Jun 2025 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749338744;
	bh=0gAaF4tU2eoAyEorQKKKwcSIIwy3Vr9mHGFaKlgrz48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gsi2vuzpA3+Qo+2YSzOFXfba41SIIePNpv7hY8Lv9X5+GiH/FromCY8r8hdiDL5J2
	 nR6lqEBj9zPqM1cwCdILY0ans3bY5jWJm9sOaC55ZUiyYsB2ROmjS89IxuhmVL3wSy
	 9GiL+d4zEYFSJNFU/ZGLFB4T+qjx7YCWIIhSu/P+ZJZ0DG1T/RDxKc8kIhTd6zUSxB
	 AuHBFEqSP0rvIYxjQMb7SeSZ9epuyYsS402V95kHoIN3e4Hx0EF4fYe8GANPliExm2
	 FkMhewecoXKSWaAOWVX1oMqvyV3/xEX9O+KIq/wMaBgNEdSPginttiyGLykluOBGwC
	 OHQzNB2TM/l6Q==
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
Subject: [PATCH v2 5/7] perf annotate: Add --code-with-type support for TUI
Date: Sat,  7 Jun 2025 16:25:38 -0700
Message-ID: <20250607232540.89488-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607232540.89488-1-namhyung@kernel.org>
References: <20250607232540.89488-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now, the --code-with-type option is available only on stdio.
But it was an artifical limitation because of an implemention issue.

Implement the same logic in annotation_line__write() for stdio2/TUI.
Make disasm_line__write() return the number of printed characters so
that it can skip unnecessary operations when the screen is full.

Remove the limitation and update the man page.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-annotate.txt |  1 -
 tools/perf/builtin-annotate.c              |  5 --
 tools/perf/ui/browsers/annotate.c          |  6 +++
 tools/perf/util/annotate.c                 | 61 +++++++++++++++++++---
 4 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 46090c5b42b4762f..547f1a2680185e3c 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -170,7 +170,6 @@ include::itrace.txt[]
 
 --code-with-type::
 	Show data type info in code annotation (for memory instructions only).
-	Currently it only works with --stdio option.
 
 
 SEE ALSO
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 9833c2c82a2fee46..6debd725392db4a4 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -917,11 +917,6 @@ int cmd_annotate(int argc, const char **argv)
 		symbol_conf.annotate_data_sample = true;
 	} else if (annotate_opts.code_with_type) {
 		symbol_conf.annotate_data_member = true;
-
-		if (!annotate.use_stdio) {
-			pr_err("--code-with-type only works with --stdio.\n");
-			goto out_delete;
-		}
 	}
 
 	setup_browser(true);
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 0057fb485e85aaaf..686fa54e545e275c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -4,6 +4,7 @@
 #include "../ui.h"
 #include "../../util/annotate.h"
 #include "../../util/debug.h"
+#include "../../util/debuginfo.h"
 #include "../../util/dso.h"
 #include "../../util/hist.h"
 #include "../../util/sort.h"
@@ -1021,6 +1022,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ui_helpline__push("Press ESC to exit");
 
+	if (annotate_opts.code_with_type)
+		browser.dbg = debuginfo__new(dso__long_name(dso));
+
 	browser.b.width = notes->src->widths.max_line_len;
 	browser.b.nr_entries = notes->src->nr_entries;
 	browser.b.entries = &notes->src->source;
@@ -1031,6 +1035,8 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
+	if (annotate_opts.code_with_type)
+		debuginfo__delete(browser.dbg);
 	if(not_annotated)
 		annotated_source__purge(notes->src);
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fb7a63b8e253ca9a..4a88c69db595c323 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1362,6 +1362,11 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	};
 	struct annotation_line *al;
 
+	if (annotate_opts.code_with_type) {
+		evsel__get_arch(apd->evsel, &apd->arch);
+		apd->dbg = debuginfo__new(dso__long_name(map__dso(apd->he->ms.map)));
+	}
+
 	list_for_each_entry(al, &notes->src->source, node) {
 		if (annotation_line__filter(al))
 			continue;
@@ -1370,6 +1375,9 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 		wops.first_line = false;
 	}
 
+	if (annotate_opts.code_with_type)
+		debuginfo__delete(apd->dbg);
+
 	return 0;
 }
 
@@ -1742,7 +1750,7 @@ static double annotation_line__max_percent(struct annotation_line *al,
 	return percent_max;
 }
 
-static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
+static int disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 			       void *obj, char *bf, size_t size,
 			       void (*obj__printf)(void *obj, const char *fmt, ...),
 			       void (*obj__write_graph)(void *obj, int graph))
@@ -1770,8 +1778,8 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 		obj__printf(obj, "  ");
 	}
 
-	disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
-			       notes->src->widths.max_ins_name);
+	return disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
+				      notes->src->widths.max_ins_name);
 }
 
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
@@ -2115,11 +2123,52 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 
 		width -= printed + 3;
 
-		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
+		printed = disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf),
+					     obj__printf, obj__write_graph);
+
+		obj__printf(obj, "%s", bf);
+		width -= printed;
+
+		if (annotate_opts.code_with_type && apd->dbg) {
+			struct annotated_data_type *data_type;
+			int offset = 0;
+
+			data_type = __hist_entry__get_data_type(apd->he, apd->arch,
+								apd->dbg,
+								disasm_line(al),
+								&offset);
+			if (data_type && data_type != NO_TYPE) {
+				char member[256];
+
+				printed = scnprintf(bf, sizeof(bf),
+						    "\t\t# data-type: %s",
+						    data_type->self.type_name);
 
-		obj__printf(obj, "%-*s", width, bf);
+				if (data_type != &stackop_type &&
+				    data_type != &canary_type &&
+				    sizeof(bf) > (size_t)printed) {
+					printed += scnprintf(bf + printed,
+							     sizeof(bf) - printed,
+							     " +%#x", offset);
+				}
+
+				if (annotated_data_type__get_member_name(data_type,
+									 member,
+									 sizeof(member),
+									 offset) &&
+				    sizeof(bf) > (size_t)printed) {
+					printed += scnprintf(bf + printed,
+							     sizeof(bf) - printed,
+							     " (%s)", member);
+				}
 
-		(void)apd;
+				obj__printf(obj, "%-*s", width, bf);
+			} else {
+				obj__printf(obj, "%-*s", width, " ");
+			}
+		} else {
+			obj__printf(obj, "%-*s", width, " ");
+		}
 	}
 
 }
-- 
2.49.0

