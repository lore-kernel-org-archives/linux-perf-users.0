Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067D3DBD51;
	Fri, 26 Jun 2026 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457433; cv=none; b=QERavU+GUGIOtaJJtE5yonM61D5tw+6Hzs89dOHpqC/Cs+EMYI1PDEgpLqPQBsBLUwBt7gAAgK0Sa7bgzt6X5+T8gVqgUVu25frxswc7JMkYlENOLfxdKySEMf0OtSwC0QB8qJuYwHmlu7UMRYQFLuB+o8/zCabW7x3gdCo+DGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457433; c=relaxed/simple;
	bh=+/PvM3ZNQq69m+A3zv46yII4xQu8t77nciHma9+ZSOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERMbqLCbhAcYLjRwPZVMgQ5QysE8W/VXxYpG40OaYNEBnfBf7sxrlu0esGlGOsTfzo0x2BlWLGqOCzuoA7WECI2ibQqLxsIAKwIvX4vGkNUc9bqVTOks/VZVa5u44JspcdYXQCOdyQfWaitg+wv6oAZ00iwi+y10h4NhzzTWH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnLxNQ6v; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnLxNQ6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782457432; x=1813993432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+/PvM3ZNQq69m+A3zv46yII4xQu8t77nciHma9+ZSOY=;
  b=dnLxNQ6vNAj+Ui9GEspRBVq6VUnv9T+qq19rzMof7jpwzpwdyZQqR87c
   gb6dCX28b75evPg2JaHl1Ydl/k/jpAOzpMz6tCcMHYsaTjDdZWGYh8ph7
   XtTo2Mz6rejie688ShfpxvIk1bARefwnFE9ipR+s26l7VRKhjLalJa5Gr
   ynsiP575xhC77OMz0uy2GtwL+Vak3oQS3RtuARrM2MpzpEvSB80LeJvmC
   MEi3NRbx56iRKJcmIVszAj4s+Puj3PWUVmUCzTlEfhOsIectvqgRLEUDW
   kGcg4GMJ1ubu62h8C07S6K8mSoh8KtG/atrqI2m5NsVfQss0XnRYZ1iVR
   A==;
X-CSE-ConnectionGUID: ICdHpSj1S/61/LDcZRUJMA==
X-CSE-MsgGUID: YoYg4ezSSpa0xCrl3ipU8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94397416"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94397416"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:03:47 -0700
X-CSE-ConnectionGUID: ACF5Ay4kQ9K0RUqms6KAuQ==
X-CSE-MsgGUID: l93ufXv4SiChOQ6T2jN+Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247893490"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2026 00:03:43 -0700
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
Subject: [PATCH 08/14] perf c2c: add HPP list parsing for function view histograms
Date: Fri, 26 Jun 2026 15:03:49 +0800
Message-ID: <20260626070355.1556721-9-jiebin.sun@intel.com>
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
 tools/perf/ui/browsers/c2c-function.c | 144 +++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 794a023239ce..c11a81d93c21 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -442,7 +442,7 @@ static struct c2c_dimension *function_view_dimensions[] = {
 	NULL,
 };
 
-static __maybe_unused struct c2c_dimension *get_function_dimension(const char *name)
+static struct c2c_dimension *get_function_dimension(const char *name)
 {
 	unsigned int i;
 
@@ -477,7 +477,7 @@ static int64_t c2c_se_collapse(struct perf_hpp_fmt *fmt,
 	return collapse_fn(a, b);
 }
 
-static __maybe_unused struct c2c_fmt *get_function_format(const char *name)
+static struct c2c_fmt *get_function_format(const char *name)
 {
 	struct c2c_dimension *dim = get_function_dimension(name);
 	struct c2c_fmt *c2c_fmt;
@@ -509,6 +509,146 @@ static __maybe_unused struct c2c_fmt *get_function_format(const char *name)
 	return c2c_fmt;
 }
 
+static int
+c2c_function_hists__init_output(struct perf_hpp_list *hpp_list, char *name,
+				struct perf_env *env __maybe_unused)
+{
+	struct c2c_fmt *c2c_fmt = get_function_format(name);
+	int level = 0;
+
+	if (!c2c_fmt) {
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
+	struct c2c_fmt *c2c_fmt = get_function_format(name);
+
+	if (!c2c_fmt) {
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
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

