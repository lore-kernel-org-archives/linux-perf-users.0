Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E303F2109;
	Fri, 10 Jul 2026 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672990; cv=none; b=SmLnkKavNpGwO+EYzNxDzKL7tWlTo9GkM88cQCj/G4sCvUw0QCLr8xtghaQZrG7M9rQQhSeocK8dN2y+M1kW/C73VxhWQGlEmvoCieBeyObBbpSZKFsQYtnsxDghjlyUthYJURJRXYkMcLhp8fucmu1iOpZfUiHAwJEfgV7Fnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672990; c=relaxed/simple;
	bh=3i7AS7MawqR/TAzu5pR03szQdZCj3QPyajajiaItl2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY1gU8GtubsUWgMnpWjBI6Pa3WMjIW1izitOIKtFIrOnDjt2d7FvXEQfze1pPBTKFi0T975gVZ4VgvjWDmkf8wh5+2iQj9wQdOjgzcQumMbg0chCcQ08by0kw+lO08GDRMerjnqzYK1oZS6lQCjQwrnS0Dr4j92KvDFof1j+3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1RkmFEw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1RkmFEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672987; x=1815208987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3i7AS7MawqR/TAzu5pR03szQdZCj3QPyajajiaItl2w=;
  b=C1RkmFEwz4rRMHG6BlZ5xMQrh1QA+KjQbUD3Ki3JnXtY4UqWvzSbuQ2/
   oNPMwp3mlQ7YBmW/t8RG/YGzg/hetyZ11UVm0v55mt7JhcYufbW5uUtJP
   G7uF18K0Ted+mT076W17GAIb76x00+Z6zJkTwFlVDa2PDGWWu93jxAcyO
   fr3I7wxY8i/PAzH1eFOh1SfBJDvNTa2DVcJBqvuE6RQeEBy6PilDfkiSg
   SuYqYzNfnPv9qxYanyqpogreJhhegpWaw+NgLADNqbwYF7QtV884VnbtT
   jfFN92/NMan52npLbfKF1OaMW7jpOmNIyxyZJailR+jB/ig2PK5E2QIYF
   A==;
X-CSE-ConnectionGUID: ai07DeWVR328m1vM+siy9g==
X-CSE-MsgGUID: gJpq4TQLTO6x5/BmWR933g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390841"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390841"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:06 -0700
X-CSE-ConnectionGUID: ltcnAZWhTGGVcKeLBeJmWw==
X-CSE-MsgGUID: mJ+hFgtLTz2grPfX18lpZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435374"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:43:02 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>
Subject: [PATCH v2 07/14] perf c2c: add dimension definitions and format creation
Date: Fri, 10 Jul 2026 16:42:40 +0800
Message-ID: <20260710084247.3576706-8-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260710084247.3576706-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function view dimension definitions that bind column names to
their rendering and comparison functions:

- dim_cycles_percent: estimated load-cycles percentage (L1 only)
- dim_total_stores: store count per function
- dim_cacheline_symbol: cacheline address (L3 only)
- dim_iaddr_symbol: instruction code address
- dim_symbol_view: symbol name with fold indicators

Remove __maybe_unused from the entry and comparison functions now that
they are referenced by the dimension structs above.

Also add get_function_dimension() and get_function_format() to look up
dimensions by name and create perf_hpp_fmt wrappers. These two helpers
are intentionally left __maybe_unused here; they are wired into the
function view initialization in the following patch.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/ui/browsers/c2c-function.c | 143 +++++++++++++++++++++++---
 1 file changed, 131 insertions(+), 12 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index d5763af307b6..7c2bb8f9e113 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -66,7 +66,7 @@ static __maybe_unused inline u64 hist_entry__iaddr(struct hist_entry *he)
 	return he->ip;
 }
 
-static __maybe_unused int symbol_width(struct hists *hists, struct sort_entry *se)
+static int symbol_width(struct hists *hists, struct sort_entry *se)
 {
 	int width = hists__col_len(hists, se->se_width_idx);
 
@@ -81,7 +81,7 @@ static struct c2c_dimension dim_symbol_view;
 /*
  * c2c_width - Calculate width for a C2C column in function view
  */
-static __maybe_unused int c2c_width(struct perf_hpp_fmt *fmt,
+static int c2c_width(struct perf_hpp_fmt *fmt,
 		     struct perf_hpp *hpp __maybe_unused,
 		     struct hists *hists)
 {
@@ -98,7 +98,7 @@ static __maybe_unused int c2c_width(struct perf_hpp_fmt *fmt,
 			 dim->width;
 }
 
-static __maybe_unused int c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+static int c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		      struct hists *hists, int line, int *span)
 {
 	struct c2c_fmt *c2c_fmt;
@@ -179,7 +179,7 @@ static __maybe_unused u64 hist_entry__child_stores(struct hist_entry *he)
 	return c2c_he->child_stores;
 }
 
-static __maybe_unused int
+static int
 total_stores_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		   struct hist_entry *he)
 {
@@ -196,7 +196,7 @@ total_stores_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 /*
  * cacheline_symbol_entry - Render cacheline address for function view
  */
-static __maybe_unused int
+static int
 cacheline_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		       struct hist_entry *he)
 {
@@ -215,7 +215,7 @@ cacheline_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 }
 
 /* Render the code (instruction) address for level-1 and level-2 entries. */
-static __maybe_unused int
+static int
 iaddr_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		   struct hist_entry *he)
 {
@@ -246,7 +246,7 @@ iaddr_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 /*
  * symbol_view_entry - Render symbol name for function view with expansion indicators
  */
-static __maybe_unused int
+static int
 symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		  struct hist_entry *he)
 {
@@ -279,7 +279,7 @@ symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 /*
  * cycles_percent_entry - Render cycles percentage column
  */
-static __maybe_unused int
+static int
 cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		     struct hist_entry *he)
 {
@@ -314,7 +314,7 @@ cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 /*
  * cycles_percent_cmp - Comparison function for cycles percentage sorting
  */
-static __maybe_unused int64_t
+static int64_t
 cycles_percent_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 		   struct hist_entry *left, struct hist_entry *right)
 {
@@ -335,7 +335,7 @@ cycles_percent_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 /*
  * iaddr_symbol_cmp - Comparison function for instruction address sorting
  */
-static __maybe_unused int64_t
+static int64_t
 iaddr_symbol_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 		 struct hist_entry *left, struct hist_entry *right)
 {
@@ -358,7 +358,7 @@ iaddr_symbol_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return (left_iaddr < right_iaddr) - (left_iaddr > right_iaddr);
 }
 
-static __maybe_unused int64_t
+static int64_t
 empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	  struct hist_entry *left __maybe_unused,
 	  struct hist_entry *right __maybe_unused)
@@ -369,7 +369,7 @@ empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 /*
  * total_stores_cmp - Comparison function for total stores sorting
  */
-static __maybe_unused int64_t
+static int64_t
 total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 		 struct hist_entry *left, struct hist_entry *right)
 {
@@ -386,6 +386,125 @@ total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return (left_store > right_store) - (left_store < right_store);
 }
 
+/*
+ * Function view dimensions
+ */
+static struct c2c_dimension dim_cycles_percent = {
+	.header		= HEADER_BOTH("Cycles", "%"),
+	.name		= "cycles_percent",
+	.cmp		= cycles_percent_cmp,
+	.entry		= cycles_percent_entry,
+	.width		= 9,
+};
+
+static struct c2c_dimension dim_total_stores = {
+	.header		= HEADER_BOTH("Store", "count"),
+	.name		= "total_stores",
+	.cmp		= total_stores_cmp,
+	.entry		= total_stores_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_cacheline_symbol = {
+	.header		= HEADER_LOW("Cacheline"),
+	.name		= "cacheline_symbol",
+	.cmp		= empty_cmp,
+	.entry		= cacheline_symbol_entry,
+	.width		= 18,
+};
+
+static struct c2c_dimension dim_iaddr_symbol = {
+	.header		= HEADER_LOW("Code address"),
+	.name		= "iaddr_symbol",
+	.cmp		= iaddr_symbol_cmp,
+	.entry		= iaddr_symbol_entry,
+	.width		= 20,
+};
+
+static struct c2c_dimension dim_symbol_view = {
+	.header		= HEADER_LOW("Symbol"),
+	.name		= "symbol_view",
+	.se		= &sort_sym,
+	.entry		= symbol_view_entry,
+	.width		= SYMBOL_WIDTH,
+};
+
+static struct c2c_dimension *function_view_dimensions[] = {
+	&dim_iaddr_symbol,
+	&dim_cycles_percent,
+	&dim_total_stores,
+	&dim_cacheline_symbol,
+	&dim_symbol_view,
+	NULL,
+};
+
+static __maybe_unused struct c2c_dimension *get_function_dimension(const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; function_view_dimensions[i]; i++) {
+		struct c2c_dimension *dim = function_view_dimensions[i];
+
+		if (!strcmp(dim->name, name))
+			return dim;
+	}
+
+	return NULL;
+}
+
+/* Wrappers so sort_entry-backed dimensions sort/collapse via their se. */
+static int64_t c2c_se_cmp(struct perf_hpp_fmt *fmt,
+			  struct hist_entry *a, struct hist_entry *b)
+{
+	struct c2c_fmt *c2c_fmt = container_of(fmt, struct c2c_fmt, fmt);
+	struct c2c_dimension *dim = c2c_fmt->dim;
+
+	return dim->se->se_cmp(a, b);
+}
+
+static int64_t c2c_se_collapse(struct perf_hpp_fmt *fmt,
+			       struct hist_entry *a, struct hist_entry *b)
+{
+	struct c2c_fmt *c2c_fmt = container_of(fmt, struct c2c_fmt, fmt);
+	struct c2c_dimension *dim = c2c_fmt->dim;
+	int64_t (*collapse_fn)(struct hist_entry *a, struct hist_entry *b);
+
+	collapse_fn = dim->se->se_collapse ?: dim->se->se_cmp;
+	return collapse_fn(a, b);
+}
+
+static __maybe_unused struct c2c_fmt *get_function_format(const char *name)
+{
+	struct c2c_dimension *dim = get_function_dimension(name);
+	struct c2c_fmt *c2c_fmt;
+	struct perf_hpp_fmt *fmt;
+
+	if (!dim)
+		return NULL;
+
+	c2c_fmt = zalloc(sizeof(*c2c_fmt));
+	if (!c2c_fmt)
+		return NULL;
+
+	fmt = &c2c_fmt->fmt;
+
+	c2c_fmt->dim = dim;
+	INIT_LIST_HEAD(&fmt->list);
+	INIT_LIST_HEAD(&fmt->sort_list);
+
+	fmt->cmp	= dim->se ? c2c_se_cmp : dim->cmp;
+	fmt->sort	= dim->se ? c2c_se_cmp : dim->cmp;
+	fmt->color	= dim->color;
+	fmt->entry	= dim->entry;
+	fmt->header	= c2c_header;
+	fmt->width	= c2c_width;
+	fmt->collapse	= dim->se ? c2c_se_collapse : dim->cmp;
+	fmt->equal	= fmt_equal;
+	fmt->free	= fmt_free;
+
+	return c2c_fmt;
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

