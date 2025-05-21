Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C221221D80;
	Wed, 21 May 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842621; cv=none; b=ZqBVA7fFdzEK+xgOlDqVmITycNZpRVy9SjtdGF41pcsW5w4HV/4M2HKek2p8zTCDCrlvw9gYkvzAFZTdhorb4fTTYdUdb//vEBaXfgMBLoTcriENeHcsdxBgzqVxLIVjOU7ZtMO4n1o6jlwZfu+6+tE8pdjLPzKcUIgV8pMXHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842621; c=relaxed/simple;
	bh=K4EkwkW1PB6SFKsjm/cyw+LNQBSsL5THYKa54NJtP5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jVofm0FwuXx9qh9A4JAOXwGa8lAA1SvbFKQl2AnS1W9IdfZ5M/SLlyiCzuz1h/OA+0hJHFB1/qRFGes9a68dScaQ39vrACcJ4oZk/BOaodI20xP+7cBLW0+EIodEsiAISssEaxRJgrtPPxs+/oW+iiVXZ0axLHP/k3K0cJB+DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8oZKm98; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8oZKm98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747842618; x=1779378618;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=K4EkwkW1PB6SFKsjm/cyw+LNQBSsL5THYKa54NJtP5I=;
  b=B8oZKm98odccKm5fzqnOAwL2itF/elPVKKVJ6NNwLhAjInOTursp+nCu
   ejyzYf1T39qy4N8MpOxPlnXsygDdkrJe3BLWBgLn4HkBa6fFM7Hnpj6y3
   aDSaj1YfJZ1P7zjwV0/rlMpeYaTtd5Y6DpiLcOasbIVJlGUPkn1aOoql+
   vs/OLoQFHekCVgX1MGayAX308EMQLrm+a6Ea8d57QkbCYyAQPTs78Bze0
   VMTGehaipfAvwMy4z37xmU+850WziHU4xwedU2MADqjB/3heP2VjDIsoP
   14ATThAfU8yBlfPyFa9Tewsh6xhn2V/G2M2DMewp8nzVU2qNeqFPusB55
   w==;
X-CSE-ConnectionGUID: WyVpQkPmTVSNYTYLl932eA==
X-CSE-MsgGUID: n7+N6gBMTH+QMZCOeOs0HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="72347754"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="72347754"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:50:16 -0700
X-CSE-ConnectionGUID: LmtNYw1QTHmw9whrxJ4Yew==
X-CSE-MsgGUID: nHCJwc82Rsux4qs15B3jJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="141196068"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:50:08 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8E02B20B5736;
	Wed, 21 May 2025 08:50:04 -0700 (PDT)
Message-ID: <3e8b674e-38f7-4212-923d-f53626de69f2@linux.intel.com>
Date: Wed, 21 May 2025 11:50:03 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] perf sort: Use perf_env to set arch sort keys and
 header
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>,
 Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>,
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming
 <matt@readmodwrite.com>, Chun-Tse Shao <ctshao@google.com>,
 Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250521135500.677508-1-irogers@google.com>
 <20250521135500.677508-4-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250521135500.677508-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-21 9:54 a.m., Ian Rogers wrote:
> Previously arch_support_sort_key and arch_perf_header_entry used a
> weak symbol to compile as appropriate for x86 and powerpc. A
> limitation to this is that the handling of a data file could vary in
> cross-platform development. Change to using the perf_env of the
> current session to determine the architecture kind and set the sort
> key and header entries as appropriate.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/powerpc/util/Build   |  1 -
>  tools/perf/arch/powerpc/util/event.c | 34 ----------------
>  tools/perf/arch/x86/util/event.c     | 19 ---------
>  tools/perf/builtin-annotate.c        |  2 +-
>  tools/perf/builtin-c2c.c             | 53 +++++++++++++-----------
>  tools/perf/builtin-diff.c            |  2 +-
>  tools/perf/builtin-report.c          |  2 +-
>  tools/perf/builtin-top.c             | 16 ++++----
>  tools/perf/tests/hists_cumulate.c    |  8 ++--
>  tools/perf/tests/hists_filter.c      |  8 ++--
>  tools/perf/tests/hists_link.c        |  8 ++--
>  tools/perf/tests/hists_output.c      | 10 ++---
>  tools/perf/util/event.h              |  3 --
>  tools/perf/util/sort.c               | 61 ++++++++++++++++++++--------
>  tools/perf/util/sort.h               |  5 ++-
>  15 files changed, 104 insertions(+), 128 deletions(-)
>  delete mode 100644 tools/perf/arch/powerpc/util/event.c
> 
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index ed82715080f9..fdd6a77a3432 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -5,7 +5,6 @@ perf-util-y += mem-events.o
>  perf-util-y += pmu.o
>  perf-util-y += sym-handling.o
>  perf-util-y += evsel.o
> -perf-util-y += event.o
>  
>  perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
>  
> diff --git a/tools/perf/arch/powerpc/util/event.c b/tools/perf/arch/powerpc/util/event.c
> deleted file mode 100644
> index 024ac8b54c33..000000000000
> --- a/tools/perf/arch/powerpc/util/event.c
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/types.h>
> -#include <linux/string.h>
> -#include <linux/zalloc.h>
> -
> -#include "../../../util/event.h"
> -#include "../../../util/synthetic-events.h"
> -#include "../../../util/machine.h"
> -#include "../../../util/tool.h"
> -#include "../../../util/map.h"
> -#include "../../../util/debug.h"
> -#include "../../../util/sample.h"
> -
> -const char *arch_perf_header_entry(const char *se_header)
> -{
> -	if (!strcmp(se_header, "Local INSTR Latency"))
> -		return "Finish Cyc";
> -	else if (!strcmp(se_header, "INSTR Latency"))
> -		return "Global Finish_cyc";
> -	else if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> -		return "Dispatch Cyc";
> -	else if (!strcmp(se_header, "Pipeline Stage Cycle"))
> -		return "Global Dispatch_cyc";
> -	return se_header;
> -}
> -
> -int arch_support_sort_key(const char *sort_key)
> -{
> -	if (!strcmp(sort_key, "p_stage_cyc"))
> -		return 1;
> -	if (!strcmp(sort_key, "local_p_stage_cyc"))
> -		return 1;
> -	return 0;
> -}
> diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
> index 576c1c36046c..3cd384317739 100644
> --- a/tools/perf/arch/x86/util/event.c
> +++ b/tools/perf/arch/x86/util/event.c
> @@ -91,22 +91,3 @@ int perf_event__synthesize_extra_kmaps(const struct perf_tool *tool,
>  }
>  
>  #endif
> -
> -const char *arch_perf_header_entry(const char *se_header)
> -{
> -	if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> -		return "Local Retire Latency";
> -	else if (!strcmp(se_header, "Pipeline Stage Cycle"))
> -		return "Retire Latency";
> -
> -	return se_header;
> -}
> -
> -int arch_support_sort_key(const char *sort_key)
> -{
> -	if (!strcmp(sort_key, "p_stage_cyc"))
> -		return 1;
> -	if (!strcmp(sort_key, "local_p_stage_cyc"))
> -		return 1;
> -	return 0;
> -}
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 9833c2c82a2f..a2d41614ef5e 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -947,7 +947,7 @@ int cmd_annotate(int argc, const char **argv)
>  			annotate_opts.show_br_cntr = true;
>  	}
>  
> -	if (setup_sorting(NULL) < 0)
> +	if (setup_sorting(/*evlist=*/NULL, &annotate.session->header.env) < 0)
>  		usage_with_options(annotate_usage, options);
>  
>  	ret = __cmd_annotate(&annotate);
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e2e257bcc461..324368aabfa2 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -195,12 +195,14 @@ static struct hist_entry_ops c2c_entry_ops = {
>  
>  static int c2c_hists__init(struct c2c_hists *hists,
>  			   const char *sort,
> -			   int nr_header_lines);
> +			   int nr_header_lines,
> +			   struct perf_env *env);
>  
>  static struct c2c_hists*
>  he__get_c2c_hists(struct hist_entry *he,
>  		  const char *sort,
> -		  int nr_header_lines)
> +		  int nr_header_lines,
> +		  struct perf_env *env)
>  {
>  	struct c2c_hist_entry *c2c_he;
>  	struct c2c_hists *hists;
> @@ -214,7 +216,7 @@ he__get_c2c_hists(struct hist_entry *he,
>  	if (!hists)
>  		return NULL;
>  
> -	ret = c2c_hists__init(hists, sort, nr_header_lines);
> +	ret = c2c_hists__init(hists, sort, nr_header_lines, env);
>  	if (ret) {
>  		free(hists);
>  		return NULL;
> @@ -350,7 +352,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  
>  		mi = mi_dup;
>  
> -		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2);
> +		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2, machine->env);
>  		if (!c2c_hists)
>  			goto free_mi;
>  
> @@ -1966,7 +1968,8 @@ static struct c2c_fmt *get_format(const char *name)
>  	return c2c_fmt;
>  }
>  
> -static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char *name)
> +static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char *name,
> +				  struct perf_env *env __maybe_unused)
>  {
>  	struct c2c_fmt *c2c_fmt = get_format(name);
>  	int level = 0;
> @@ -1980,14 +1983,14 @@ static int c2c_hists__init_output(struct perf_hpp_list *hpp_list, char *name)
>  	return 0;
>  }
>  
> -static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
> +static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name, struct perf_env *env)
>  {
>  	struct c2c_fmt *c2c_fmt = get_format(name);
>  	struct c2c_dimension *dim;
>  
>  	if (!c2c_fmt) {
>  		reset_dimensions();
> -		return sort_dimension__add(hpp_list, name, NULL, 0);
> +		return sort_dimension__add(hpp_list, name, /*evlist=*/NULL, env, /*level=*/0);
>  	}
>  
>  	dim = c2c_fmt->dim;
> @@ -2008,7 +2011,7 @@ static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
>  										\
>  		for (tok = strtok_r((char *)_list, ", ", &tmp);			\
>  				tok; tok = strtok_r(NULL, ", ", &tmp)) {	\
> -			ret = _fn(hpp_list, tok);				\
> +			ret = _fn(hpp_list, tok, env);				\
>  			if (ret == -EINVAL) {					\
>  				pr_err("Invalid --fields key: `%s'", tok);	\
>  				break;						\
> @@ -2021,7 +2024,8 @@ static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name)
>  
>  static int hpp_list__parse(struct perf_hpp_list *hpp_list,
>  			   const char *output_,
> -			   const char *sort_)
> +			   const char *sort_,
> +			   struct perf_env *env)
>  {
>  	char *output = output_ ? strdup(output_) : NULL;
>  	char *sort   = sort_   ? strdup(sort_) : NULL;
> @@ -2052,7 +2056,8 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
>  
>  static int c2c_hists__init(struct c2c_hists *hists,
>  			   const char *sort,
> -			   int nr_header_lines)
> +			   int nr_header_lines,
> +			   struct perf_env *env)
>  {
>  	__hists__init(&hists->hists, &hists->list);
>  
> @@ -2066,15 +2071,16 @@ static int c2c_hists__init(struct c2c_hists *hists,
>  	/* Overload number of header lines.*/
>  	hists->list.nr_header_lines = nr_header_lines;
>  
> -	return hpp_list__parse(&hists->list, NULL, sort);
> +	return hpp_list__parse(&hists->list, /*output=*/NULL, sort, env);
>  }
>  
>  static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
>  			     const char *output,
> -			     const char *sort)
> +			     const char *sort,
> +			     struct perf_env *env)
>  {
>  	perf_hpp__reset_output_field(&c2c_hists->list);
> -	return hpp_list__parse(&c2c_hists->list, output, sort);
> +	return hpp_list__parse(&c2c_hists->list, output, sort, env);
>  }
>  
>  #define DISPLAY_LINE_LIMIT  0.001
> @@ -2207,8 +2213,9 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
>  	return 0;
>  }
>  
> -static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
> +static int resort_cl_cb(struct hist_entry *he, void *arg)
>  {
> +	struct perf_env *env = arg;
>  	struct c2c_hist_entry *c2c_he;
>  	struct c2c_hists *c2c_hists;
>  	bool display = he__display(he, &c2c.shared_clines_stats);
> @@ -2222,7 +2229,7 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
>  		c2c_he->cacheline_idx = idx++;
>  		calc_width(c2c_he);
>  
> -		c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort);
> +		c2c_hists__reinit(c2c_hists, c2c.cl_output, c2c.cl_resort, env);
>  
>  		hists__collapse_resort(&c2c_hists->hists, NULL);
>  		hists__output_resort_cb(&c2c_hists->hists, NULL, filter_cb);
> @@ -2333,7 +2340,7 @@ static int resort_shared_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
>  	return 0;
>  }
>  
> -static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb)
> +static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb, void *arg)
>  {
>  	struct rb_node *next = rb_first_cached(&hists->entries);
>  	int ret = 0;
> @@ -2342,7 +2349,7 @@ static int hists__iterate_cb(struct hists *hists, hists__resort_cb_t cb)
>  		struct hist_entry *he;
>  
>  		he = rb_entry(next, struct hist_entry, rb_node);
> -		ret = cb(he, NULL);
> +		ret = cb(he, arg);
>  		if (ret)
>  			break;
>  		next = rb_next(&he->rb_node);
> @@ -2448,7 +2455,7 @@ static void print_cacheline(struct c2c_hists *c2c_hists,
>  	hists__fprintf(&c2c_hists->hists, false, 0, 0, 0, out, false);
>  }
>  
> -static void print_pareto(FILE *out)
> +static void print_pareto(FILE *out, struct perf_env *env)
>  {
>  	struct perf_hpp_list hpp_list;
>  	struct rb_node *nd;
> @@ -2473,7 +2480,7 @@ static void print_pareto(FILE *out)
>  			    "dcacheline";
>  
>  	perf_hpp_list__init(&hpp_list);
> -	ret = hpp_list__parse(&hpp_list, cl_output, NULL);
> +	ret = hpp_list__parse(&hpp_list, cl_output, /*evlist=*/NULL, env);
>  
>  	if (WARN_ONCE(ret, "failed to setup sort entries\n"))
>  		return;
> @@ -2538,7 +2545,7 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
>  	fprintf(out, "=================================================\n");
>  	fprintf(out, "#\n");
>  
> -	print_pareto(out);
> +	print_pareto(out, &session->header.env);
>  }
>  
>  #ifdef HAVE_SLANG_SUPPORT
> @@ -3095,7 +3102,7 @@ static int perf_c2c__report(int argc, const char **argv)
>  		goto out_session;
>  	}
>  
> -	err = c2c_hists__init(&c2c.hists, "dcacheline", 2);
> +	err = c2c_hists__init(&c2c.hists, "dcacheline", 2, &session->header.env);
>  	if (err) {
>  		pr_debug("Failed to initialize hists\n");
>  		goto out_session;
> @@ -3179,13 +3186,13 @@ static int perf_c2c__report(int argc, const char **argv)
>  	else if (c2c.display == DISPLAY_SNP_PEER)
>  		sort_str = "tot_peer";
>  
> -	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
> +	c2c_hists__reinit(&c2c.hists, output_str, sort_str, &session->header.env);
>  
>  	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
>  
>  	hists__collapse_resort(&c2c.hists.hists, NULL);
>  	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
> -	hists__iterate_cb(&c2c.hists.hists, resort_cl_cb);
> +	hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, &session->header.env);
>  
>  	ui_progress__finish();
>  
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index ae490d58af92..f6735cf02329 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -2003,7 +2003,7 @@ int cmd_diff(int argc, const char **argv)
>  		sort__mode = SORT_MODE__DIFF;
>  	}
>  
> -	if (setup_sorting(NULL) < 0)
> +	if (setup_sorting(/*evlist=*/NULL, &data__files[0].session->header.env) < 0)
>  		usage_with_options(diff_usage, options);
>  
>  	setup_pager();
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index f0299c7ee025..8be6e7c3bd22 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1776,7 +1776,7 @@ int cmd_report(int argc, const char **argv)
>  	}
>  
>  	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
> -	    (setup_sorting(session->evlist) < 0)) {
> +	    (setup_sorting(session->evlist, &session->header.env) < 0)) {
>  		if (sort_order)
>  			parse_options_usage(report_usage, options, "s", 1);
>  		if (field_order)
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 7b6cde87d2af..13ef0d188a96 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1747,7 +1747,14 @@ int cmd_top(int argc, const char **argv)
>  
>  	setup_browser(false);
>  
> -	if (setup_sorting(top.evlist) < 0) {
> +	top.session = perf_session__new(/*data=*/NULL, /*tool=*/NULL);
> +	if (IS_ERR(top.session)) {
> +		status = PTR_ERR(top.session);
> +		top.session = NULL;
> +		goto out_delete_evlist;
> +	}
> +
> +	if (setup_sorting(top.evlist, &top.session->header.env) < 0) {

I doubt a valide env can be got in perf_session__new(), since there is
no perf.data in perf top.
Maybe just need to invoke the perf_env__raw_arch() instead to fill the
env->arch.

Thanks,
Kan

>  		if (sort_order)
>  			parse_options_usage(top_usage, options, "s", 1);
>  		if (field_order)
> @@ -1820,13 +1827,6 @@ int cmd_top(int argc, const char **argv)
>  		signal(SIGWINCH, winch_sig);
>  	}
>  
> -	top.session = perf_session__new(NULL, NULL);
> -	if (IS_ERR(top.session)) {
> -		status = PTR_ERR(top.session);
> -		top.session = NULL;
> -		goto out_delete_evlist;
> -	}
> -
>  	if (!evlist__needs_bpf_sb_event(top.evlist))
>  		top.record_opts.no_bpf_event = true;
>  
> diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
> index 1e0f5a310fd5..3eb9ef8d7ec6 100644
> --- a/tools/perf/tests/hists_cumulate.c
> +++ b/tools/perf/tests/hists_cumulate.c
> @@ -295,7 +295,7 @@ static int test1(struct evsel *evsel, struct machine *machine)
>  	symbol_conf.cumulate_callchain = false;
>  	evsel__reset_sample_bit(evsel, CALLCHAIN);
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  	callchain_register_param(&callchain_param);
>  
>  	err = add_hist_entries(hists, machine);
> @@ -442,7 +442,7 @@ static int test2(struct evsel *evsel, struct machine *machine)
>  	symbol_conf.cumulate_callchain = false;
>  	evsel__set_sample_bit(evsel, CALLCHAIN);
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  	callchain_register_param(&callchain_param);
>  
>  	err = add_hist_entries(hists, machine);
> @@ -500,7 +500,7 @@ static int test3(struct evsel *evsel, struct machine *machine)
>  	symbol_conf.cumulate_callchain = true;
>  	evsel__reset_sample_bit(evsel, CALLCHAIN);
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  	callchain_register_param(&callchain_param);
>  
>  	err = add_hist_entries(hists, machine);
> @@ -684,7 +684,7 @@ static int test4(struct evsel *evsel, struct machine *machine)
>  	symbol_conf.cumulate_callchain = true;
>  	evsel__set_sample_bit(evsel, CALLCHAIN);
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  
>  	callchain_param = callchain_param_default;
>  	callchain_register_param(&callchain_param);
> diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
> index 4b2e4f2fbe48..1cebd20cc91c 100644
> --- a/tools/perf/tests/hists_filter.c
> +++ b/tools/perf/tests/hists_filter.c
> @@ -131,10 +131,6 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
>  		goto out;
>  	err = TEST_FAIL;
>  
> -	/* default sort order (comm,dso,sym) will be used */
> -	if (setup_sorting(NULL) < 0)
> -		goto out;
> -
>  	machines__init(&machines);
>  
>  	/* setup threads/dso/map/symbols also */
> @@ -145,6 +141,10 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
>  	if (verbose > 1)
>  		machine__fprintf(machine, stderr);
>  
> +	/* default sort order (comm,dso,sym) will be used */
> +	if (setup_sorting(evlist, machine->env) < 0)
> +		goto out;
> +
>  	/* process sample events */
>  	err = add_hist_entries(evlist, machine);
>  	if (err < 0)
> diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
> index 5b6f1e883466..996f5f0b3bd1 100644
> --- a/tools/perf/tests/hists_link.c
> +++ b/tools/perf/tests/hists_link.c
> @@ -303,10 +303,6 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
>  		goto out;
>  
>  	err = TEST_FAIL;
> -	/* default sort order (comm,dso,sym) will be used */
> -	if (setup_sorting(NULL) < 0)
> -		goto out;
> -
>  	machines__init(&machines);
>  
>  	/* setup threads/dso/map/symbols also */
> @@ -317,6 +313,10 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
>  	if (verbose > 1)
>  		machine__fprintf(machine, stderr);
>  
> +	/* default sort order (comm,dso,sym) will be used */
> +	if (setup_sorting(evlist, machine->env) < 0)
> +		goto out;
> +
>  	/* process sample events */
>  	err = add_hist_entries(evlist, machine);
>  	if (err < 0)
> diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
> index 33b5cc8352a7..ee5ec8bda60e 100644
> --- a/tools/perf/tests/hists_output.c
> +++ b/tools/perf/tests/hists_output.c
> @@ -146,7 +146,7 @@ static int test1(struct evsel *evsel, struct machine *machine)
>  	field_order = NULL;
>  	sort_order = NULL; /* equivalent to sort_order = "comm,dso,sym" */
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  
>  	/*
>  	 * expected output:
> @@ -248,7 +248,7 @@ static int test2(struct evsel *evsel, struct machine *machine)
>  	field_order = "overhead,cpu";
>  	sort_order = "pid";
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  
>  	/*
>  	 * expected output:
> @@ -304,7 +304,7 @@ static int test3(struct evsel *evsel, struct machine *machine)
>  	field_order = "comm,overhead,dso";
>  	sort_order = NULL;
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  
>  	/*
>  	 * expected output:
> @@ -378,7 +378,7 @@ static int test4(struct evsel *evsel, struct machine *machine)
>  	field_order = "dso,sym,comm,overhead,dso";
>  	sort_order = "sym";
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  
>  	/*
>  	 * expected output:
> @@ -480,7 +480,7 @@ static int test5(struct evsel *evsel, struct machine *machine)
>  	field_order = "cpu,pid,comm,dso,sym";
>  	sort_order = "dso,pid";
>  
> -	setup_sorting(NULL);
> +	setup_sorting(/*evlist=*/NULL, machine->env);
>  
>  	/*
>  	 * expected output:
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 119bce37f4fd..3b97a31736c5 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -390,9 +390,6 @@ extern unsigned int proc_map_timeout;
>  #define PAGE_SIZE_NAME_LEN	32
>  char *get_page_size_name(u64 size, char *str);
>  
> -const char *arch_perf_header_entry(const char *se_header);
> -int arch_support_sort_key(const char *sort_key);
> -
>  static inline bool perf_event_header__cpumode_is_guest(u8 cpumode)
>  {
>  	return cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index dda4ef0b5a73..ccab10cd24a5 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2526,19 +2526,44 @@ struct sort_dimension {
>  	int			taken;
>  };
>  
> -int __weak arch_support_sort_key(const char *sort_key __maybe_unused)
> +static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
>  {
> +	const char *arch = perf_env__arch(env);
> +
> +	if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
> +		if (!strcmp(sort_key, "p_stage_cyc"))
> +			return 1;
> +		if (!strcmp(sort_key, "local_p_stage_cyc"))
> +			return 1;
> +	}
>  	return 0;
>  }
>  
> -const char * __weak arch_perf_header_entry(const char *se_header)
> -{
> +static const char *arch_perf_header_entry(const char *se_header, struct perf_env *env)
> +{
> +	const char *arch = perf_env__arch(env);
> +
> +	if (!strcmp("x86", arch)) {
> +		if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> +			return "Local Retire Latency";
> +		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
> +			return "Retire Latency";
> +	} else if (!strcmp("powerpc", arch)) {
> +		if (!strcmp(se_header, "Local INSTR Latency"))
> +			return "Finish Cyc";
> +		else if (!strcmp(se_header, "INSTR Latency"))
> +			return "Global Finish_cyc";
> +		else if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> +			return "Dispatch Cyc";
> +		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
> +			return "Global Dispatch_cyc";
> +	}
>  	return se_header;
>  }
>  
> -static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
> +static void sort_dimension_add_dynamic_header(struct sort_dimension *sd, struct perf_env *env)
>  {
> -	sd->entry->se_header = arch_perf_header_entry(sd->entry->se_header);
> +	sd->entry->se_header = arch_perf_header_entry(sd->entry->se_header, env);
>  }
>  
>  #define DIM(d, n, func) [d] = { .name = n, .entry = &(func) }
> @@ -3590,7 +3615,7 @@ int hpp_dimension__add_output(unsigned col, bool implicit)
>  }
>  
>  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> -			struct evlist *evlist,
> +			struct evlist *evlist, struct perf_env *env,
>  			int level)
>  {
>  	unsigned int i, j;
> @@ -3603,7 +3628,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>  	 */
>  	for (j = 0; j < ARRAY_SIZE(arch_specific_sort_keys); j++) {
>  		if (!strcmp(arch_specific_sort_keys[j], tok) &&
> -				!arch_support_sort_key(tok)) {
> +		    !arch_support_sort_key(tok, env)) {
>  			return 0;
>  		}
>  	}
> @@ -3616,7 +3641,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>  
>  		for (j = 0; j < ARRAY_SIZE(dynamic_headers); j++) {
>  			if (sd->name && !strcmp(dynamic_headers[j], sd->name))
> -				sort_dimension_add_dynamic_header(sd);
> +				sort_dimension_add_dynamic_header(sd, env);
>  		}
>  
>  		if (sd->entry == &sort_parent && parent_pattern) {
> @@ -3712,13 +3737,13 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>  }
>  
>  /* This should match with sort_dimension__add() above */
> -static bool is_hpp_sort_key(const char *key)
> +static bool is_hpp_sort_key(const char *key, struct perf_env *env)
>  {
>  	unsigned i;
>  
>  	for (i = 0; i < ARRAY_SIZE(arch_specific_sort_keys); i++) {
>  		if (!strcmp(arch_specific_sort_keys[i], key) &&
> -		    !arch_support_sort_key(key)) {
> +		    !arch_support_sort_key(key, env)) {
>  			return false;
>  		}
>  	}
> @@ -3740,7 +3765,7 @@ static bool is_hpp_sort_key(const char *key)
>  }
>  
>  static int setup_sort_list(struct perf_hpp_list *list, char *str,
> -			   struct evlist *evlist)
> +			   struct evlist *evlist, struct perf_env *env)
>  {
>  	char *tmp, *tok;
>  	int ret = 0;
> @@ -3769,7 +3794,7 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
>  		}
>  
>  		if (*tok) {
> -			if (is_hpp_sort_key(tok)) {
> +			if (is_hpp_sort_key(tok, env)) {
>  				/* keep output (hpp) sort keys in the same level */
>  				if (prev_was_hpp) {
>  					bool next_same = (level == next_level);
> @@ -3782,7 +3807,7 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
>  				prev_was_hpp = false;
>  			}
>  
> -			ret = sort_dimension__add(list, tok, evlist, level);
> +			ret = sort_dimension__add(list, tok, evlist, env, level);
>  			if (ret == -EINVAL) {
>  				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
>  					ui__error("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
> @@ -3911,7 +3936,7 @@ static char *setup_overhead(char *keys)
>  	return keys;
>  }
>  
> -static int __setup_sorting(struct evlist *evlist)
> +static int __setup_sorting(struct evlist *evlist, struct perf_env *env)
>  {
>  	char *str;
>  	const char *sort_keys;
> @@ -3951,7 +3976,7 @@ static int __setup_sorting(struct evlist *evlist)
>  		}
>  	}
>  
> -	ret = setup_sort_list(&perf_hpp_list, str, evlist);
> +	ret = setup_sort_list(&perf_hpp_list, str, evlist, env);
>  
>  	free(str);
>  	return ret;
> @@ -4187,16 +4212,16 @@ static int __setup_output_field(void)
>  	return ret;
>  }
>  
> -int setup_sorting(struct evlist *evlist)
> +int setup_sorting(struct evlist *evlist, struct perf_env *env)
>  {
>  	int err;
>  
> -	err = __setup_sorting(evlist);
> +	err = __setup_sorting(evlist, env);
>  	if (err < 0)
>  		return err;
>  
>  	if (parent_pattern != default_parent_pattern) {
> -		err = sort_dimension__add(&perf_hpp_list, "parent", evlist, -1);
> +		err = sort_dimension__add(&perf_hpp_list, "parent", evlist, env, -1);
>  		if (err < 0)
>  			return err;
>  	}
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index a742ab7f3c67..d7787958e06b 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -6,6 +6,7 @@
>  #include "hist.h"
>  
>  struct option;
> +struct perf_env;
>  
>  extern regex_t parent_regex;
>  extern const char *sort_order;
> @@ -130,7 +131,7 @@ extern struct sort_entry sort_thread;
>  
>  struct evlist;
>  struct tep_handle;
> -int setup_sorting(struct evlist *evlist);
> +int setup_sorting(struct evlist *evlist, struct perf_env *env);
>  int setup_output_field(void);
>  void reset_output_field(void);
>  void sort__setup_elide(FILE *fp);
> @@ -145,7 +146,7 @@ bool is_strict_order(const char *order);
>  int hpp_dimension__add_output(unsigned col, bool implicit);
>  void reset_dimensions(void);
>  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> -			struct evlist *evlist,
> +			struct evlist *evlist, struct perf_env *env,
>  			int level);
>  int output_field_add(struct perf_hpp_list *list, const char *tok, int *level);
>  int64_t

