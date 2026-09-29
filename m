Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7253D9556;
	Tue, 29 Sep 2026 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712945; cv=none; b=XEVj+K0CM1nxaggDi/vpMVSzVVkcykSPF9GgGr3J90qm1k0IdcRIxcFpbe5g4wLsSGpWCLChsKOiO9oT/rh7LfG6slsfP+u29hmMAK1A3lJDqLw1GRlq1Tyw65mfyrDafY+KH6h/pMIs1KK7pO/NEPYfU4H6rHFXhOi2b/D+siA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712945; c=relaxed/simple;
	bh=fXYsiW0xtl7/Ak7mxVBzZLFr/lNCLxLGUT4fm8UEcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8LcvSqJfkiaZ4MRGDKHgPvR3CPaNGyojFeYT4Ekhtm0v7sqhUMeCVyxtZlurCsD6s1ZLYl3UXTCpK1e/VxB5T9szpYkWtYW8YmrdMfe38GDlqIjrYFdM09zgejpQwG9vz2d1memf9bN+i70iAbTG6S2k/vfvgfccEJSITrNd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLhz7oGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLhz7oGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E240A1F00893;
	Tue, 29 Sep 2026 20:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790712944;
	bh=ZZuP1QE3CHfPWrSeNzPS7ypu4PYI18HRb9wHHmShAqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WLhz7oGynyDE8sH8u6fdw6FkqSW7weakmECok2Sh97MoZfFDfKa/NhbL4W0p6SYWg
	 yoiFWVXWPdZ5NJfRBqRcouXmyzEDTFe0KQne7FZUOkF2BSFFJ+Rp8SiT5jzKGM95H+
	 QS9UH63+5GW9qoVWiV3u4r7WmokO1BXVneMk84RAq5azkE79t9mTubLA+agoE+nwYc
	 yCKpl/TvC0kH3taLT6vCU9m7RxYkReQIxLzqqflfwTZQmBrbjjVI9snFX+7AJ6LkIg
	 MykJN6U+V6I4ddYjlrIWf3FB5K/l/gKpVTVGSaKZpmHIJ93J3gLbSa4DhBuRdOXXS5
	 wUU2ZVX/WZ+jg==
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
Subject: [PATCH 3/5] perf report: Add --no-progress option
Date: Tue, 29 Sep 2026 22:15:22 +0200
Message-ID: <20260929201524.2507733-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929201524.2507733-1-acme@kernel.org>
References: <20260929201524.2507733-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add the counterpart of --progress: the TUI and GTK browsers present
progress of their own and there is no way to turn it off, while the
option just added allows asking for it when there is none.  Install the
no-op ui_progress ops, the ones already used until a backend sets
theirs, after setup_browser() installed them.  The phases are still
counted, nothing is shown for them, and --no-progress takes precedence
over --progress.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 5 +++++
 tools/perf/builtin-report.c              | 7 ++++++-
 tools/perf/ui/progress.c                 | 6 ++++++
 tools/perf/ui/progress.h                 | 2 ++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index a7429a30ec28f903..bc0f2031b100f425 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -43,6 +43,11 @@ OPTIONS
 	present progress information, or when --quiet is used, that asks
 	for no messages at all.
 
+--no-progress::
+	Do not show progress while processing the perf.data file.  It
+	also turns off the progress the TUI and GTK browsers present,
+	which is their own, and takes precedence over --progress.
+
 -n::
 --show-nr-samples::
 	Show the number of samples for each symbol
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 963808b561e547c3..e334556af62f9ef8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -88,6 +88,7 @@ struct report {
 #endif
 	bool			use_stdio;
 	bool			progress;
+	bool			no_progress;
 	bool			show_full_info;
 	bool			show_threads;
 	bool			inverted_callchain;
@@ -1387,6 +1388,8 @@ int cmd_report(int argc, const char **argv)
 			"Show or hide weight columns in annotation. Default show if non-zero."),
 	OPT_BOOLEAN(0, "progress", &report.progress,
 		    "Show progress while processing the perf.data file"),
+	OPT_BOOLEAN(0, "no-progress", &report.no_progress,
+		    "Do not show progress while processing the perf.data file"),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
@@ -1798,7 +1801,9 @@ int cmd_report(int argc, const char **argv)
 	 * processed so far for each processing phase.  --quiet asks for no
 	 * messages at all, so it leaves the phases uncounted.
 	 */
-	if (report.progress && !quiet && use_browser == 0)
+	if (report.no_progress)
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

