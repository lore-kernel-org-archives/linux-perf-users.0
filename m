Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B243C768B;
	Mon, 17 Aug 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959631; cv=none; b=EWw8JWf6Ts1WPNUS7xlvBq4pdUc9CSqA4Jfnx2BMbzCmQVBe293Da6NpsKXdO3rb/5AI+YR3+NgeT/W2bFmM7BgkXmO8Gm0Zgbr/VkHk39pQDXv3cO4clbePDllAWWMunMvQxhydC0KhQiDgk+VgW8blg8QQDm7B2faKUMLPwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959631; c=relaxed/simple;
	bh=tDQL1x+PuUdqZORjZvn6PX+jjWRTZb1Czg44Bf5fbTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPvkdZw+YLXAzG+rbqGdFlAG0rTPk8THI3jsGeJxmvDIZ2ATwoO9+aJztAV8AgkKHX9rZzR7uyBaLoX3xOJuY+s4TlBS3VZz//Az+0sf/Ua9JwCSGWK7ErSNAd+P5ypmb/zNTJRma28kMCSQe7SlmoSOfOJsDJPYefjuaAeaoDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdDbteSn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdDbteSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786959627; x=1818495627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDQL1x+PuUdqZORjZvn6PX+jjWRTZb1Czg44Bf5fbTY=;
  b=YdDbteSn+Hd6ohl/ZhHiyFE+y5Gvt/HLEONlmC2rp4X/4A5lu4Tej8I7
   Gk0sHhd08vBcRP8m8U2HhetOFuEq/OAQb8uhHPKa8Vwks/uyaFE3tNN1R
   +gw0W5FXdUfu2aY69nJYs+mqckiZueVIl1Yb4w4fRtUGLbTirKy2FNV77
   KFOZUpcXk5TV821S9llabd5tJeZp96Ts39vVmE0J/Jo38DQVswQv/A3/j
   yPLe1MhUySK25ZBin9HsDC0FCFg+G+zFiNnS5/oK2TZGAuWuLTT4zEblr
   xRRddyPcigvfy+SlCff4hoskFduksjszffZ1NwnLqN7dd15N1wvr65AKo
   Q==;
X-CSE-ConnectionGUID: lb94rx6PR+WEYyKoSuftBA==
X-CSE-MsgGUID: OVgICMMjTZakPkly+jD9nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98948180"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="98948180"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 02:40:24 -0700
X-CSE-ConnectionGUID: caCgAeZlRvmaneGJckNHtQ==
X-CSE-MsgGUID: AgUUxtHMR9i5a0CC97Rt2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="288337192"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 17 Aug 2026 02:40:19 -0700
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
Subject: [PATCH v9 4/9] perf c2c: add HPP list parsing for function view columns
Date: Mon, 17 Aug 2026 17:46:18 +0800
Message-ID: <20260817094623.3288456-5-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260817094623.3288456-1-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the parser that builds the function view's local HPP output and
sort lists from field strings. This includes dimension lookup, comparator
wrappers, c2c_fmt allocation, and the initialization entry points used by
the hierarchy builder.

The generic perf_hpp__setup_output_field() registers formats on the global
perf_hpp_list. Using it here would leave the function view's local list
without output columns and modify the cacheline view's list instead. Add
c2c_function_hists__setup_output_field() to append sort keys to the local
output list.

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
 tools/perf/util/c2c-function.c | 269 ++++++++++++++++++++++++++++++++-
 1 file changed, 266 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-function.c
index 7fce415c0f07..d27544016660 100644
--- a/tools/perf/util/c2c-function.c
+++ b/tools/perf/util/c2c-function.c
@@ -23,6 +23,7 @@
 #include "addr_location.h"
 #include "c2c.h"
 #include "cacheline.h"
+#include "debug.h"
 #include "hist.h"
 #include "map.h"
 #include "mem-events.h"
@@ -132,8 +133,8 @@ static int c2c_width(struct perf_hpp_fmt *fmt,
 			 dim->width;
 }
 
-static int __maybe_unused c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
-				     struct hists *hists, int line, int *span)
+static int c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		      struct hists *hists, int line, int *span)
 {
 	struct c2c_fmt *c2c_fmt;
 	struct c2c_dimension *dim;
@@ -411,9 +412,271 @@ static struct c2c_dimension dim_symbol_view = {
 	.width		= SYMBOL_WIDTH,
 };
 
-static struct c2c_dimension *function_view_dimensions[] __maybe_unused = {
+static struct c2c_dimension *function_view_dimensions[] = {
 	&dim_cycles_percent,
 	&dim_total_stores,
 	&dim_symbol_view,
 	NULL,
 };
+
+static struct c2c_dimension *get_function_dimension(const char *name)
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
+static int64_t c2c_se_sort(struct perf_hpp_fmt *fmt,
+			   struct hist_entry *a, struct hist_entry *b)
+{
+	struct c2c_fmt *c2c_fmt = container_of(fmt, struct c2c_fmt, fmt);
+	struct c2c_dimension *dim = c2c_fmt->dim;
+	int64_t (*sort_fn)(struct hist_entry *a, struct hist_entry *b);
+
+	sort_fn = dim->se->se_sort ?: dim->se->se_cmp;
+	return sort_fn(a, b);
+}
+
+/*
+ * Build the c2c_fmt for @name. Returns:
+ *   0        and *fmtp set     on success;
+ *   -ENOENT  and *fmtp = NULL   if @name is not a function-view dimension;
+ *   -ENOMEM                     if allocation failed (distinct from -ENOENT so
+ *                               the caller does not misreport it as an
+ *                               "invalid field").
+ */
+static int get_function_format(const char *name, struct c2c_fmt **fmtp)
+{
+	struct c2c_dimension *dim = get_function_dimension(name);
+	struct c2c_fmt *c2c_fmt;
+	struct perf_hpp_fmt *fmt;
+
+	*fmtp = NULL;
+
+	if (!dim)
+		return -ENOENT;
+
+	c2c_fmt = zalloc(sizeof(*c2c_fmt));
+	if (!c2c_fmt)
+		return -ENOMEM;
+
+	fmt = &c2c_fmt->fmt;
+
+	c2c_fmt->dim = dim;
+	INIT_LIST_HEAD(&fmt->list);
+	INIT_LIST_HEAD(&fmt->sort_list);
+
+	fmt->cmp	= dim->se ? c2c_se_cmp : dim->cmp;
+	fmt->sort	= dim->se ? c2c_se_sort : dim->cmp;
+	fmt->color	= dim->color;
+	fmt->entry	= dim->entry;
+	fmt->header	= c2c_header;
+	fmt->width	= c2c_width;
+	fmt->collapse	= dim->se ? c2c_se_collapse : dim->cmp;
+	fmt->equal	= c2c_fmt_equal;
+	fmt->free	= c2c_fmt_free;
+
+	*fmtp = c2c_fmt;
+	return 0;
+}
+
+static int
+c2c_function_hists__init_output(struct perf_hpp_list *hpp_list, char *name,
+				struct perf_env *env __maybe_unused)
+{
+	struct c2c_fmt *c2c_fmt;
+	int ret;
+
+	ret = get_function_format(name, &c2c_fmt);
+	if (ret == -ENOMEM)
+		return ret;
+	/* The function view only accepts its own dimensions. */
+	if (ret == -ENOENT)
+		return -EINVAL;
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
+			      struct perf_env *env __maybe_unused)
+{
+	struct c2c_fmt *c2c_fmt;
+	int ret;
+
+	ret = get_function_format(name, &c2c_fmt);
+	if (ret == -ENOMEM)
+		return ret;
+	/* The function view only accepts its own dimensions. */
+	if (ret == -ENOENT)
+		return -EINVAL;
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
+				pr_err("Invalid c2c function-view field: %s\n", tok);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Append the function view's sort keys to its own output fields, mirroring
+ * perf_hpp__setup_output_field() but on the local @list. The shared helper
+ * registers onto the global perf_hpp_list, which would leave this local list
+ * without output columns, so the function view keeps its own copy here.
+ */
+static void c2c_function_hists__setup_output_field(struct perf_hpp_list *list)
+{
+	struct perf_hpp_fmt *fmt;
+
+	perf_hpp_list__for_each_sort_list(list, fmt) {
+		struct perf_hpp_fmt *pos;
+
+		if (!fmt->entry && !fmt->color)
+			continue;
+
+		perf_hpp_list__for_each_format(list, pos) {
+			if (c2c_fmt_equal(fmt, pos))
+				goto next;
+		}
+
+		perf_hpp_list__column_register(list, fmt);
+next:
+		continue;
+	}
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
+	c2c_function_hists__setup_output_field(hpp_list);
+out:
+	if (ret)
+		perf_hpp__reset_output_field(hpp_list);
+	free(output);
+	free(sort);
+	return ret;
+}
+
+static int __maybe_unused
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
+static int __maybe_unused
+c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
+			   const char *output,
+			   const char *sort,
+			   struct perf_env *env)
+{
+	int nr_header_lines = c2c_hists->list.nr_header_lines;
+
+	perf_hpp__reset_output_field(&c2c_hists->list);
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
+}
-- 
2.52.0

