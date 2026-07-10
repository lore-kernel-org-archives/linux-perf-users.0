Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8143F1ABA;
	Fri, 10 Jul 2026 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672997; cv=none; b=oORcq04FW6FZkXT2ZmJdaGPy1NIKPAqpBmhCBQ2FVIpIgMKq7QSAQHS/f7KSPaIzPO7H3ZDNEzHM+QOGoSh2l0PnlC7gDC0fufeydOGLDLfJx2mIzy7/f2svNmEFmrywSukXQz3IYl5wwnuYR/jdA8lXVeBahQREuuhhE8rYZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672997; c=relaxed/simple;
	bh=q6eCvEJCMXKcfuhKVhW/RBzw1J5hSGk4xktrfiIWVcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szumMuTYHzXijOtMSZ3sPiBqgmHrlDrkWvIdafXQa2GbL6rjIHDdxF+5FLjZVmFky9OMvl8y4stNcaN68JNHSlrcNDN48ndGfjyRERZ79hbqjGfHKtf7bUJcUA6K6dM+SilybF71eOPVA79M61MsLciKUBZWhzq8evFP1V90cIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWBbbdJt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWBbbdJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672994; x=1815208994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6eCvEJCMXKcfuhKVhW/RBzw1J5hSGk4xktrfiIWVcw=;
  b=fWBbbdJt5AD03GnjJmU4foYzKX8gnpJjYRco03C/rVJsTeuJUN83o4aH
   T4h38H/hUTH1XwS+dj12DMc/QmIypih6wzV8RwuKGYbAiV4F9VRqEoB+s
   EsdVcTquKIibqvN83WnKTGJqFhVUrQBP5mqDQVhTh4kmuB2G3EAxWLW2j
   E3I+X9/pbiqz6zVa6Sdz6i3pa1dUwaP3ElhN1j8JbinTGdnyt77my+wfe
   k16SiCtswBImiXv9ccmUKxY8wWaQZ8FKsaD2RXbsyilzX2urhifnbYjxO
   vMkqOMy/gf55rN5zSqu+noTLh62sthdEzj1r4rWlKq8teT61m5tf1cxpM
   Q==;
X-CSE-ConnectionGUID: ly5LWzP/R3CqOb2NSQDteg==
X-CSE-MsgGUID: CaU3a+IhTbuXS4/DtzVwFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390851"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390851"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:11 -0700
X-CSE-ConnectionGUID: c+Tgk3tXSaysaY49NMxeAw==
X-CSE-MsgGUID: f0aZKz4aQV6TrJNuLHX0ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435382"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:43:06 -0700
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
Subject: [PATCH v2 08/14] perf c2c: add HPP list parsing for function view histograms
Date: Fri, 10 Jul 2026 16:42:41 +0800
Message-ID: <20260710084247.3576706-9-jiebin.sun@intel.com>
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

Add the histogram initialization and column parsing infrastructure:

- c2c_function_hists__init_output(): register output columns
- c2c_function_hists__init_sort(): register sort columns
- function_hpp_list__parse(): parse comma-separated column strings
- c2c_function_hists__init(): initialize function histograms with sort
- c2c_function_hists__reinit(): reinitialize with new output/sort

These functions bridge the function view's custom dimensions with
the perf HPP list infrastructure, enabling dynamic column
configuration during hierarchy construction.

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
 tools/perf/ui/browsers/c2c-function.c | 170 +++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 7c2bb8f9e113..0f21cf39f0ce 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -438,7 +438,7 @@ static struct c2c_dimension *function_view_dimensions[] = {
 	NULL,
 };
 
-static __maybe_unused struct c2c_dimension *get_function_dimension(const char *name)
+static struct c2c_dimension *get_function_dimension(const char *name)
 {
 	unsigned int i;
 
@@ -473,18 +473,29 @@ static int64_t c2c_se_collapse(struct perf_hpp_fmt *fmt,
 	return collapse_fn(a, b);
 }
 
-static __maybe_unused struct c2c_fmt *get_function_format(const char *name)
+/*
+ * Build the c2c_fmt for @name. Returns:
+ *   0        and *fmtp set     on success;
+ *   -ENOENT  and *fmtp = NULL   if @name is not a function-view dimension
+ *                               (caller should fall back to the generic field);
+ *   -ENOMEM                     if allocation failed (distinct from -ENOENT so
+ *                               the caller does not misreport it as an
+ *                               "invalid field").
+ */
+static int get_function_format(const char *name, struct c2c_fmt **fmtp)
 {
 	struct c2c_dimension *dim = get_function_dimension(name);
 	struct c2c_fmt *c2c_fmt;
 	struct perf_hpp_fmt *fmt;
 
+	*fmtp = NULL;
+
 	if (!dim)
-		return NULL;
+		return -ENOENT;
 
 	c2c_fmt = zalloc(sizeof(*c2c_fmt));
 	if (!c2c_fmt)
-		return NULL;
+		return -ENOMEM;
 
 	fmt = &c2c_fmt->fmt;
 
@@ -502,7 +513,156 @@ static __maybe_unused struct c2c_fmt *get_function_format(const char *name)
 	fmt->equal	= fmt_equal;
 	fmt->free	= fmt_free;
 
-	return c2c_fmt;
+	*fmtp = c2c_fmt;
+	return 0;
+}
+
+static int
+c2c_function_hists__init_output(struct perf_hpp_list *hpp_list, char *name,
+				struct perf_env *env __maybe_unused)
+{
+	struct c2c_fmt *c2c_fmt;
+	int level = 0;
+	int ret;
+
+	ret = get_function_format(name, &c2c_fmt);
+	if (ret == -ENOMEM)
+		return ret;
+	if (ret == -ENOENT) {
+		reset_dimensions();
+		return output_field_add(hpp_list, name, &level);
+	}
+
+	/*
+	 * Mark symbol-backed columns so hists__has(hists, sym) is correct.
+	 * Only dim_symbol_view carries a sort_entry (.se); the function
+	 * view's field strings are fixed and always include symbol_view, so
+	 * this single check is sufficient (unlike the user-configurable
+	 * cacheline view, which must also test dim_iaddr).
+	 */
+	if (c2c_fmt->dim->se == &sort_sym)
+		hpp_list->sym = 1;
+
+	perf_hpp_list__column_register(hpp_list, &c2c_fmt->fmt);
+	return 0;
+}
+
+static int
+c2c_function_hists__init_sort(struct perf_hpp_list *hpp_list, char *name,
+			      struct perf_env *env)
+{
+	struct c2c_fmt *c2c_fmt;
+	int ret;
+
+	ret = get_function_format(name, &c2c_fmt);
+	if (ret == -ENOMEM)
+		return ret;
+	if (ret == -ENOENT) {
+		reset_dimensions();
+		return sort_dimension__add(hpp_list, name, /*evlist=*/NULL, env, /*level=*/0);
+	}
+
+	/* Mark symbol-backed sort keys so hists__has(hists, sym) is correct. */
+	if (c2c_fmt->dim->se == &sort_sym)
+		hpp_list->sym = 1;
+
+	perf_hpp_list__register_sort_field(hpp_list, &c2c_fmt->fmt);
+	return 0;
+}
+
+typedef int (*hpp_list_add_fn)(struct perf_hpp_list *hpp_list, char *name,
+			       struct perf_env *env);
+
+static int function_hpp_list__add_tokens(struct perf_hpp_list *hpp_list, char *list,
+					 struct perf_env *env, hpp_list_add_fn add)
+{
+	char *tok, *tmp;
+	int ret;
+
+	if (!list)
+		return 0;
+
+	for (tok = strtok_r(list, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		ret = add(hpp_list, tok, env);
+		if (ret) {
+			if (ret == -EINVAL || ret == -ESRCH)
+				pr_err("Invalid c2c function-view field: %s", tok);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int
+function_hpp_list__parse(struct perf_hpp_list *hpp_list,
+			 const char *output_str,
+			 const char *sort_str,
+			 struct perf_env *env)
+{
+	char *output = output_str ? strdup(output_str) : NULL;
+	char *sort   = sort_str   ? strdup(sort_str)   : NULL;
+	int ret = 0;
+
+	if ((output_str && !output) || (sort_str && !sort)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = function_hpp_list__add_tokens(hpp_list, output, env,
+					    c2c_function_hists__init_output);
+	if (ret)
+		goto out;
+
+	ret = function_hpp_list__add_tokens(hpp_list, sort, env,
+					    c2c_function_hists__init_sort);
+	if (ret)
+		goto out;
+
+	perf_hpp__setup_output_field(hpp_list);
+out:
+	free(output);
+	free(sort);
+	return ret;
+}
+
+static __maybe_unused int
+c2c_function_hists__init(struct c2c_hists *hists,
+			 const char *sort,
+			 int nr_header_lines,
+			 struct perf_env *env)
+{
+	__hists__init(&hists->hists, &hists->list);
+
+	perf_hpp_list__init(&hists->list);
+
+	hists->list.nr_header_lines = nr_header_lines;
+
+	return function_hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
+}
+
+static __maybe_unused int
+c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
+			   const char *output,
+			   const char *sort,
+			   struct perf_env *env)
+{
+	int nr_header_lines = c2c_hists->list.nr_header_lines;
+
+	perf_hpp__reset_output_field(&c2c_hists->list);
+	INIT_LIST_HEAD(&c2c_hists->list.sorts);
+
+	/* Clear stale state flags so a different output/sort set starts fresh. */
+	c2c_hists->list.need_collapse = 0;
+	c2c_hists->list.parent = 0;
+	c2c_hists->list.sym = 0;
+	c2c_hists->list.dso = 0;
+	c2c_hists->list.socket = 0;
+	c2c_hists->list.thread = 0;
+	c2c_hists->list.comm = 0;
+	c2c_hists->list.comm_nodigit = 0;
+	c2c_hists->list.nr_header_lines = nr_header_lines;
+
+	return function_hpp_list__parse(&c2c_hists->list, output, sort, env);
 }
 
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
-- 
2.52.0

