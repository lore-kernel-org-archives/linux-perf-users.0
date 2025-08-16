Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5E1DF256;
	Sat, 16 Aug 2025 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314209; cv=none; b=JsjEDQxls43JK1/LB6s7V2f7Qj/sBwxsU+DoPEA06q876YZbAb80Z2dD4oiS/t+i6HTqH9SQyztrQtGBJc0XB11VGG+OnRKaUGVpnPRkQ9aaBnc6tYUh0aMUi02KQp4jgsYlfWypvClTt8z6QAbBptu4ormwqNr+mTwje20G1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314209; c=relaxed/simple;
	bh=f55lAbXw2gvkAvto69pqFf64NHcOnxAXKXI89Ga3qVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms1oZbMfjhSI9+fps47U2TnTfk7LKjj0LVTcntBNEswMMwtmv5H2r65zmLCzRG6eV5KQ2YlIvkoPC5e5/TYfKfi2+7ObpSqAvzs0rgXAzA7p2Wi6rbPuIrFdn7zoXGeiK4ncvcMl5xuzoUgIYWfNKZ/w1k79MpL03rFYnBeLveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzezQ+Z+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzezQ+Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A928C4CEFB;
	Sat, 16 Aug 2025 03:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314208;
	bh=f55lAbXw2gvkAvto69pqFf64NHcOnxAXKXI89Ga3qVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzezQ+Z+lqnk5gfRfFDPL/1HGykdwfYPjYp/VQHtSzkLm0MarV5tC0QUQxVBoWtPM
	 ZdTRqoAj4G5B7Y8vAxh5ayGC3GDnqN7/LJ3bqIV5WMEcmIX2A022f28mS5E3KEPyfz
	 /5C3DYuzSqgfeXi70uAxPzp3IByUHhEgSIIKJs0j92J6/C2qpJn0Z+82PV6Vj9eEsz
	 RQyZZoC/uiR2EL2OGYYvApe6ImOK1u4eazP+r0rxoe2icTw2t7NgISh2Nd7kZ34e3x
	 rSl++8lLwaal8ce2W4WlLY0Al9XLYGpLJVyN9r/TrJtomDiiLxi30lRtW8VSjrPOnJ
	 yw7krAx4aVa9g==
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
Subject: [PATCH v5 07/12] perf annotate: Add --code-with-type support for TUI
Date: Fri, 15 Aug 2025 20:16:30 -0700
Message-ID: <20250816031635.25318-8-namhyung@kernel.org>
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

Until now, the --code-with-type option is available only on stdio.
But it was an artifical limitation because of an implemention issue.

Implement the same logic in annotation_line__write() for stdio2/TUI
and remove the limitation and update the man page.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-annotate.txt |  1 -
 tools/perf/builtin-annotate.c              |  5 ---
 tools/perf/ui/browsers/annotate.c          |  6 +++
 tools/perf/util/annotate.c                 | 47 ++++++++++++++++++++--
 4 files changed, 50 insertions(+), 9 deletions(-)

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
index 5d57d2913f3d9a33..646f43b0f7c4c9b0 100644
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
index 3e8b111e3f12b030..e5b35336f0d33d7e 100644
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
@@ -1119,6 +1120,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ui_helpline__push("Press ESC to exit");
 
+	if (annotate_opts.code_with_type)
+		browser.dbg = debuginfo__new(dso__long_name(dso));
+
 	browser.b.width = notes->src->widths.max_line_len;
 	browser.b.nr_entries = notes->src->nr_entries;
 	browser.b.entries = &notes->src->source;
@@ -1129,6 +1133,8 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
+	if (annotate_opts.code_with_type)
+		debuginfo__delete(browser.dbg);
 	if (not_annotated && !notes->src->tried_source)
 		annotated_source__purge(notes->src);
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 698bc4f559e83043..99e976d254493de2 100644
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
 
@@ -1935,6 +1943,36 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
 	return -ENOMEM;
 }
 
+static int disasm_line__snprint_type_info(struct disasm_line *dl,
+					  char *buf, int len,
+					  struct annotation_print_data *apd)
+{
+	struct annotated_data_type *data_type;
+	char member[256];
+	int offset = 0;
+	int printed;
+
+	scnprintf(buf, len, " ");
+
+	if (!annotate_opts.code_with_type || apd->dbg == NULL)
+		return 1;
+
+	data_type = __hist_entry__get_data_type(apd->he, apd->arch, apd->dbg, dl, &offset);
+	if (data_type == NULL || data_type == NO_TYPE)
+		return 1;
+
+	printed = scnprintf(buf, len, "\t\t# data-type: %s", data_type->self.type_name);
+
+	if (data_type != &stackop_type && data_type != &canary_type && len > printed)
+		printed += scnprintf(buf + printed, len - printed, " +%#x", offset);
+
+	if (annotated_data_type__get_member_name(data_type, member, sizeof(member), offset) &&
+	    len > printed) {
+		printed += scnprintf(buf + printed, len - printed, " (%s)", member);
+	}
+	return printed;
+}
+
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
 			    const struct annotation_write_ops *wops,
 			    struct annotation_print_data *apd)
@@ -2118,11 +2156,14 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 
 		width -= printed;
 
-		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
+		printed = disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf),
+					     obj__printf, obj__write_graph);
 
-		obj__printf(obj, "%-*s", width, bf);
+		obj__printf(obj, "%s", bf);
+		width -= printed;
 
-		(void)apd;
+		disasm_line__snprint_type_info(disasm_line(al), bf, sizeof(bf), apd);
+		obj__printf(obj, "%-*s", width, bf);
 	}
 
 }
-- 
2.50.1

