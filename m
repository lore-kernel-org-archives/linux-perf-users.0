Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616071DC9B5;
	Sun, 28 Sep 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759046936; cv=none; b=dD2f5WjBU0R8J67wnXpAfx9bnDzb00smnVqBCGsjHaS+XUu4BCtCAHDNj6ngiiKRM2dRd8f7AlicRAQM6LdzrFwkXlH6rcJ2SV6v/Q4NDvs/6egxY6piCoDrIsszWnb220FD05+TEtXBAKCkMw7JvboJlPrHDSuXLSVIbNLrsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759046936; c=relaxed/simple;
	bh=Ys+JEo10QXih/yF1ss/jH4GbN72VvNwHlQwJOwMYYvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPyjovMSCd+sg+00ymCSJevrpC3TuuTLGGXhdY+TjIxC6UEoIXB9A6XZDQn5DBYPsw4KASqs4QVhkdkCunLw674Zlx6RujC9uDcsit4eK+BECgXHzlLki5fnoZ1TP5QLLxk+/jyz26KuJxUFLx2k9kSUmnumqTkq7FzQvrwT28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VloEMx81; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VloEMx81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759046934; x=1790582934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ys+JEo10QXih/yF1ss/jH4GbN72VvNwHlQwJOwMYYvo=;
  b=VloEMx81UeBv/x+N5BpKha8ZWvuk0DktpLXvQkUoX+sk9f//+6o+aQlt
   gYBuXG8LjXK+/3i/0iELO6wMSyNsLjpVJI9ajWLf2qS/Ce/6gsvEtRlQI
   OOKSeemcU95YAtSKDpDhRgdJu5CImA7bwshDgTvDRo8NgkHDcJ5ft2JQn
   6apKXPiVEapVeUMWIr8wJEcl1mEDIRGxqpPYBghoZSZom9F4D2xgB5cxM
   MGRRrHcYI9e1/JVt7s+LzNoNapzh5wh0WnnCqUanWNKrM/SNscCDF37/H
   WG8aDQ56K2QDTipM8jwj4oLK/GmsEy6Nja0Nlg//bJn69qZMEFQIfAdBx
   g==;
X-CSE-ConnectionGUID: shPLQuoITbKm+4hakEaaig==
X-CSE-MsgGUID: UJyi+hUyTyyITvzEIoJxsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61278410"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61278410"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 01:08:54 -0700
X-CSE-ConnectionGUID: bhUImA8nTl6IWgtZL3MEBQ==
X-CSE-MsgGUID: SkMTHSktRcuG5xK6QyrkzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="178721020"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by fmviesa010.fm.intel.com with ESMTP; 28 Sep 2025 01:08:49 -0700
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
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	jiebin.sun@intel.com,
	thomas.falcon@intel.com,
	dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf tools c2c: Add annotation support to perf c2c report
Date: Sun, 28 Sep 2025 17:02:12 +0800
Message-ID: <20250928090212.1324797-1-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aMpWcdjoCBsRVo72@z2>
References: <aMpWcdjoCBsRVo72@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perf c2c report currently specified the code address and source:line
information in the cacheline browser, while it is lack of annotation
support like perf report to directly show the disassembly code for
the particular symbol shared that same cacheline. This patches add
a key 'a' binding to the cacheline browser which reuse the annotation
browser to show the disassembly view for easier analysis of cacheline
contentions. By default, the 'TAB' key navigate to the code address
where the contentions detected.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
Reviewed-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/builtin-annotate.c     |   2 +-
 tools/perf/builtin-c2c.c          | 130 ++++++++++++++++++++++++++++--
 tools/perf/ui/browsers/annotate.c |  41 +++++++++-
 tools/perf/ui/browsers/hists.c    |   2 +-
 tools/perf/util/annotate.c        |   2 +-
 tools/perf/util/annotate.h        |   2 +
 tools/perf/util/hist.h            |   6 +-
 7 files changed, 171 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 646f43b0f7c4..f977e97a9c96 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL);
+			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_IP);
 
 			switch (key) {
 			case -1:
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 9e9ff471ddd1..bf2136d062ef 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -45,6 +45,8 @@
 #include "pmus.h"
 #include "string2.h"
 #include "util/util.h"
+#include "util/symbol.h"
+#include "util/annotate.h"
 
 struct c2c_hists {
 	struct hists		hists;
@@ -62,6 +64,7 @@ struct compute_stats {
 
 struct c2c_hist_entry {
 	struct c2c_hists	*hists;
+	struct evsel		*evsel;
 	struct c2c_stats	 stats;
 	unsigned long		*cpuset;
 	unsigned long		*nodeset;
@@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
 	return hists;
 }
 
+static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
+				struct evsel *evsel)
+{
+	c2c_he->evsel = evsel;
+}
+
 static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
 			    struct perf_sample *sample)
 {
@@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	c2c_he__set_cpu(c2c_he, sample);
 	c2c_he__set_node(c2c_he, sample);
+	c2c_he__set_evsel(c2c_he, evsel);
 
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 	ret = hist_entry__append_callchain(he, sample);
@@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 		c2c_he__set_cpu(c2c_he, sample);
 		c2c_he__set_node(c2c_he, sample);
+		c2c_he__set_evsel(c2c_he, evsel);
 
 		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 		ret = hist_entry__append_callchain(he, sample);
@@ -2550,6 +2561,35 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 }
 
 #ifdef HAVE_SLANG_SUPPORT
+
+static int perf_c2c__toggle_annotation(struct hist_browser *browser)
+{
+	struct hist_entry *he = browser->he_selection;
+	struct symbol *sym = NULL;
+	struct c2c_hist_entry *c2c_he = NULL;
+	struct annotated_source *src = NULL;
+
+	if (he == NULL) {
+		ui_browser__help_window(&browser->b, "No entry selected for annotation");
+		return 0;
+	}
+	sym = (&he->ms)->sym;
+
+	if (sym == NULL) {
+		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
+		return 0;
+	}
+
+	src = symbol__hists(sym, 0);
+	if (src == NULL) {
+		ui_browser__help_window(&browser->b, "Failed to initialize annotation source");
+		return 0;
+	}
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, he->ip);
+}
+
 static void c2c_browser__update_nr_entries(struct hist_browser *hb)
 {
 	u64 nr_entries = 0;
@@ -2617,6 +2657,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	" ENTER         Toggle callchains (if present) \n"
 	" n             Toggle Node details info \n"
 	" s             Toggle full length of symbol and source line columns \n"
+	" a             Toggle annotation view \n"
 	" q             Return back to cacheline list \n";
 
 	if (!he)
@@ -2651,6 +2692,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 			c2c.node_info = (c2c.node_info + 1) % 3;
 			setup_nodes_header();
 			break;
+		case 'a':
+			perf_c2c__toggle_annotation(browser);
+			break;
 		case 'q':
 			goto out;
 		case '?':
@@ -2989,6 +3033,11 @@ static int setup_coalesce(const char *coalesce, bool no_source)
 	return 0;
 }
 
+static bool perf_c2c__has_annotation(void)
+{
+	return use_browser == 1;
+}
+
 static int perf_c2c__report(int argc, const char **argv)
 {
 	struct itrace_synth_opts itrace_synth_opts = {
@@ -3006,6 +3055,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	const char *display = NULL;
 	const char *coalesce = NULL;
 	bool no_source = false;
+	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
 	const struct option options[] = {
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
@@ -3033,6 +3083,12 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
 		    "Enable LBR callgraph stitching approach"),
 	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
+	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
+	OPT_STRING(0, "objdump", &objdump_path, "path",
+		   "objdump binary to use for disassembly and annotations"),
+	OPT_STRING(0, "addr2line", &addr2line_path, "path",
+		   "addr2line binary to use for line numbers"),
 	OPT_PARENT(c2c_options),
 	OPT_END()
 	};
@@ -3040,6 +3096,12 @@ static int perf_c2c__report(int argc, const char **argv)
 	const char *output_str, *sort_str = NULL;
 	struct perf_env *env;
 
+	annotation_options__init();
+
+	err = hists__init();
+	if (err < 0)
+		goto out;
+
 	argc = parse_options(argc, argv, options, report_c2c_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (argc)
@@ -3052,6 +3114,36 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (c2c.stats_only)
 		c2c.use_stdio = true;
 
+	/**
+	 * Annotation related options
+	 * disassembler_style, objdump_path, addr2line_path
+	 * are set in the c2c_options, so we can use them here.
+	 */
+	if (disassembler_style) {
+		annotate_opts.disassembler_style = strdup(disassembler_style);
+		if (!annotate_opts.disassembler_style) {
+			err = -ENOMEM;
+			pr_err("Failed to allocate memory for annotation options\n");
+			goto out;
+		}
+	}
+	if (objdump_path) {
+		annotate_opts.objdump_path = strdup(objdump_path);
+		if (!annotate_opts.objdump_path) {
+			err = -ENOMEM;
+			pr_err("Failed to allocate memory for annotation options\n");
+			goto out;
+		}
+	}
+	if (addr2line_path) {
+		symbol_conf.addr2line_path = strdup(addr2line_path);
+		if (!symbol_conf.addr2line_path) {
+			err = -ENOMEM;
+			pr_err("Failed to allocate memory for annotation options\n");
+			goto out;
+		}
+	}
+
 	err = symbol__validate_sym_arguments();
 	if (err)
 		goto out;
@@ -3126,6 +3218,38 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (err)
 		goto out_mem2node;
 
+	if (c2c.use_stdio)
+		use_browser = 0;
+	else
+		use_browser = 1;
+
+	/*
+	 * Only in the TUI browser we are doing integrated annotation,
+	 * so don't allocate extra space that won't be used in the stdio
+	 * implementation.
+	 */
+	if (perf_c2c__has_annotation()) {
+		int ret = symbol__annotation_init();
+
+		if (ret < 0)
+			goto out_mem2node;
+		/*
+		 * For searching by name on the "Browse map details".
+		 * providing it only in verbose mode not to bloat too
+		 * much struct symbol.
+		 */
+		if (verbose > 0) {
+			/*
+			 * XXX: Need to provide a less kludgy way to ask for
+			 * more space per symbol, the u32 is for the index on
+			 * the ui browser.
+			 * See symbol__browser_index.
+			 */
+			symbol_conf.priv_size += sizeof(u32);
+		}
+		annotation_config__init();
+	}
+
 	if (symbol__init(env) < 0)
 		goto out_mem2node;
 
@@ -3135,11 +3259,6 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	if (c2c.use_stdio)
-		use_browser = 0;
-	else
-		use_browser = 1;
-
 	setup_browser(false);
 
 	err = perf_session__process_events(session);
@@ -3210,6 +3329,7 @@ static int perf_c2c__report(int argc, const char **argv)
 out_session:
 	perf_session__delete(session);
 out:
+	annotation_options__exit();
 	return err;
 }
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8fe699f98542..63d0e28fb991 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
-	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
+	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_IP);
 
 	/*
 	 * The annotate_browser above changed the title with the target function
@@ -864,6 +864,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	const char *help = "Press 'h' for help on key bindings";
 	int delay_secs = hbt ? hbt->refresh : 0;
 	char *br_cntr_text = NULL;
+	u64 init_ip = NO_INITIAL_IP;
 	char title[256];
 	int key;
 
@@ -873,6 +874,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
 
 	annotate_browser__calc_percent(browser, evsel);
 
+	/* the selection are intentionally even not from the sample percentage */
+	if (browser->entries.rb_node == NULL && browser->selection) {
+		init_ip = sym->start + browser->selection->offset;
+		disasm_rb_tree__insert(browser, browser->selection);
+		browser->curr_hot = rb_last(&browser->entries);
+	}
+
 	if (browser->curr_hot) {
 		annotate_browser__set_rb_top(browser, browser->curr_hot);
 		browser->b.navkeypressed = false;
@@ -973,6 +981,18 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				ui_helpline__puts(help);
 			annotate__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(browser, title, help);
+			/* Previous RB tree may not valid, need refresh according to new entries*/
+			if (init_ip != NO_INITIAL_IP) {
+				struct disasm_line *dl = find_disasm_line(sym, init_ip, true);
+
+				browser->curr_hot = NULL;
+				browser->entries.rb_node = NULL;
+				if (dl != NULL) {
+					disasm_rb_tree__insert(browser, &dl->al);
+					browser->curr_hot = rb_last(&browser->entries);
+				}
+				nd = browser->curr_hot;
+			}
 			continue;
 		case 'o':
 			annotate_opts.use_offset = !annotate_opts.use_offset;
@@ -1106,22 +1126,23 @@ static int annotate_browser__run(struct annotate_browser *browser,
 }
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt, u64 init_ip)
 {
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
 	SLtty_set_suspend_state(true);
 
-	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
+	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, init_ip);
 }
 
 int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct evsel *evsel,
-			       struct hist_browser_timer *hbt)
+			       struct hist_browser_timer *hbt, u64 init_ip)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
+	struct disasm_line *dl = NULL;
 	struct annotate_browser browser = {
 		.b = {
 			.refresh = annotate_browser__refresh,
@@ -1173,6 +1194,18 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 		browser.he = &annotate_he;
 	}
 
+	/*
+	 * If init_ip is set, it means that there should be a line
+	 * intentionally selected, not based on the percentages
+	 * which caculated by the event sampling. In this case, we
+	 * convey this information into the browser selection, where
+	 * the selection in other cases should be empty.
+	 */
+	if (init_ip != NO_INITIAL_IP) {
+		dl = find_disasm_line(sym, init_ip, false);
+		browser.selection = &dl->al;
+	}
+
 	ui_helpline__push("Press ESC to exit");
 
 	if (annotate_opts.code_with_type) {
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 487c0b08c003..3675a703de11 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 		evsel = hists_to_evsel(browser->hists);
 
 	he = hist_browser__selected_entry(browser);
-	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
+	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_INITIAL_IP);
 	/*
 	 * offer option to annotate the other branch source or target
 	 * (if they exists) when returning from annotate
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c9b220d9f924..937effbeda69 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2622,7 +2622,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 	return 0;
 }
 
-static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
+struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
 					    bool allow_update)
 {
 	struct disasm_line *dl;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index eaf6c8aa7f47..bbe67588bbdd 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -170,6 +170,8 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
 	return al ? container_of(al, struct disasm_line, al) : NULL;
 }
 
+struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip, bool allow_update);
+
 /*
  * Is this offset in the same function as the line it is used?
  * asm functions jump to other functions, for instance.
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c64005278687..e544e1795f19 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -713,12 +713,14 @@ struct block_hist {
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
 
+#define NO_INITIAL_IP 0
+
 int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct evsel *evsel,
-			       struct hist_browser_timer *hbt);
+			       struct hist_browser_timer *hbt, u64 init_ip);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt, u64 init_ip);
 
 int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
 			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
-- 
2.47.1

