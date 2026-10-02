Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C424756DE;
	Fri,  2 Oct 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936554; cv=none; b=bCHYB8Hq88S6sSjv+JfJUSnRoBSSMNfpd0SA/e4x/h2/k6/VbnoWjA6Zxjv18UgCVbuDHtojK5Ht85PSo4rs0tl3HGtYz7PpKTEHyTpGI2GCzfKepOrpONRUxZixEyJl2cUDfE/dOJt5lIIxnEcDWZG23DxhGMaEHukKWVUz/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936554; c=relaxed/simple;
	bh=zwhCpQvZRkS/dleFeouyEhlI36W7NQ0BUkoQL1XIZ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC1ZLZMpbFJQ252OkA1/5Kz3mlVA+CbOlIlGx+VTBkMIgIM8eA7W0Nh1/eCRI4APGXHyR2P5d8w6oHyd1t8DHe8Sem21Xh8dsNKjDxpwcDro4OnWNRcYEbydSVEZfYIoDqC57pA5BTfZNBHqoXvT0dMo2m51a8xlRfbTEXNwXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQOA5sIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQOA5sIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DC81F00893;
	Fri,  2 Oct 2026 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936553;
	bh=+0ejlMCDMADEMtvZgj3suq15YdimAkqZV4RBaR0bKDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MQOA5sIJxwDWn+IJB1q33ZGFn40jiU5jroJR08qhmYkSpfwtE8M9/jPyR3bMXrOBW
	 2VI0bWrX4lTimpgiedp6tpEhKctN+WTCDP95Sw3shqRBefUfF2V6DOHMZ2MLTf8Apt
	 bNP6pI6ld7wtElNdGoems5r95bAxUgpAJrA3qKNNT/IV7Y3dlPu2N2psKqD7uONpXG
	 Lb1uLJaOTi7ThRc3BgFpcA+t7bw2G7AFk76GRn/07z+eop2Pwk/5qe/SK3c1g7ETZK
	 6+3AC9HO6RpbZSsm71Hzu39lKQMsccMw1vvLlsVFHc32nvzTSW7I/4BbDNBy+cF3xL
	 CCKrwpGbzbEBA==
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
Subject: [PATCH v8 7/9] perf report: Add --no-progress option
Date: Fri,  2 Oct 2026 12:21:08 +0200
Message-ID: <20261002102110.27587-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002102110.27587-1-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
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
after setup_browser() installed the ones of the browser in use.

The phases are still counted, nothing is shown for them, and no second
option is needed for it: parse-options provides --no-progress as the
negation of --progress, report.progress_set saying that it was asked
for, report.progress being false both when nothing was asked for and
when --no-progress was.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 5 +++++
 tools/perf/builtin-report.c              | 9 ++++++---
 tools/perf/ui/progress.c                 | 6 ++++++
 tools/perf/ui/progress.h                 | 2 ++
 4 files changed, 19 insertions(+), 3 deletions(-)

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
index 81e13fb8194976c9..29085fdc91e58884 100644
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
@@ -1385,8 +1386,8 @@ int cmd_report(int argc, const char **argv)
 		    "Use the stdio interface"),
 	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
 			"Show or hide weight columns in annotation. Default show if non-zero."),
-	OPT_BOOLEAN(0, "progress", &report.progress,
-		    "Show progress while processing the perf.data file"),
+	OPT_BOOLEAN_SET(0, "progress", &report.progress, &report.progress_set,
+			"Show progress while processing the perf.data file"),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
@@ -1793,7 +1794,9 @@ int cmd_report(int argc, const char **argv)
 	else
 		use_browser = 0;
 
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

