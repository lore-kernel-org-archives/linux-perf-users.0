Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59F26F2B6;
	Mon, 13 Oct 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368672; cv=none; b=b/TrJgK72FzTok/3VCE/ztEhUnPr0bIjfUq4LAhsMhoNq+HprOocjBd6vcG+Dgfhm7PFmTK/lvEBcHxUgmto+GVyuFja2llSFZw7P+7OcWFQmZSydFHy2y23oAGJV3Ww+H20uC3VnMSwVFj9bB5ZWvrDZxiVIb12ucojVYF++GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368672; c=relaxed/simple;
	bh=VhHDC/pzCEJRdbgq2yAH6nFoNigRkEQ2qVYfCVitK70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZbpZS337HrlsqbLf9sQzXZa3I9+Lp3GK6d447VT1VtfdRZaiMxGa/2a9x3FxGbzYACL44Dv8wevdJoAQDl3CvzUyVZBKOec64onV73KoOSWb2fFT0Sz8TDttO9C5iUD5honTk8cHWxukmjUrE9gm9gFDikHhuqNzHxUEsKu1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JU2h/kJz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JU2h/kJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760368671; x=1791904671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VhHDC/pzCEJRdbgq2yAH6nFoNigRkEQ2qVYfCVitK70=;
  b=JU2h/kJzZ1n+g1tSYSnNcBTZnyvJqYCOv+6E+XUIRzeUmznq+z5kxCdi
   DD1sa7isbE2pD+VixSb8S7T2emH9QbcbfngWA9uD2/+N/DG18UoPJ99gf
   oYOZC7i7h1fvKTzT6fZxRm/I5kJSRgP84e6e+xi6sfLfPL9flrTjGlmjB
   BF/Tbmpzc9hCDWy62vIqQO9SxawQ8pa+Ev6FR/ZXlhiByohhXj1Wjmwnb
   njVB0cgtI7qTjNjgHOraeG5mtxQpk5DCslBOsWEh9fdXad82XQlvW1zxB
   lqGj8bLDOMRWJS14cychcwlcJpVEHdEY1H8uMuPsVMRrxnaJsKMMswlX9
   A==;
X-CSE-ConnectionGUID: e4MRE0GnRRe+S8Heh8jsiA==
X-CSE-MsgGUID: ogVJsHF2R/6OMHmHdQG6ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73615021"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="73615021"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 08:17:50 -0700
X-CSE-ConnectionGUID: Q8MLLu7XSYu5+JjPrcfLiw==
X-CSE-MsgGUID: QZzQ3sRBRtmVjSVwjGGwcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="185635616"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by orviesa003.jf.intel.com with ESMTP; 13 Oct 2025 08:17:45 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH] perf tools annotate: fix a crash when annotate the same symbol with 's' and 'T'
Date: Tue, 14 Oct 2025 00:10:46 +0800
Message-ID: <20251013161046.2075335-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf report with annotation for a symbol, press 's' and 'T', then exit
the annotate browser. Once annoate the same symbol, the annoate browser
will crash. Stack trace as below:

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

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
---
 tools/perf/ui/browsers/annotate.c | 3 +++
 tools/perf/util/annotate.c        | 2 +-
 tools/perf/util/annotate.h        | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8fe699f98542..1e0873194217 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1163,6 +1163,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 		}
 	}
 
+	if (browser.arch == NULL)
+		evsel__get_arch(evsel, &browser.arch);
+
 	/* Copy necessary information when it's called from perf top */
 	if (hbt != NULL && he != &annotate_he) {
 		annotate_he.hists = he->hists;
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

