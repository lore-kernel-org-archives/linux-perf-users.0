Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4F10E3;
	Thu, 16 Oct 2025 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760583148; cv=none; b=kDCaom5hyvCKh6F0ogrzbmQOdmXHvJiodZPYCTNOPNCwmNsMFJ39+XpggVjNtey2TtZCh2Obm6qvXd8uf+hrsUNJmwObg2cG5XQod4S6e5H0XWJKvEV3yuLokNAhlm1giCfd0kLjDlwhMF1xp+aEmAQY9IIDQLwzyroECVzOb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760583148; c=relaxed/simple;
	bh=gL9/JJOqDZox0KhkXGA9Y0Yl9yLi9pSxD507wytw9BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC+y8AKWcKcrgvGqGl+kEcLVwMMkETQ4q0PgVwspurY1sTE3YJiQjLj2/mPDL2kMOcS5OQoshHZi8o+5BzRzNXjJJWZFu6pJxPuyVgg820LhizNWzhWff2f/5P0E5E00wvPv1+G5rflv7s/mQTGZTaNYVLn0iRGFYWhotMZblLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwwezu/k; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwwezu/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760583147; x=1792119147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gL9/JJOqDZox0KhkXGA9Y0Yl9yLi9pSxD507wytw9BY=;
  b=jwwezu/kTvSEO49hVV3hYUD02ak6fCqv0d1Pbdm3xriswp1/nbskz7wa
   y6ttpgyLA28hoBoaBamrntxk+1cR/Sz8KjasT3tahotHce40KJQ3+OBSA
   FuF3umi8W3/zriJ2KyNCzLMQbgAfIK+dY6nT7YWhrEqXqeAy9VWgIL2CK
   vlS2qmkBY1FPbMpGIVcTPTI9y84x79QoUrH01/csr7R4SEUoUGzVKXwGL
   mSQ6kJspc92DQ/y+ZaGkZFnvcd9ZcKl+2embdJv9yvezUJ4TQa2hfDfI2
   kN4rucFoWkbAFRS/QtDG9C0TnBCB/6TZSTjK1y8ee6zaGrsdipcn0Xxo8
   w==;
X-CSE-ConnectionGUID: /l+r95vKQAivqJ64Ozd6rg==
X-CSE-MsgGUID: dw9AhpjJSJaFySa43oMvKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62861878"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="62861878"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 19:52:26 -0700
X-CSE-ConnectionGUID: i+jFWYO0TSKeFYjRS5abSA==
X-CSE-MsgGUID: 1B3/AS8AQ+CtJxHA27tyPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="186738131"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa005.fm.intel.com with ESMTP; 15 Oct 2025 19:52:21 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	jiebin.sun@intel.com,
	thomas.falcon@intel.com,
	dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf tools annotate: fix a crash when annotate the same symbol with 's' and 'T'
Date: Thu, 16 Oct 2025 11:45:50 +0800
Message-ID: <20251016034550.2124940-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
References: <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf report with annotation for a symbol, press 's' and 'T', then exit
the annotate browser. Once annotate the same symbol, the annotate browser
will crash.

The browser.arch was required to be correctly updated when data type
feature was enabled by 'T'. Usually it was initialized by symbol__annotate2
function. If a symbol has already been correctly annotated at the first
time, it should not call the symbol__annotate2 function again, thus the
browser.arch will not get initialized. Then at the second time to show the
annotate browser, the data type needs to be displayed but the browser.arch
is empty.

Stack trace as below:

Perf: Segmentation fault
-------- backtrace --------
    #0 0x55d365 in ui__signal_backtrace setup.c:0
    #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
    #2 0x570f08 in arch__is perf[570f08]
    #3 0x562186 in annotate_get_insn_location perf[562186]
    #4 0x562626 in __hist_entry__get_data_type annotate.c:0
    #5 0x56476d in annotation_line__write perf[56476d]
    #6 0x54e2db in annotate_browser__write annotate.c:0
    #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
    #8 0x54dc9e in annotate_browser__refresh annotate.c:0
    #9 0x54c03d in __ui_browser__refresh browser.c:0
    #10 0x54ccf8 in ui_browser__run perf[54ccf8]
    #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
    #12 0x552293 in do_annotate hists.c:0
    #13 0x55941c in evsel__hists_browse hists.c:0
    #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
    #15 0x42ff02 in cmd_report perf[42ff02]
    #16 0x494008 in run_builtin perf.c:0
    #17 0x494305 in handle_internal_command perf.c:0
    #18 0x410547 in main perf[410547]
    #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
    #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 libc.so.6[29680]
    #21 0x410b75 in _start perf[410b75]

Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data type display")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Tianyou Li <tianyou.li@intel.com>
---
 tools/perf/ui/browsers/annotate.c | 23 +++++++++++++++++++----
 tools/perf/util/annotate.c        |  2 +-
 tools/perf/util/annotate.h        |  2 ++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8fe699f98542..ac85df1020a1 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -852,6 +852,18 @@ static void annotate_browser__debuginfo_warning(struct annotate_browser *browser
 	}
 }
 
+static void annotate_browser__symbol_annotate_error(struct annotate_browser *browser, int err)
+{
+	struct map_symbol *ms = browser->b.priv;
+	struct symbol *sym = ms->sym;
+	struct dso *dso = map__dso(ms->map);
+	char msg[BUFSIZ];
+
+	dso__set_annotate_warned(dso);
+	symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
+	ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -1149,10 +1161,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	if (not_annotated || !sym->annotate2) {
 		err = symbol__annotate2(ms, evsel, &browser.arch);
 		if (err) {
-			char msg[BUFSIZ];
-			dso__set_annotate_warned(dso);
-			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
-			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
+			annotate_browser__symbol_annotate_error(&browser, err);
 			return -1;
 		}
 
@@ -1161,6 +1170,12 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			if (!annotation__has_source(notes))
 				ui__warning("Annotation has no source code.");
 		}
+	} else {
+		err = evsel__get_arch(evsel, &browser.arch);
+		if (err) {
+			annotate_browser__symbol_annotate_error(&browser, err);
+			return -1;
+		}
 	}
 
 	/* Copy necessary information when it's called from perf top */
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a2e34f149a07..39d6594850f1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
+int evsel__get_arch(struct evsel *evsel, struct arch **parch)
 {
 	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index eaf6c8aa7f47..d4990bff29a7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
 int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
 			     int num_aggr, struct evsel *evsel);
 int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
+
+int evsel__get_arch(struct evsel *evsel, struct arch **parch);
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.47.1

