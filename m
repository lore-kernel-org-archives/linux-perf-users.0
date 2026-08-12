Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DAD3B4417;
	Wed, 12 Aug 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523173; cv=none; b=OEDRl/qVCbvnFvuawZdELLCsZXyFgX9+yHowBhlxxDN3QdeC/z1zIcFuD3UMQi6E6pJ4zyyVZDf1ztfpkpy2tHBeBGmxYoWOn6eDh1Rc47Yjhy1DqbJB6BDt7gdO+bkR2fVbJakWHAB1Al0zfY5kbRU5LwJnKIwBmm//7e/5A7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523173; c=relaxed/simple;
	bh=oaLbF35DHy6IhNBf9j9hiMWp86jIwz8Ea/jbUMDaiis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUvMR2RIznbPN1vdZYzndpW2OgiafMmnG8EKikjj/dfaYimbVGPyPtWEHnqub6I/IMIz4LXc68E9aw/KORp+O8wrHbM86uh7KsosvBBpqYsJpn4KCX3V7ivyBIoM6aHG4vY6qbp8LSHBjJfBYwmIR6u1Ml3THifVWDYyZIhWSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpTJDg1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpTJDg1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE651F000E9;
	Wed, 12 Aug 2026 08:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786523171;
	bh=1X1kkoTddoCzi/2L4V1KM/IpyHDQIDecWiZWZ7C52oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MpTJDg1etAV3WYFbEjiBE6FcttPoYEZZUBXT1Phx9WumaudEuPpCvOLc5KdU9o+hk
	 zXTyli8t5TpNAin1+sNXE53nagWdtiFqdGtF7n2Ph1SzVz9w+SlDE6OG8HRBOjHPjo
	 C0ynPE0qXyRDKCTTtHuUxchLFPtZb7/wb+Wcw9VLIm2nFNNGysWTcXcWjsskVqR7ks
	 MhxOP56F3oipIOK+P2XvGC2AAR6GY0hc2IdFrjWPunNZ67u6NYEFM9k5dM1NQE1GL+
	 bxeXUqxFn2QQrSBzkKED0m2o4yy49flXiHjlpnw9KkQPACbVzAp5IKiFt7jcx7v25v
	 7LRpzUIWlDqaQ==
Date: Wed, 12 Aug 2026 17:26:06 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/9] perf c2c: add function view browser skeleton
Message-ID: <anwuHmiI7DCOCm4T@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
 <20260810052647.588867-3-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810052647.588867-3-jiebin.sun@intel.com>

On Mon, Aug 10, 2026 at 01:26:40PM +0800, Jiebin Sun wrote:
> Introduce the TUI entry point for the c2c function view and connect it to
> the cacheline browser through the TAB key. Add the browser object, its
> Build entry, the public declaration, and the corresponding help text.
> Later patches fill in the browser implementation.
> 
> The browser needs the cacheline histograms, the --coalesce field list,
> symbol_full, and the cacheline detail entry point. Pass them through
> struct c2c_function_view_args instead of referencing builtin-c2c.c state
> directly. This keeps c2c-function.o free of command-private references, so
> it can remain in libperf-ui.a even though that archive is also linked into
> python/perf.so without the builtin command objects.
> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> ---
>  tools/perf/builtin-c2c.c              | 10 ++++
>  tools/perf/ui/browsers/Build          |  1 +
>  tools/perf/ui/browsers/c2c-function.c | 81 +++++++++++++++++++++++++++
>  tools/perf/util/c2c.h                 | 30 ++++++++++
>  4 files changed, 122 insertions(+)
>  create mode 100644 tools/perf/ui/browsers/c2c-function.c
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 16b00a36fdfc..715b75d42f2a 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2745,11 +2745,18 @@ perf_c2c_browser__new(struct hists *hists)
>  
>  static int perf_c2c__hists_browse(struct hists *hists)
>  {
> +	struct c2c_function_view_args func_args = {
> +		.cl_hists	  = &c2c.hists,
> +		.cl_sort	  = c2c.cl_sort,
> +		.symbol_full	  = c2c.symbol_full,
> +		.browse_cacheline = perf_c2c__browse_cacheline,
> +	};
>  	struct hist_browser *browser;
>  	int key = -1;
>  	static const char help[] =
>  	" d             Display cacheline details \n"
>  	" ENTER         Toggle callchains (if present) \n"
> +	" TAB           Switch to function view\n"
>  	" q             Quit \n";
>  
>  	browser = perf_c2c_browser__new(hists);
> @@ -2771,6 +2778,9 @@ static int perf_c2c__hists_browse(struct hists *hists)
>  		case 'd':
>  			perf_c2c__browse_cacheline(browser->he_selection);
>  			break;
> +		case '\t':
> +			perf_c2c__browse_function_view(&func_args);
> +			break;
>  		case '?':
>  			ui_browser__help_window(&browser->b, help);
>  			break;
> diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
> index a07489e44765..ae67a2161f7d 100644
> --- a/tools/perf/ui/browsers/Build
> +++ b/tools/perf/ui/browsers/Build
> @@ -5,3 +5,4 @@ perf-ui-y += map.o
>  perf-ui-y += scripts.o
>  perf-ui-y += header.o
>  perf-ui-y += res_sample.o
> +perf-ui-y += c2c-function.o
> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
> new file mode 100644
> index 000000000000..387175a9a90c
> --- /dev/null
> +++ b/tools/perf/ui/browsers/c2c-function.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C2C Function Browser - function-level cacheline sharing analysis
> + *
> + * Displays a 3-level hierarchy showing which functions share cachelines:
> + *   Level 1: Read-side functions sorted by Cycles % (estimated load cycles)
> + *   Level 2: Functions sampled writing the shared lines read by level 1
> + *   Level 3: The specific cachelines where the two functions contend
> + *
> + * Builds the hierarchy from the existing cacheline histograms
> + * (c2c_hist_entry->hists), reusing the shared c2c data structures.
> + */
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <tools/libc_compat.h> /* reallocarray */
> +#include <asm/bug.h>
> +#include <linux/list.h>
> +#include <linux/rbtree.h>
> +#include <linux/zalloc.h>
> +
> +#include "../browser.h"
> +#include "../keysyms.h"
> +#include "../libslang.h"
> +#include "../ui.h"
> +#include "../../util/addr_location.h"
> +#include "../../util/cacheline.h"
> +#include "../../util/debug.h"
> +#include "../../util/hist.h"
> +#include "../../util/map.h"
> +#include "../../util/mem-events.h"
> +#include "../../util/mem-info.h"
> +#include "../../util/sort.h"
> +#include "../../util/symbol.h"
> +#include "../../util/thread.h"
> +#include "../../util/c2c.h"
> +#include "hists.h"
> +
> +struct perf_c2c_ext {
> +	struct c2c_hists	function_hists;
> +	/* Total estimated cycles across all level-1 entries. */
> +	u64			total_cycles;
> +	/* What the c2c command passed in; not owned here. */
> +	struct c2c_function_view_args *args;
> +};
> +
> +static struct perf_c2c_ext c2c_ext __maybe_unused;
> +
> +struct c2c_function_browser {
> +	struct hist_browser	hb;
> +};
> +
> +static inline __maybe_unused u64 c2c_hitm_count(const struct c2c_stats *stats)
> +{
> +	return stats->tot_hitm;
> +}
> +
> +static inline __maybe_unused bool symbol_name_equal(struct symbol *a, struct symbol *b)
> +{
> +	/* Two unknown symbols compare equal, matching cmp_null() in util/sort.c. */
> +	if (!a || !b)
> +		return a == b;
> +	return arch__compare_symbol_names(a->name, b->name) == 0;
> +}
> +
> +static inline __maybe_unused u64 hist_entry__iaddr(struct hist_entry *he)
> +{
> +	if (he->mem_info)
> +		return mem_info__iaddr(he->mem_info)->addr;
> +	return he->ip;
> +}

Considering function view in stdio, wouldn't it be better to move the
common code to util/c2c.c instead?

Thanks,
Namhyung

> +
> +int perf_c2c__browse_function_view(struct c2c_function_view_args *args)
> +{
> +	c2c_ext.args = args;
> +
> +	ui__warning("C2C function view is not implemented yet.\n");
> +	return 0;
> +}
> diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
> index bd0c9d1c9a1a..a80be07eaa83 100644
> --- a/tools/perf/util/c2c.h
> +++ b/tools/perf/util/c2c.h
> @@ -98,4 +98,34 @@ struct c2c_fmt {
>  void c2c_fmt_free(struct perf_hpp_fmt *fmt);
>  bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
>  
> +/*
> + * Everything the function view browser needs from the c2c command, passed in
> + * by the caller so the browser does not reference command-private state.
> + */
> +struct c2c_function_view_args {
> +	/* Source cacheline histograms to build the hierarchy from. */
> +	struct c2c_hists	*cl_hists;
> +	/* --coalesce field list, used to require iaddr. */
> +	const char		*cl_sort;
> +	/* Do not cap long symbol names. */
> +	bool			 symbol_full;
> +	/* Open the cacheline detail view for @he. */
> +	int			(*browse_cacheline)(struct hist_entry *he);
> +};
> +
> +/*
> + * The TUI browser is only built with SLANG support. The stub below keeps the
> + * header self-contained for NO_SLANG builds, as util/hist.h does for its own
> + * TUI entry points.
> + */
> +#ifdef HAVE_SLANG_SUPPORT
> +int perf_c2c__browse_function_view(struct c2c_function_view_args *args);
> +#else
> +static inline int
> +perf_c2c__browse_function_view(struct c2c_function_view_args *args __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* __PERF_UTIL_C2C_H */
> -- 
> 2.52.0
> 
