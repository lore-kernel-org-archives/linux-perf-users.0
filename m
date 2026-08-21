Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED53F6C4D;
	Fri, 21 Aug 2026 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291373; cv=none; b=Avdepl0SL2MK3qjwbg1I6bAW7P/8RrK8i/LSv3MYpjWRzwEgli+dcizy+SXbNFKSN19Ay5/bkjQj01a4dpOBpQezV7/mXLeA6Ze3unAVN6tODNQ+I62cscBK7CjYK7qKTjiX7H9NLRcoktHk9Yio8YPbnFiJPMyF1/WRBrXK0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291373; c=relaxed/simple;
	bh=eR8K3cLrav5I2zLr6N7Mw3trLHlhYTtRFUwRknOs4V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKAEdvGQs26kOUh2JNsd+v48zGGJ0f3nWW8Plhje8QMF5/iv5H+xdqN/apG7LHlMlTzWYps5DM4XqVPsOY1/NZKujz7fE0dMAavpvDYjtboW/sIQ8AaGLyYougKVxXbwMHu5i4hlRkBFaDW3TPoW+Ng05GSv9eIOmZVlNrLXk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jf3JP8fZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jf3JP8fZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787291372; x=1818827372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eR8K3cLrav5I2zLr6N7Mw3trLHlhYTtRFUwRknOs4V8=;
  b=Jf3JP8fZgZTclmGPK2HXRwAv2ntGsLc8vXlKTAG6/3YwlCwQr877yEdO
   mknBs+ruS7+ALz2w4kCQlbU5Ctd+CshZsyEQQ1HtRihCxKhrhoSY86qDK
   23ud+Ta3EHXKcMcFepNXp7IpHgk9lc+d1IUt+8qYrvtygvvWZidqPPpn5
   ZN11aQt8VEiGcNoWUpswlPUQsqFym53MHBSmCx5hA0ZrR+ac3FPYKegk/
   KHi9yuT3Hw8x8JOJ4BC8ASnR78PlgS/0nYxXHhG09xbBFn+J2tpvA65ra
   FjXcaJ8R9xTklLN5XqV1j6IGdJ/D/VHih8tl6aL2AZNi5RBsiyWcVEmEd
   A==;
X-CSE-ConnectionGUID: hC6XImPGSGaxIO7NBjiOYw==
X-CSE-MsgGUID: /lDyP47AT4q7DiI0ROXJSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87691973"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87691973"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 22:49:32 -0700
X-CSE-ConnectionGUID: 5Y/0/p6mS+WC5ejXqdX17A==
X-CSE-MsgGUID: m2I0i2lZSBKWP4IfbLb5UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="270476182"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 22:49:26 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	jiebin.sun@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] perf c2c: Add stdio support for the function view
Date: Fri, 21 Aug 2026 13:56:10 +0800
Message-ID: <c53d3eb3a036c250702af363b6e7ce3307aa1571.1787283281.git.jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787283281.git.jiebin.sun@intel.com>
References: <cover.1787283281.git.jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function view is currently TUI-only, so it cannot be used by builds
without SLANG support, when output is piped, or from a script. Add a
--function option that prints the fully expanded three-level hierarchy to
stdout.

Keep the stdio renderer in builtin-c2c.c and reuse the common function-view
model introduced by the merged series. Export only the coalescing-field
capability check from the model, preserving the util/UI boundary and
leaving the TUI object in libperf-ui.a.

Stop padding the final identity column in symbol_view_entry(). The generic
formatter pads non-final columns but deliberately leaves the final column
unpadded, avoiding trailing whitespace in function-view table rows. The TUI
remains unchanged because its browser clears the rest of each rendered row.

--function implies --stdio and is rejected together with --stats. Validate
the iaddr requirement before processing events. Return function-view build
failures from the report command, and preserve TUI browser errors when
converting the display helpers to return a status.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/Documentation/perf-c2c.txt | 12 +++-
 tools/perf/builtin-c2c.c              | 85 ++++++++++++++++++++++++---
 tools/perf/util/c2c-function.c        |  9 +--
 tools/perf/util/c2c.h                 |  1 +
 4 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 9e58a51c55de..7a0cf31be7ed 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -107,6 +107,10 @@ REPORT OPTIONS
 --stats::
 	Display only statistic tables and force stdio mode.
 
+--function::
+	Display the function view and force stdio mode.  This requires `iaddr`
+	in the cacheline coalescing fields and cannot be used with `--stats`.
+
 --full-symbols::
 	Display full length of symbols.
 
@@ -360,6 +364,10 @@ Following tables are displayed:
   Shared Cache Line Distribution Pareto
   - list of all accessed offsets for each cacheline
 
+With `--function`, the cacheline and Pareto tables are replaced by a fully
+expanded Shared Data Functions Table.  Its three levels are the read-side
+function, contending writer, and shared cacheline, as detailed below.
+
 TUI OUTPUT
 ----------
 The TUI output provides interactive interface to navigate
@@ -374,8 +382,8 @@ Verbose mode also includes code addresses in function rows, and code addresses
 remain available in the per-cacheline detail view ('d').
 
 The function view requires `iaddr` in the cacheline coalescing fields.  If
-`--coalesce` omits it, TAB reports that the view is unavailable rather than
-attributing already-coalesced samples to an arbitrary function.
+`--coalesce` omits it, TAB or `--function` reports that the view is unavailable
+rather than attributing already-coalesced samples to an arbitrary function.
 
   Level 1: the read-side function, sorted by Cycles % (estimated load
            cycles: HITM, peer-snoop and other-load cycles)
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 715b75d42f2a..cce76a1e2ff5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -73,6 +73,7 @@ struct perf_c2c {
 	bool			 show_all;
 	bool			 use_stdio;
 	bool			 stats_only;
+	bool			 function_view;
 	bool			 symbol_full;
 	bool			 stitch_lbr;
 
@@ -2530,7 +2531,48 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
 
-static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
+static void c2c_function__unfold_all(struct rb_root_cached *root)
+{
+	struct rb_node *nd;
+
+	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
+
+		if (!he->has_children)
+			continue;
+		he->unfolded = true;
+		c2c_function__unfold_all(&he->hroot_out);
+	}
+}
+
+static int perf_c2c__function_fprintf(FILE *out)
+{
+	bool saved_use_callchain = symbol_conf.use_callchain;
+	struct hists *hists;
+	int ret;
+
+	/* Function-view entries aggregate samples and never display callchains. */
+	symbol_conf.use_callchain = false;
+	ret = c2c_function__build(&c2c.hists, c2c.cl_sort, c2c.symbol_full,
+				  &hists);
+	if (ret) {
+		if (ret == -EOPNOTSUPP)
+			pr_err("The function view requires iaddr in --coalesce.\n");
+		else
+			pr_err("Failed to build function view hierarchy (ret=%d)\n", ret);
+		goto out;
+	}
+
+	/* Match fold signs to hists__fprintf()'s forced child traversal. */
+	c2c_function__unfold_all(&hists->entries);
+	hists__fprintf(hists, true, 0, 0, 0, out, true);
+	c2c_function__reset();
+out:
+	symbol_conf.use_callchain = saved_use_callchain;
+	return ret;
+}
+
+static int perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 {
 	setup_pager();
 
@@ -2541,7 +2583,17 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	print_c2c_info(out, session);
 
 	if (c2c.stats_only)
-		return;
+		return 0;
+
+	if (c2c.function_view) {
+		fprintf(out, "\n");
+		fprintf(out, "=================================================\n");
+		fprintf(out, "           Shared Data Functions Table\n");
+		fprintf(out, "=================================================\n");
+		fprintf(out, "#\n");
+
+		return perf_c2c__function_fprintf(out);
+	}
 
 	fprintf(out, "\n");
 	fprintf(out, "=================================================\n");
@@ -2558,6 +2610,7 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	fprintf(out, "#\n");
 
 	print_pareto(out, perf_session__env(session));
+	return 0;
 }
 
 #ifdef HAVE_SLANG_SUPPORT
@@ -2794,18 +2847,18 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	return 0;
 }
 
-static void perf_c2c_display(struct perf_session *session)
+static int perf_c2c_display(struct perf_session *session)
 {
 	if (use_browser == 0)
-		perf_c2c__hists_fprintf(stdout, session);
-	else
-		perf_c2c__hists_browse(&c2c.hists.hists);
+		return perf_c2c__hists_fprintf(stdout, session);
+
+	return perf_c2c__hists_browse(&c2c.hists.hists);
 }
 #else
-static void perf_c2c_display(struct perf_session *session)
+static int perf_c2c_display(struct perf_session *session)
 {
 	use_browser = 0;
-	perf_c2c__hists_fprintf(stdout, session);
+	return perf_c2c__hists_fprintf(stdout, session);
 }
 #endif /* HAVE_SLANG_SUPPORT */
 
@@ -3081,6 +3134,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "stdio", &c2c.use_stdio, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "stats", &c2c.stats_only,
 		    "Display only statistic tables (implies --stdio)"),
+	OPT_BOOLEAN(0, "function", &c2c.function_view,
+		    "Display the function view (implies --stdio)"),
 	OPT_BOOLEAN(0, "full-symbols", &c2c.symbol_full,
 		    "Display full length of symbols"),
 	OPT_BOOLEAN(0, "no-source", &no_source,
@@ -3119,6 +3174,11 @@ static int perf_c2c__report(int argc, const char **argv)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (argc)
 		usage_with_options(report_c2c_usage, options);
+	if (c2c.stats_only && c2c.function_view) {
+		pr_err("--stats and --function cannot be used together.\n");
+		err = -EINVAL;
+		goto out;
+	}
 
 #ifndef HAVE_SLANG_SUPPORT
 	c2c.use_stdio = true;
@@ -3126,6 +3186,8 @@ static int perf_c2c__report(int argc, const char **argv)
 
 	if (c2c.stats_only)
 		c2c.use_stdio = true;
+	if (c2c.function_view)
+		c2c.use_stdio = true;
 
 	/**
 	 * Annotation related options disassembler_style, objdump_path are set
@@ -3199,6 +3261,11 @@ static int perf_c2c__report(int argc, const char **argv)
 		pr_debug("Failed to initialize hists\n");
 		goto out_session;
 	}
+	if (c2c.function_view && !c2c_function__has_iaddr(c2c.cl_sort)) {
+		pr_err("The function view requires iaddr in --coalesce.\n");
+		err = -EINVAL;
+		goto out_session;
+	}
 
 	err = c2c_hists__init(&c2c.hists, "dcacheline", 2, perf_session__env(session));
 	if (err) {
@@ -3332,7 +3399,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	perf_c2c_display(session);
+	err = perf_c2c_display(session);
 
 out_mem2node:
 	mem2node__exit(&c2c.mem2node);
diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-function.c
index 5b6a06a5a067..d410196d0429 100644
--- a/tools/perf/util/c2c-function.c
+++ b/tools/perf/util/c2c-function.c
@@ -305,8 +305,8 @@ symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		char symbuf[32];
 
 		scnprintf(symbuf, sizeof(symbuf), "0x%" PRIx64, addr);
-		ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%-*.*s",
-				 text_width, text_width, symbuf);
+		ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%.*s",
+				 text_width, symbuf);
 	} else {
 		/* Level 1 and level 2 are both functions. */
 		size_t cell_size;
@@ -331,9 +331,6 @@ symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			len = min_t(size_t, len, cell_size - 1);
 
 		ret += len;
-		if (len < text_width)
-			ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%*s",
-					 text_width - len, "");
 	}
 
 	return ret;
@@ -1519,7 +1516,7 @@ void c2c_function__reset(void)
 	symbol_conf.use_callchain = saved_use_callchain;
 }
 
-static bool c2c_function__has_iaddr(const char *cl_sort)
+bool c2c_function__has_iaddr(const char *cl_sort)
 {
 	const char *field = cl_sort;
 
diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
index 53f024e25d99..198032ec7c87 100644
--- a/tools/perf/util/c2c.h
+++ b/tools/perf/util/c2c.h
@@ -107,6 +107,7 @@ bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
 int c2c_function__build(struct c2c_hists *cl_hists, const char *cl_sort,
 			bool symbol_full, struct hists **hists);
 void c2c_function__reset(void);
+bool c2c_function__has_iaddr(const char *cl_sort);
 /* Valid only between a successful build and c2c_function__reset(). */
 struct hist_entry *c2c_function__find_cacheline(struct hist_entry *he);
 
-- 
2.52.0

