Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378F280A4B;
	Wed, 16 Jul 2025 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642064; cv=none; b=uVgtGk0PcZmnxmumpjctl0a52kG5XO4i1P9zCka53oPtlr7u5VPlJyzDK73Tn+Rw6c2A4Q1jq1279OSF/PyitEhyKvzybV8SE5geOOeE1fZlviJrE8RP0r4ef65v/n2+D53lh8oTyN1WtfaQux99shDV2ReZYjxHO4QjjAk03M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642064; c=relaxed/simple;
	bh=G7ckb2oLlR8G4qHRuOuRttm8Gp1V+3JeIGF9XMTxCiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCpa9OPnMUEp/XLHuppDul9AgKfhmI9BKYP2LQDn2cRtFs/2L7s6tXpqBY9dNTYC/N0rALbI3N+2YvIhke+yF+dJh50jdd73nai5lF3ca2SHHSOYHxt/9MYuPBjou6QL+LIJVHuejKq6sACPgFKFgTBMOlj15C/SCBEHNRSGAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0sq7zBZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0sq7zBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA40FC4CEF0;
	Wed, 16 Jul 2025 05:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752642064;
	bh=G7ckb2oLlR8G4qHRuOuRttm8Gp1V+3JeIGF9XMTxCiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0sq7zBZfrDv6Rh7wwr3sVeyO9ht3OoVtWChhfe5Df+cZi4HM/d8FZizAl3KL6VFA
	 lBXMetQFv/bPNgns7Z22UxI+EDeXq4ZeQvyDL1cpFDIPe6vU0b/7NQkr6mB2GFEdwj
	 96NGfxeCDsZgZNQMh43fYFlbeMvCdxxzxO7cfI0mKrM0hU7Psm1Il+UdLo3XWaOQJ/
	 Una8Ss+XBPdCaao7GDEyiTeSLXTh6axdRRnz3yT46EihSDtoYVrQeVq0n03QaiZk4T
	 Zp/A0iRh1Roo7B+q+c/syJqgd176urB6CZjx2PNO8U7yoz9odLN7Ax2Lm5tEHUAFVF
	 fUVkb/7FNOurg==
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
Subject: [PATCH v3 7/8] perf annotate: Show warning when debuginfo is not available
Date: Tue, 15 Jul 2025 22:00:53 -0700
Message-ID: <20250716050054.14130-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716050054.14130-1-namhyung@kernel.org>
References: <20250716050054.14130-1-namhyung@kernel.org>
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
2.50.0

