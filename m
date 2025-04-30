Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0B2D0AD6;
	Wed, 30 Apr 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046552; cv=none; b=cIQ/SLD8kqtBH5CPFQ1YHZJ5xWdxFZ9lPgiFxa8mU6oSiWwyNjacml9HWd1t2A1Fu8t+Eg8cNPoacoc6V8vm/JX0EnCVYFCuD7p1RUS/TfNOGQjFbwFjJvqSUyR2KP5hYbUKvAXZSViObHTKWfjoPzyXz/hxIIvz+ufSbdThoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046552; c=relaxed/simple;
	bh=L4TzTyAJccQj99m5SJjBS6xHZW5xZZiPDpLmCh83ayg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTNHNcqLNGKTV1eLFexAAt0fI4RccLb/i/V5vC7ZPmlYxw0zj3bXZvwNSgdKnG1T/R3yCm0qS8Dl07GQ9AxLDk2NLBSxxo55SOflPRTnaA/Ffkee8Ljsy8HIg3dNvVzV/y/BueeT5wpjxp2NgYYBZo7Iol44pL6t9nPdcQW0fA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKhr351z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKhr351z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD51C4CEF3;
	Wed, 30 Apr 2025 20:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046552;
	bh=L4TzTyAJccQj99m5SJjBS6xHZW5xZZiPDpLmCh83ayg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKhr351z4IH8+s7+u9gilJe7pTmsA5NwuVovzJhVKcKGMKyQuDIuL/glN8uUtk7PN
	 c1uwKmeSJQUXQpP3GFeL1xYpRe2uZH+NevktJgM7/qf8GDjqunyTjfdAjGs3v+yhUx
	 ReHWYJJJQ5V9rwrDN7IKbNEsFHCiBTb+Z1YQrPAUvgXtBw8S0n3VZWP0dAHtk/Hwkl
	 C3OfZSlZ8kVq6fsTYxZlZrkfLfyVcp/zRrXUsfXhUP7HI3TARvcBepWqw5vmzsQyse
	 kuy4trWuVApDH7LM+ocLyhDw969hUHHe4DZUPpFWrP6TXhcYIeQdCk85MEQ3jqBCRQ
	 4ekO3NcdS3GIQ==
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 03/11] perf hist: Support multi-line header
Date: Wed, 30 Apr 2025 13:55:40 -0700
Message-ID: <20250430205548.789750-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
References: <20250430205548.789750-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation to support multi-line headers in perf mem report.
Normal sort keys and output fields that don't have contents for multi-
line will print the header string at the last line only.

As we don't use multi-line headers normally, it should not have any
changes in the output.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/hists.c | 24 +++++++++-----
 tools/perf/ui/hist.c           |  9 ++++--
 tools/perf/ui/stdio/hist.c     | 57 +++++++++++++++++++++-------------
 tools/perf/util/sort.c         |  8 +++--
 4 files changed, 64 insertions(+), 34 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index cf022e92d06b9b28..67cbdec90d0bf0ea 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1686,7 +1686,8 @@ hists_browser__scnprintf_headers(struct hist_browser *browser, char *buf,
 	return ret;
 }
 
-static int hists_browser__scnprintf_hierarchy_headers(struct hist_browser *browser, char *buf, size_t size)
+static int hists_browser__scnprintf_hierarchy_headers(struct hist_browser *browser,
+						      char *buf, size_t size, int line)
 {
 	struct hists *hists = browser->hists;
 	struct perf_hpp dummy_hpp = {
@@ -1712,7 +1713,7 @@ static int hists_browser__scnprintf_hierarchy_headers(struct hist_browser *brows
 		if (column++ < browser->b.horiz_scroll)
 			continue;
 
-		ret = fmt->header(fmt, &dummy_hpp, hists, 0, NULL);
+		ret = fmt->header(fmt, &dummy_hpp, hists, line, NULL);
 		if (advance_hpp_check(&dummy_hpp, ret))
 			break;
 
@@ -1723,6 +1724,9 @@ static int hists_browser__scnprintf_hierarchy_headers(struct hist_browser *brows
 		first_node = false;
 	}
 
+	if (line < hists->hpp_list->nr_header_lines - 1)
+		return ret;
+
 	if (!first_node) {
 		ret = scnprintf(dummy_hpp.buf, dummy_hpp.size, "%*s",
 				indent * HIERARCHY_INDENT, "");
@@ -1753,7 +1757,7 @@ static int hists_browser__scnprintf_hierarchy_headers(struct hist_browser *brows
 			}
 			first_col = false;
 
-			ret = fmt->header(fmt, &dummy_hpp, hists, 0, NULL);
+			ret = fmt->header(fmt, &dummy_hpp, hists, line, NULL);
 			dummy_hpp.buf[ret] = '\0';
 
 			start = strim(dummy_hpp.buf);
@@ -1772,14 +1776,18 @@ static int hists_browser__scnprintf_hierarchy_headers(struct hist_browser *brows
 
 static void hists_browser__hierarchy_headers(struct hist_browser *browser)
 {
+	struct perf_hpp_list *hpp_list = browser->hists->hpp_list;
 	char headers[1024];
+	int line;
 
-	hists_browser__scnprintf_hierarchy_headers(browser, headers,
-						   sizeof(headers));
+	for (line = 0; line < hpp_list->nr_header_lines; line++) {
+		hists_browser__scnprintf_hierarchy_headers(browser, headers,
+							   sizeof(headers), line);
 
-	ui_browser__gotorc_title(&browser->b, 0, 0);
-	ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
-	ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
+		ui_browser__gotorc_title(&browser->b, line, 0);
+		ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
+		ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
+	}
 }
 
 static void hists_browser__headers(struct hist_browser *browser)
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index bc0689fceeb18bde..ec44633207aa3aba 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -321,11 +321,16 @@ static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 }
 
 static int hpp__header_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-			  struct hists *hists, int line __maybe_unused,
+			  struct hists *hists, int line,
 			  int *span __maybe_unused)
 {
 	int len = hpp__width_fn(fmt, hpp, hists);
-	return scnprintf(hpp->buf, hpp->size, "%*s", len, fmt->name);
+	const char *hdr = "";
+
+	if (line == hists->hpp_list->nr_header_lines - 1)
+		hdr = fmt->name;
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", len, hdr);
 }
 
 int hpp_color_scnprintf(struct perf_hpp *hpp, const char *fmt, ...)
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 7ac4b98e28bca82e..8c4c8925df2c22fc 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -643,45 +643,58 @@ static int hists__fprintf_hierarchy_headers(struct hists *hists,
 	unsigned header_width = 0;
 	struct perf_hpp_fmt *fmt;
 	struct perf_hpp_list_node *fmt_node;
+	struct perf_hpp_list *hpp_list = hists->hpp_list;
 	const char *sep = symbol_conf.field_sep;
 
 	indent = hists->nr_hpp_node;
 
-	/* preserve max indent depth for column headers */
-	print_hierarchy_indent(sep, indent, " ", fp);
-
 	/* the first hpp_list_node is for overhead columns */
 	fmt_node = list_first_entry(&hists->hpp_formats,
 				    struct perf_hpp_list_node, list);
 
-	perf_hpp_list__for_each_format(&fmt_node->hpp, fmt) {
-		fmt->header(fmt, hpp, hists, 0, NULL);
-		fprintf(fp, "%s%s", hpp->buf, sep ?: "  ");
-	}
+	for (int line = 0; line < hpp_list->nr_header_lines; line++) {
+		/* first # is displayed one level up */
+		if (line)
+			fprintf(fp, "# ");
 
-	/* combine sort headers with ' / ' */
-	first_node = true;
-	list_for_each_entry_continue(fmt_node, &hists->hpp_formats, list) {
-		if (!first_node)
-			header_width += fprintf(fp, " / ");
-		first_node = false;
+		/* preserve max indent depth for column headers */
+		print_hierarchy_indent(sep, indent, " ", fp);
 
-		first_col = true;
 		perf_hpp_list__for_each_format(&fmt_node->hpp, fmt) {
-			if (perf_hpp__should_skip(fmt, hists))
-				continue;
+			fmt->header(fmt, hpp, hists, line, NULL);
+			fprintf(fp, "%s%s", hpp->buf, sep ?: "  ");
+		}
 
-			if (!first_col)
-				header_width += fprintf(fp, "+");
-			first_col = false;
+		if (line < hpp_list->nr_header_lines - 1)
+			goto next_line;
+
+		/* combine sort headers with ' / ' */
+		first_node = true;
+		list_for_each_entry_continue(fmt_node, &hists->hpp_formats, list) {
+			if (!first_node)
+				header_width += fprintf(fp, " / ");
+			first_node = false;
 
-			fmt->header(fmt, hpp, hists, 0, NULL);
+			first_col = true;
+			perf_hpp_list__for_each_format(&fmt_node->hpp, fmt) {
+				if (perf_hpp__should_skip(fmt, hists))
+					continue;
 
-			header_width += fprintf(fp, "%s", strim(hpp->buf));
+				if (!first_col)
+					header_width += fprintf(fp, "+");
+				first_col = false;
+
+				fmt->header(fmt, hpp, hists, line, NULL);
+
+				header_width += fprintf(fp, "%s", strim(hpp->buf));
+			}
 		}
+
+next_line:
+		fprintf(fp, "\n");
 	}
 
-	fprintf(fp, "\n# ");
+	fprintf(fp, "# ");
 
 	/* preserve max indent depth for initial dots */
 	print_hierarchy_indent(sep, indent, dots, fp);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 594b75ca95bf72b2..ae8b8ceb82f3d00b 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2641,18 +2641,22 @@ void perf_hpp__reset_sort_width(struct perf_hpp_fmt *fmt, struct hists *hists)
 }
 
 static int __sort__hpp_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-			      struct hists *hists, int line __maybe_unused,
+			      struct hists *hists, int line,
 			      int *span __maybe_unused)
 {
 	struct hpp_sort_entry *hse;
 	size_t len = fmt->user_len;
+	const char *hdr = "";
+
+	if (line == hists->hpp_list->nr_header_lines - 1)
+		hdr = fmt->name;
 
 	hse = container_of(fmt, struct hpp_sort_entry, hpp);
 
 	if (!len)
 		len = hists__col_len(hists, hse->se->se_width_idx);
 
-	return scnprintf(hpp->buf, hpp->size, "%-*.*s", len, len, fmt->name);
+	return scnprintf(hpp->buf, hpp->size, "%-*.*s", len, len, hdr);
 }
 
 static int __sort__hpp_width(struct perf_hpp_fmt *fmt,
-- 
2.49.0.906.g1f30a19c02-goog

