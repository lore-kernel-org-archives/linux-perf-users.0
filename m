Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00D5237A2;
	Wed, 30 Sep 2026 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804254; cv=none; b=l6+fiMqTdSmQMxnwKAH0v2aAc3Ch75kU/P5LThSJ2WLnyqYdrTYL3EdlSFkZA0TAa+bnsk+RC86Nell6lWE+5vbLFp2zWoxw5ROWMLOeKMEKHbB1Z5KyQoCysUtdXtLumltnTCh/gE00SF4fnXdE4Xsri1mehILL1E8Fm4WzsPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804254; c=relaxed/simple;
	bh=0v9mBl5kJsCkZmZH3UgXwQ+GZiMjRRX6dPC+hX6WqsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsJp0lJTeRmV270SK0sxrnP325Dr/Mp9oV1tOHOOiDmH/D8Yq+CdHtcewWqPDxvmw73prSXpvquebJJqUMN6V1EDNkI1z71sZh+5uosrUUvyGwHx4eAUrGvWrMUqO+gYC90bbEIsTCZrRnfyNmPa1hGD9HgldfnN7U9I3Oos/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU6e3sHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU6e3sHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14901F00898;
	Wed, 30 Sep 2026 21:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804252;
	bh=AAOtdfBSFb5Eundj3v/NqYmCUj6ufuEl9hP8B4+sHZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KU6e3sHfmRVH3i5CZePqc9l9AsVku/7vsQP2WuuAuXR3Xc1H0W7VCrLtro2aRzOIN
	 lI1wlE9oO/L41cJMT4CFN5G24BfckjTPP0hyck5zqzzZ6UBVIn8sSQ4TTvCsAzjlXM
	 uOUV/egNn6sAT1Tpf31eRiKSqps2aGorEHoIiPmnE/UTnzhD7l5ZobTkkj1w5TdGge
	 fwgjvh5UUp84hOlbMP72x/8pLSaZzl/r+CQlxbXiAiHOamY1IoOk+kpGhedMvSk+tF
	 GZ+4FtKmnHqs1pULbDsXHEH99ajmkWFmMnFPomYLoD3D6dHu3Z+vjbi4pJZKCG/HQP
	 y06dap229Na/Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v6 3/5] perf report: Add --no-progress option
Date: Wed, 30 Sep 2026 23:37:14 +0200
Message-ID: <20260930213716.2633750-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930213716.2633750-1-acme@kernel.org>
References: <20260930213716.2633750-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that --progress is being added for the stdio case, wire up its
counterpart for the browsers: the TUI and GTK ones present progress of
their own and there is no way to turn it off.  Install the no-op
ui_progress ops, the ones already used until a backend sets theirs,
after setup_browser() installed the ones of the browser in use.  The
phases are still counted, nothing is shown for them, and no second
option is needed for it: parse-options provides --no-progress as the
negation of --progress, report.progress_set saying that it was asked
for, report.progress being false both when nothing was asked for and
when --no-progress was.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  5 +++++
 tools/perf/builtin-report.c              | 20 ++++++++++++++++----
 tools/perf/ui/progress.c                 |  6 ++++++
 tools/perf/ui/progress.h                 |  2 ++
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index a7429a30ec28f903..e145124d6c9a1097 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -43,6 +43,11 @@ OPTIONS
 	present progress information, or when --quiet is used, that asks
 	for no messages at all.
 
+--no-progress::
+	Do not show progress while processing the perf.data file.  It
+	also turns off the progress the TUI and GTK browsers present,
+	which is their own.
+
 -n::
 --show-nr-samples::
 	Show the number of samples for each symbol
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 963808b561e547c3..105b2859678673ec 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -88,6 +88,7 @@ struct report {
 #endif
 	bool			use_stdio;
 	bool			progress;
+	bool			progress_set;
 	bool			show_full_info;
 	bool			show_threads;
 	bool			inverted_callchain;
@@ -1385,8 +1386,15 @@ int cmd_report(int argc, const char **argv)
 		    "Use the stdio interface"),
 	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
 			"Show or hide weight columns in annotation. Default show if non-zero."),
-	OPT_BOOLEAN(0, "progress", &report.progress,
-		    "Show progress while processing the perf.data file"),
+	/*
+	 * No --no-progress option to add: parse-options provides it as
+	 * the negation of this one, clearing report.progress, which is
+	 * also how it starts out.  progress_set is what tells the hook
+	 * below to stop the TUI and GTK browsers as well, they show
+	 * progress until asked not to.
+	 */
+	OPT_BOOLEAN_SET(0, "progress", &report.progress, &report.progress_set,
+			"Show progress while processing the perf.data file"),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
@@ -1796,9 +1804,13 @@ int cmd_report(int argc, const char **argv)
 	/*
 	 * For the stdio case: print the percentage of the perf.data file
 	 * processed so far for each processing phase.  --quiet asks for no
-	 * messages at all, so it leaves the phases uncounted.
+	 * messages at all, so it leaves the phases uncounted, and
+	 * --no-progress, progress_set with progress cleared, turns off what
+	 * the TUI and GTK browsers show as well.
 	 */
-	if (report.progress && !quiet && use_browser == 0)
+	if (report.progress_set && !report.progress)
+		ui_progress__noop_init();
+	else if (report.progress && !quiet && use_browser == 0)
 		stdio_progress__init();
 
 	if (report.data_type && use_browser == 1) {
diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
index 99d60223c74b2957..362680989ace606a 100644
--- a/tools/perf/ui/progress.c
+++ b/tools/perf/ui/progress.c
@@ -13,6 +13,12 @@ static struct ui_progress_ops null_progress__ops =
 
 struct ui_progress_ops *ui_progress__ops = &null_progress__ops;
 
+/* Everything counts but nothing is shown, the way it starts out. */
+void ui_progress__noop_init(void)
+{
+	ui_progress__ops = &null_progress__ops;
+}
+
 void ui_progress__update(struct ui_progress *p, u64 adv)
 {
 	u64 last = p->curr;
diff --git a/tools/perf/ui/progress.h b/tools/perf/ui/progress.h
index 03f1a8bb260ba076..e8c4f9f768aaf12b 100644
--- a/tools/perf/ui/progress.h
+++ b/tools/perf/ui/progress.h
@@ -25,6 +25,8 @@ void ui_progress__update(struct ui_progress *p, u64 adv);
 
 void stdio_progress__init(void);
 
+void ui_progress__noop_init(void);
+
 struct ui_progress_ops {
 	void (*init)(struct ui_progress *p);
 	void (*update)(struct ui_progress *p);
-- 
2.55.0

