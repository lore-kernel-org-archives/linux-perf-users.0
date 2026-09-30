Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92B493D38;
	Wed, 30 Sep 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767523; cv=none; b=U/FPtOAvh2vYlE/w+n+VTF/sv2OsG8jAmtS33vII54IseSvXs7QS1dFkLpDkVhY9ne6YNZ5Q9ksDZbMoF7NynPYSRDLL5IxMCoTdJeJm5C/ikRxnkfe0BVwOqiRGOzF3wb9CQGhiJXJvwm0cInYeoN2U8/0vkIMrtvj6h6Pjd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767523; c=relaxed/simple;
	bh=LxlmtgTFVXuw0rr15Khf8XB1D3t5ws21Cfl/13w0WAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jx5hdYUYqBTJl7INsbkcYE1DMBkE96Exx34/cfZRuSNp6AWAGFPDEgSZ3EJILVm6oLcMZLK6Go5QtMiq0QpP+5LGYfoX0PK3eVlFnbJYC9O1cfFhKvDtHe2IrsEZdhiMbOMOmiEDg8EeGmFwbYyTvhd1jSNmnvL8ZAO76x2mg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+1Xo/hD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+1Xo/hD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEBF1F00898;
	Wed, 30 Sep 2026 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767515;
	bh=2tyQYgnE8V0iJjZiCakAOfzbzjdZGqw5QL1oshTPciE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+1Xo/hDv5dP3MAZrt5Mn3M4ZwrQog5QrR9eoS3RZpme66lTi708Qb/HFRjvCj3ma
	 tMO2Pa78WcLxnY56HBHM9n4iy89SX9NcqqzcTARU7iars7mMNRs6E5rYt4q3S+RacZ
	 9LbLBQj3sGT6Xs0ZQNy82I4XGj7JxULvThuuFdWJ3pFLRKJkyxSrR+WY6YBWSXglZJ
	 k+MKt96BsYsfXsH52pJPNNNlzUIcByqVgEAVfVPnjZq4TABvfFEgeJhkeScM5BVJ74
	 FCcitJhmpmMwehMrYbg5bvc5REQXQuWSZNTivT6cg9z/PxhkGSB07vZ4e0yeqbuSnR
	 tdLiTQn4h/Gvg==
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
Date: Wed, 30 Sep 2026 13:24:52 +0200
Message-ID: <20260930112454.16331-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930112454.16331-1-acme@kernel.org>
References: <20260930112454.16331-1-acme@kernel.org>
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
their own and there is no way to turn it off.

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

