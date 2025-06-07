Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98321D3E2;
	Sat,  7 Jun 2025 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338745; cv=none; b=knWPz3Slk+bYupESmArYl0aniJCclPSyNt/aY1YxZxxmDb9YhYMx4Ovy0juK6Sk2eDhilkxE1NWf910borSdtdt+0m5CzUZXKZUinjzpk37dP42/HHZ2mMRdIdWYcXWmrExXPOzCB/04gfBWMN8xf0V3a/au/f6cU7UP63zbujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338745; c=relaxed/simple;
	bh=v12hSautNxmZv9EkO3eAVCynaibzZFY8FELph7xTy9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faFDIhDQT3QNXPTXpr5lG7MzOKDBtiEoR6tNqbGDifyeBWQVa7HOEJZb/XhRZcuwz+HZRhpr1ZwFt2rtth432wPYIiO9xrKHAGQjJibiaHsqEssyjWfoHnXbjIRhry2G++ZjeC+y+5XdifIMK0PJ0uebZQExGrzl3VsAPuLhSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcDy083C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcDy083C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16AFC4CEF1;
	Sat,  7 Jun 2025 23:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749338745;
	bh=v12hSautNxmZv9EkO3eAVCynaibzZFY8FELph7xTy9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BcDy083C+NB3s5zaH8cVnbsx5ZGWv8dCSuJeKSY3tLbhtVsvXdFIv3vO7Ang6OFLN
	 INurd3qIXevisNBSqeehyMutz4u/2b/wwPVl0MyO+rHWa5/yHLdY0a+Wnl37QFPfy2
	 YIFb1wy7IrrRQ2N1FBmTT42PsneZx85Zh+WOxQiSfQveDE/iH/FdQftC5wCj7sFLah
	 yUUNG5JXf5P4gY3PPNUewyYW6gQA7d82Wcc0ptWZQVcSZlzx//joPc/AC1ST7m/mYH
	 Oy2zgf73REIgBvgrGOZmVkkc+1hQ4wtIYj0lus8ooUXS/IGwELjmY2RDVI3Z/It5yF
	 NPPnXuGo5eS3w==
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
Subject: [PATCH v2 7/7] perf annotate: Show warning when debuginfo is not available
Date: Sat,  7 Jun 2025 16:25:40 -0700
Message-ID: <20250607232540.89488-8-namhyung@kernel.org>
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
index b0b31a121941daec..a690a464105f302c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -730,6 +730,20 @@ static int annotate__scnprintf_title(struct hists *hists, char *bf, size_t size)
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
@@ -760,6 +774,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 
 	annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false);
 
+	annotate_browser__debuginfo_warning(browser);
+
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
 
@@ -954,6 +970,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			if (browser->dbg == NULL)
 				browser->dbg = debuginfo__new(dso__long_name(map__dso(ms->map)));
 			annotate_browser__show(&browser->b, title, help);
+			annotate_browser__debuginfo_warning(browser);
 			continue;
 		case K_LEFT:
 		case '<':
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c87564471f9b01b1..42dadcc85a0e9150 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -282,6 +282,7 @@ DECLARE_RC_STRUCT(dso) {
 	u8		 hit:1;
 	u8		 annotate_warned:1;
 	u8		 auxtrace_warned:1;
+	u8		 debuginfo_warned:1;
 	u8		 short_name_allocated:1;
 	u8		 long_name_allocated:1;
 	u8		 is_64_bit:1;
@@ -342,6 +343,16 @@ static inline void dso__set_annotate_warned(struct dso *dso)
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
2.49.0

