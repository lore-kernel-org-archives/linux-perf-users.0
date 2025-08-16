Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438571CAA79;
	Sat, 16 Aug 2025 03:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314207; cv=none; b=f0xpJl3dr2yh/VBKkp775nQWQKvapYj9Sl5FvWLyszhVlN/ydCMtJfUfEHENcCdXQ5rygLhwDcrJRCEzx6MArPITDM2Tl11QqjTq7jspIXpIn5N++zxZoXM4nCl18WB5NqbD+/8vJGHxjVq6gWpI7cOkCtc+CZL95o7rJIyjt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314207; c=relaxed/simple;
	bh=jsU4y+K6YseHQje4CBTJWta00/M0LzB4LyLhMKbDINs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GStb3iyRwNXIYLRKGoPQ4w0vs3g4Wxfa7TZbU5hBbN3oPmkEbCelK2lohoYn7A0KfsHuK078IwdSiiMYz/axGZOAzuG+iQC0pgNScbNdhtwoXahNvoRbRHbZINSUMM/fejW/5yJZD06vGenAZju4z6suQ3xL/nvGU8UehGCN7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy8CmhcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy8CmhcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD5EC4CEEB;
	Sat, 16 Aug 2025 03:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314206;
	bh=jsU4y+K6YseHQje4CBTJWta00/M0LzB4LyLhMKbDINs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uy8CmhcFSXyx3QAB857vOZXoFBouNA9pbk+Xn6H2ZEUqRwVHizxbwwjjF+lD92udq
	 ei+U7j7bKBBcWGE49Fm9PZYmH8EXdG6cFaEGtl0PVzNFzXMzXw4CkytYLhwFM8CBC6
	 57krvPb9KwGDsZDFgj5EExIPVspZV42MqOMwHnxK95+uZzrmHDUXdt0uJvOApgFcrq
	 Y5d37eda8mMSKNbQMgIAuDpBhiSNhm2Nsy1rF+hZLdzrJlv8nJHBZX9LSz+9TDGbfa
	 zfzJWB75eNAjzBq0BosnlrNXe3mSZbJEUNoNZP3k0dresZXP9d118pRkDANvmse1QU
	 S8rApCr/bP8/Q==
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
Subject: [PATCH v5 03/12] perf annotate: Remove __annotation_line__write()
Date: Fri, 15 Aug 2025 20:16:26 -0700
Message-ID: <20250816031635.25318-4-namhyung@kernel.org>
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

Get rid of the internal function and convert function arguments into
local variables if they are used more than once.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 46 ++++++++++++++++----------------------
 tools/perf/util/annotate.h |  2 +-
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b699e14102b0587a..7929f108e35b4e65 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1933,24 +1933,26 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
 	return -ENOMEM;
 }
 
-static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
-				     bool first_line, bool current_entry, bool change_color, int width,
-				     void *obj, unsigned int percent_type,
-				     int  (*obj__set_color)(void *obj, int color),
-				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
-				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
-				     void (*obj__printf)(void *obj, const char *fmt, ...),
-				     void (*obj__write_graph)(void *obj, int graph))
-
-{
-	double percent_max = annotation_line__max_percent(al, percent_type);
-	int pcnt_width = annotation__pcnt_width(notes),
-	    cycles_width = annotation__cycles_width(notes);
+void annotation_line__write(struct annotation_line *al, struct annotation *notes,
+			    const struct annotation_write_ops *wops)
+{
+	bool current_entry = wops->current_entry;
+	bool change_color = wops->change_color;
+	double percent_max = annotation_line__max_percent(al, annotate_opts.percent_type);
+	int width = wops->width;
+	int pcnt_width = annotation__pcnt_width(notes);
+	int cycles_width = annotation__cycles_width(notes);
 	bool show_title = false;
 	char bf[256];
 	int printed;
-
-	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
+	void *obj = wops->obj;
+	int  (*obj__set_color)(void *obj, int color) = wops->set_color;
+	void (*obj__set_percent_color)(void *obj, double percent, bool current) = wops->set_percent_color;
+	int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current) = wops->set_jumps_percent_color;
+	void (*obj__printf)(void *obj, const char *fmt, ...) = wops->printf;
+	void (*obj__write_graph)(void *obj, int graph) = wops->write_graph;
+
+	if (wops->first_line && (al->offset == -1 || percent_max == 0.0)) {
 		if (notes->branch && al->cycles) {
 			if (al->cycles->ipc == 0.0 && al->cycles->avg == 0)
 				show_title = true;
@@ -1964,7 +1966,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		for (i = 0; i < al->data_nr; i++) {
 			double percent;
 
-			percent = annotation_data__percent(&al->data[i], percent_type);
+			percent = annotation_data__percent(&al->data[i],
+							   annotate_opts.percent_type);
 
 			obj__set_percent_color(obj, percent, current_entry);
 			if (symbol_conf.show_total_period) {
@@ -2113,17 +2116,6 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 
 }
 
-void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *wops)
-{
-	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
-				 wops->change_color, wops->width, wops->obj,
-				 annotate_opts.percent_type,
-				 wops->set_color, wops->set_percent_color,
-				 wops->set_jumps_percent_color, wops->printf,
-				 wops->write_graph);
-}
-
 int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 		      struct arch **parch)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0f640e4871744262..2e28a24fa13a736a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -200,7 +200,7 @@ struct annotation_write_ops {
 };
 
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    struct annotation_write_ops *ops);
+			    const struct annotation_write_ops *ops);
 
 int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   char *bf, size_t size,
-- 
2.50.1

