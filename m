Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42B519F40B;
	Sun,  1 Jun 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748760786; cv=none; b=PT7EsvieW3zs1zVrkphsRemHauiM8YcAvF+7QrXYyLbCml0a9QXJ46raDvD70TrEGww2kbs+jBCfnbeGXezgPfO8JXNAc0V+uPuxrZ09sGrOWF1G9gcGp0wkhbxlNAP28xPGXxLVaCia8bQx4EILDnbpuu/awXk8ayIT+Mv4528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748760786; c=relaxed/simple;
	bh=+cfucBX5cy1DW4FpLSQqN4Bp+xknd+/eBxoN/P9e848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvB1I5OEsuTd1N7VZab6goTPgWXMq31BtR/hMWmH0QiCR6xEtWMcqa3w6BR5k+7lgK4LGvWqQ3H6su2l7AQKKlAZRjVAmSgj3IWs7iO2o956/L5EIaamqdVhY+uTHc5j6/JSRG59QDtmoklk/j754jl/Uu2uKZPf9OqO1owINQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMGydDoh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMGydDoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711CFC4CEE7;
	Sun,  1 Jun 2025 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748760785;
	bh=+cfucBX5cy1DW4FpLSQqN4Bp+xknd+/eBxoN/P9e848=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMGydDohWxSpv7s1Asy4FPasgWad8N63Liap9Vr0PwzoqftasFVhuvpSyhD2z0jDa
	 bT5D6jEzO2RiY0DKdE8sS2kTYqwn6b+JP6vmhx5mkY7tdYm7dn3xn1NP6X/nrJM0pz
	 Tuu099sHyXrgPYRB62H5AwBWy9gJ6il9AFMb9JAauemw5FBdYF5b2BBDAE2xApk6HK
	 eXED5aktYN6/PDPMThBVoGSLGVdhPeYKB4Q+1xzi/b7N3urW2oPWOYKNgs9jaY2e6E
	 BxeriQvESDs3bCukR8LZjUIvUvUpENpLqFbtnCwMwe/O4vWX9KJcz86b4I+rYUcZYC
	 i7b3urd8/F+Ig==
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
Subject: [PATCH 5/6] perf annotate: Add --code-with-type support for TUI
Date: Sat, 31 May 2025 23:53:01 -0700
Message-ID: <20250601065302.12531-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601065302.12531-1-namhyung@kernel.org>
References: <20250601065302.12531-1-namhyung@kernel.org>
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
index 94f73c8944cde519..bf480f5b87eedd50 100644
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
@@ -2114,11 +2122,52 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 
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

