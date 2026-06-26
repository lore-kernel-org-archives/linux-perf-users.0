Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1393DBD51;
	Fri, 26 Jun 2026 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457424; cv=none; b=hM6cv8+fLYHanIBr/9nyu1GLaKUoMUAqtLyRgPhqltjscixec0EXX2KtJ/mnuFBD+/NZKxvxZ76cb5j9eh61w46oG5DCYWCGv/HpZvhu9jzP17SiaMQY3772FVFMe3ijy+qasSryk/vPaBRVMz+GBeLG4cdSVquIR5QaAngu6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457424; c=relaxed/simple;
	bh=ErXlWbBb/u7leNblJCP4CinFu0NHX1t/fcSnf7zOgWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dc+H0mQdpCzenS4eF0VkQH1ONAx0aDyPOjWMAXdxOXymTlYdyPmA04V1RCpG3eLpm68256C14MjDYUAWsJT+NVxq1rBtPeYlpgQKfj2xYvwMZXRP2zfO1oXdvOyxrCg4r7Q1r1aiq/sNxacReSG+2hTDMe5xzhQDnCe5aqsKYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWm9q7IJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWm9q7IJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782457424; x=1813993424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ErXlWbBb/u7leNblJCP4CinFu0NHX1t/fcSnf7zOgWU=;
  b=aWm9q7IJ1Sfr0Eq0tdUJTlIDDAJclZHisOolbJNirFHPFUQVYgKGvUFS
   L0Ozz0IAPTnBEInRGNH1xarYMq22an37GwauEtKmPxKpdVqMuOysNhJzV
   wWrTSQcw0ZJ9o7/nYDg6KQSduF5R3hcAHDmu0K4ndeoYdhCU66OsLaUnt
   Qf6WQoI/bgurGXiVeT9HSeEREBXZyHVnam9nXSSLR5weaTRfGn4JnHqKg
   3kuzBR2Ap5OrT4ucfAqqXFokHn8dlxnP5IcZs3PQ3bPaq66wWOJWwuv4Z
   nXKTLN2IJteF4F3UXAqXSjJ0/SRXVNi5eqsqyugAKZgRVItSvyxei0Vrd
   w==;
X-CSE-ConnectionGUID: foD5n2WmQnGirXognrNzAg==
X-CSE-MsgGUID: 18Ml3is1THqrpje5NrxT8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94397402"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94397402"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:03:43 -0700
X-CSE-ConnectionGUID: 9uCkJnH0TMSH0KGiZtDhSA==
X-CSE-MsgGUID: 5IxS943/Rhqkln7H24cH9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247893474"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2026 00:03:39 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH 07/14] perf c2c: add dimension definitions and format creation
Date: Fri, 26 Jun 2026 15:03:48 +0800
Message-ID: <20260626070355.1556721-8-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626070355.1556721-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
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
index 172e1aa86eca..794a023239ce 100644
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
@@ -183,7 +183,7 @@ static __maybe_unused u64 hist_entry__child_stores(struct hist_entry *he)
 	return sum;
 }
 
-static __maybe_unused int
+static int
 total_stores_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		   struct hist_entry *he)
 {
@@ -200,7 +200,7 @@ total_stores_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 /*
  * cacheline_symbol_entry - Render cacheline address for function view
  */
-static __maybe_unused int
+static int
 cacheline_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		       struct hist_entry *he)
 {
@@ -219,7 +219,7 @@ cacheline_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 }
 
 /* Render the code (instruction) address for level-1 and level-2 entries. */
-static __maybe_unused int
+static int
 iaddr_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		   struct hist_entry *he)
 {
@@ -250,7 +250,7 @@ iaddr_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 /*
  * symbol_view_entry - Render symbol name for function view with expansion indicators
  */
-static __maybe_unused int
+static int
 symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		  struct hist_entry *he)
 {
@@ -283,7 +283,7 @@ symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 /*
  * cycles_percent_entry - Render cycles percentage column
  */
-static __maybe_unused int
+static int
 cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		     struct hist_entry *he)
 {
@@ -318,7 +318,7 @@ cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 /*
  * cycles_percent_cmp - Comparison function for cycles percentage sorting
  */
-static __maybe_unused int64_t
+static int64_t
 cycles_percent_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 		   struct hist_entry *left, struct hist_entry *right)
 {
@@ -339,7 +339,7 @@ cycles_percent_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 /*
  * iaddr_symbol_cmp - Comparison function for instruction address sorting
  */
-static __maybe_unused int64_t
+static int64_t
 iaddr_symbol_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 		 struct hist_entry *left, struct hist_entry *right)
 {
@@ -362,7 +362,7 @@ iaddr_symbol_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return (left_iaddr < right_iaddr) - (left_iaddr > right_iaddr);
 }
 
-static __maybe_unused int64_t
+static int64_t
 empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	  struct hist_entry *left __maybe_unused,
 	  struct hist_entry *right __maybe_unused)
@@ -373,7 +373,7 @@ empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 /*
  * total_stores_cmp - Comparison function for total stores sorting
  */
-static __maybe_unused int64_t
+static int64_t
 total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 		 struct hist_entry *left, struct hist_entry *right)
 {
@@ -390,6 +390,125 @@ total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
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

