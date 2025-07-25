Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD125A352;
	Fri, 25 Jul 2025 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472285; cv=none; b=LznUPSocr/aiuR9DzGrEhnJtNJKa2YjtmBhX86lNjq7aD9j1WvRYTCPwdaEQ18bpqaTMnQEcZeCICi8yXWVVzYoXQBS2lj8HISTYuklim1B7OD+nC8mJdE7Jet1XydYlgUPynwtmmHHauRPNZTjP7MqfdpIVrxcNfbwxU/9asYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472285; c=relaxed/simple;
	bh=rMP4NwEbgs09Yo6duPN7LsyJrXjr4LcRueUhN1EP6L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkqoAeItPuv4/ax3WD/uYqvuFFB3AbHR5sp3wASOLLm7nKSUucpXUS/Mjwql0wZag18Q1OEY5lULlszFdIIetDHgBUzG25k1KI+qMf5SUPNUhC8o23XlqGRlaJ8riEhR7EVxxa/wShiXh3C7yQBrHa3Kq125jIpj8d7O47wFR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsvrNXeH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsvrNXeH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67A3C4CEF8;
	Fri, 25 Jul 2025 19:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472285;
	bh=rMP4NwEbgs09Yo6duPN7LsyJrXjr4LcRueUhN1EP6L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QsvrNXeHY26NDoQp4A8mJfP6ig1bOkYAim2QVT1IgQFGTSyVLAriZOB+pciHdsJQ9
	 O5KQTIUyQBqUdIAs2++p2tTD4Pc9wOpkOt4jceJEaE7sWwgzSh3s7+UkVMw/Y2ec3y
	 aRSRynFmRF+msMUGb+nhad7o2qe7p8oonR9nPunL2CWim9TvPsGZBHJSp4fIf3vpoD
	 TjZI9lwCTegEwlWnJk0v+5fjpi1LcGqGOwi8X5KgQp66f7ZwkFP6HtcMVks1D9P2d6
	 BPMi60mJHyM5uAIGPVheowQGjLHGl9ITaGExAD1Vy/azcg/pxAAUQfJsGry4EBiRfp
	 U4ZyrbxJsaQqg==
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
Subject: [PATCH v4 7/9] perf annotate: Show warning when debuginfo is not available
Date: Fri, 25 Jul 2025 12:37:53 -0700
Message-ID: <20250725193755.12276-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725193755.12276-1-namhyung@kernel.org>
References: <20250725193755.12276-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user requests data-type annotation but no DWARF info is available,
show a warning message about it.

  Warning:
  DWARF debuginfo not found.

  Data-type in this DSO will not be displayed.
  Please make sure to have debug information.

  Press any key...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 17 +++++++++++++++++
 tools/perf/util/dso.h             | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 4b059e0bafd33fcf..2a4db5bdcdb7e9d8 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -804,6 +804,20 @@ static int annotate__scnprintf_title(struct hists *hists, char *bf, size_t size)
 	return printed;
 }
 
+static void annotate_browser__debuginfo_warning(struct annotate_browser *browser)
+{
+	struct map_symbol *ms = browser->b.priv;
+	struct dso *dso = map__dso(ms->map);
+
+	if (browser->dbg == NULL && annotate_opts.code_with_type &&
+	    !dso__debuginfo_warned(dso)) {
+		ui__warning("DWARF debuginfo not found.\n\n"
+			    "Data-type in this DSO will not be displayed.\n"
+			    "Please make sure to have debug information.");
+		dso__set_debuginfo_warned(dso);
+	}
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -834,6 +848,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 
 	annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false);
 
+	annotate_browser__debuginfo_warning(browser);
+
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
 
@@ -1028,6 +1044,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			if (browser->dbg == NULL)
 				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
 			annotate_browser__show(&browser->b, title, help);
+			annotate_browser__debuginfo_warning(browser);
 			continue;
 		case K_LEFT:
 		case '<':
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3457d713d3c56df6..7df1673f08d3ddb4 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -299,6 +299,7 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 hit:1;
 	u8		 annotate_warned:1;
 	u8		 auxtrace_warned:1;
+	u8		 debuginfo_warned:1;
 	u8		 short_name_allocated:1;
 	u8		 long_name_allocated:1;
 	u8		 is_64_bit:1;
@@ -362,6 +363,16 @@ static inline void dso__set_annotate_warned(struct dso *dso)
 	RC_CHK_ACCESS(dso)->annotate_warned = 1;
 }
 
+static inline bool dso__debuginfo_warned(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->debuginfo_warned;
+}
+
+static inline void dso__set_debuginfo_warned(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->debuginfo_warned = 1;
+}
+
 static inline bool dso__auxtrace_warned(const struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->auxtrace_warned;
-- 
2.50.1

