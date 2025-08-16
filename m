Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F21E1E1C;
	Sat, 16 Aug 2025 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314209; cv=none; b=KPc44uXDI9duX001/p94xTGbpfmIQOTACjD1SELE0XWAC4It3WaB2/sQ7GyseaEDgRRG+STkAPwMD4NDvMzCoh3OtfLCwiBEaBqC272dmYBYywNkPYYvAVQXaeqwGMTe2HTrWZgjWPKCQVdYza8IT5unJmVRmvCKT5T14hAKdX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314209; c=relaxed/simple;
	bh=xIE0yPJqoPDcFz62BS6iiEO0J3tG4qsg4AmQSIsboX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Si1n36hGB4u2+h1ouJk32G4+1gEViaKIxRP12ND5X6s2Kmf3N5ggv3JEoh22naM4gTw7FXL6Oy5RsCBBUjQA/j4DZ1OdL9JlayXlHg7f5/SIrvVMyLbxPqllmDMTABi3grrnVvj11xQBj0McmCbA0/4kia3RjbzAsYB0ciLPaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMypgYUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMypgYUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B487C4CEF5;
	Sat, 16 Aug 2025 03:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314209;
	bh=xIE0yPJqoPDcFz62BS6iiEO0J3tG4qsg4AmQSIsboX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMypgYUvgB3KkED9QYjIE7FP8Pk7EpSJEbsOBw/yytgZ3uj5qplgnrqEVGB6wVBDG
	 LnSWR/I9TQ/MfgWjtz1vU5zSgU1I8upCggCv1My6XJgdAKoJKR3TjPPkj98bPjvOFq
	 YGmxB0CgJo6QaRosVDU3Trsmji6NKmVR7pPiKW3bAWBu6nrd8TC2vx2YQdzCoW65pX
	 AMHebDia0UAsAXt7W4Oy4fM6JQ+W41dhQcgiubhSvnEO/E0/hRBZrEpqLXKiI6cN9l
	 9HV4urmdIEukeqN1PaM4hti5betFxHcReIO9Ij5rkp8kjpb3NUejs0u7AP8ifYYH4k
	 H2cm01tgYYQ7w==
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
Subject: [PATCH v5 09/12] perf annotate: Show warning when debuginfo is not available
Date: Fri, 15 Aug 2025 20:16:32 -0700
Message-ID: <20250816031635.25318-10-namhyung@kernel.org>
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
index dfe869c20e35da77..e3e7004f32251666 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -812,6 +812,20 @@ static int annotate__scnprintf_title(struct hists *hists, char *bf, size_t size)
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
@@ -842,6 +856,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 
 	annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false);
 
+	annotate_browser__debuginfo_warning(browser);
+
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
 
@@ -1036,6 +1052,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
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

