Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE637B3F7;
	Tue, 31 Mar 2026 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939045; cv=none; b=WKQUj8CDVrHJxzN1fp9Moaqrg4mmPrqnze7Crgy3CZoJhUnqnvJtS0BKKZYarBrHnOnvIEFQkSDTLnyscoSBdG3a4Guy5vbEisv3tx1P+k/SOPXEO2fkNM8w1MrmecJncpNBxXO7z+LZoOBsWJO/GOqcjC0d4FzcOSu8ynLsJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939045; c=relaxed/simple;
	bh=s5G2a2lUi8bH16HJBrGmtUceH8I34cSUXiwRTLXJ/s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jugoVvYOM7ANWEtW6UsJnc0w6PpOIQXx9Pe9AcrG14sLE/Ga0am1mgth2BhpHpTTENfVqAoiM+hs+lYiJvjeuQ4OYfZkXM6XmgeAzLbmgg31vGYLxtZRUgFf3Vj2BQgeMazsDOcnj6Cg+vSqjWCJiQeb6XZxGuVbqDRWi+5mDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjW6mSIQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjW6mSIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFCFC19423;
	Tue, 31 Mar 2026 06:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774939044;
	bh=s5G2a2lUi8bH16HJBrGmtUceH8I34cSUXiwRTLXJ/s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjW6mSIQMr0vbqAARajtfLh4crPcW3yboWWnUkcVopc/mgeAIsz4Vq72uk266D7mi
	 h3VP6mmJ4UyAjU3fjQlu9vkYiMZeFKGSE8rgQW29xVhdoaxESew/+LXyiH1D1qYaWH
	 DeL369aNgTkugi7XsCBgvtT6z9SGZOJM6Scxt4tvw1IsuOSciGEX3F1LWhNoaoDV92
	 wFd+W2MBuHBAofNmsp3v6+WkXzviF8nj6vmLqYBRVou59a+l71jPJWtxvRTWuE3MOJ
	 72+/5J3DAGhaQ1oVbsZwAYeAGWtMdjkbdjiNFu1Rm+ilZ/jSLPdv9ygsW84c5b5rNC
	 DvNp0qyt8O7Ng==
Date: Mon, 30 Mar 2026 23:37:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ricky Ringler <ricky.ringler@proton.me>
Cc: irogers@google.com, mingo@redhat.com, acme@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5] perf utilities: cln_size header
Message-ID: <actrosC-vqhjMA-A@google.com>
References: <20260214040659.168769-2-ricky.ringler@proton.me>
 <aaeKBOolC3AyHAFa@google.com>
 <20260305235655.40779-1-ricky.ringler@proton.me>
 <THyJLu3kRy_7q7V6-XpKu2hIZsSzkadNwnZ6YIOUSSTS2if2u3OWv6ROm_MtvBWVQVOJ03FVWw0POxzhU0LpeSBhoKSxTwKVV-JhZFJNCvg=@proton.me>
 <20260308172037.123654-1-ricky.ringler@proton.me>
 <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com>
 <20260321204145.26359-1-ricky.ringler@proton.me>
 <acW2j7hki-u50YYz@google.com>
 <20260328200442.134489-1-ricky.ringler@proton.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260328200442.134489-1-ricky.ringler@proton.me>

On Sat, Mar 28, 2026 at 08:04:52PM +0000, Ricky Ringler wrote:
> Store cacheline size during perf record in header, so
> that cacheline size can be used for other features, like
> sort.
> 
> V5: Namhyung feedback
> V4: Ian feedback
> V3: Rebase off perf-tools-next round two
> V2: Rebase off perf-tools-next
> 
> Follow-up patch from message ID "aYZiQk6Uftzlb_JV@x1"
> 
> Testing:
> - Built perf
> - Ran record + report with feat enabled
> - Ran record + report with feat disabled

It'd be nice if you can add an example output like:

  $ perf report --header-only | grep cacheline

> 
> Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
> ---
>  tools/perf/builtin-inject.c |  1 +
>  tools/perf/util/env.h       |  1 +
>  tools/perf/util/header.c    | 33 +++++++++++++++++++++++++++++
>  tools/perf/util/header.h    |  1 +
>  tools/perf/util/sort.c      | 41 +++++++++++++++++++++++++++----------
>  5 files changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5b29f4296861..11ac7c8c4be3 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2134,6 +2134,7 @@ static bool keep_feat(struct perf_inject *inject, int feat)
>  	case HEADER_HYBRID_TOPOLOGY:
>  	case HEADER_PMU_CAPS:
>  	case HEADER_CPU_DOMAIN_INFO:
> +	case HEADER_CLN_SIZE:
>  		return true;
>  	/* Information that can be updated */
>  	case HEADER_BUILD_ID:
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index a4501cbca375..c7052ac1f856 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -112,6 +112,7 @@ struct perf_env {
>  	struct cpu_cache_level	*caches;
>  	struct cpu_domain_map	**cpu_domain;
>  	int			 caches_cnt;
> +	unsigned int		cln_size;
>  	u32			comp_ratio;
>  	u32			comp_ver;
>  	u32			comp_type;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 9142a8ba4019..4d852bd4ca9a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -54,6 +54,7 @@
>  #include "bpf-event.h"
>  #include "bpf-utils.h"
>  #include "clockid.h"
> +#include "cacheline.h"
>  
>  #include <linux/ctype.h>
>  #include <internal/lib.h>
> @@ -1304,6 +1305,22 @@ static int write_cache(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +#define DEFAULT_CACHELINE_SIZE = 64

Please move this into a header (after removing '=') ...

> +
> +static int write_cln_size(struct feat_fd *ff,
> +		       struct evlist *evlist __maybe_unused)
> +{
> +	int cln_size = cacheline_size();
> +
> +
> +	if(!cln_size)
> +		cln_size = DEFAULT_CACHELINE_SIZE;
> +
> +	ff->ph->env.cln_size = cln_size;
> +
> +	return do_write(ff, &cln_size, sizeof(cln_size));
> +}
> +
>  static int write_stat(struct feat_fd *ff __maybe_unused,
>  		      struct evlist *evlist __maybe_unused)
>  {
> @@ -2261,6 +2278,11 @@ static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
>  	}
>  }
>  
> +static void print_cln_size(struct feat_fd *ff, FILE *fp)
> +{
> +	fprintf(fp, "# cacheline size: %u\n", ff->ph->env.cln_size);
> +}
> +
>  static void print_compressed(struct feat_fd *ff, FILE *fp)
>  {
>  	fprintf(fp, "# compressed : %s, level = %d, ratio = %d\n",
> @@ -3154,6 +3176,16 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
>  	return -1;
>  }
>  
> +static int process_cln_size(struct feat_fd *ff, void *data __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +
> +	if (do_read_u32(ff, &env->cln_size))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int process_sample_time(struct feat_fd *ff, void *data __maybe_unused)
>  {
>  	struct perf_session *session;
> @@ -3763,6 +3795,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
>  	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
>  	FEAT_OPR(E_MACHINE,	e_machine,	false),
> +	FEAT_OPR(CLN_SIZE,	cln_size,	false),
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index cc40ac796f52..be315040727f 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -55,6 +55,7 @@ enum {
>  	HEADER_PMU_CAPS,
>  	HEADER_CPU_DOMAIN_INFO,
>  	HEADER_E_MACHINE,
> +	HEADER_CLN_SIZE,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 42d5cd7ef4e2..5f617cf03d5d 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -30,6 +30,7 @@
>  #include "time-utils.h"
>  #include "cgroup.h"
>  #include "machine.h"
> +#include "session.h"
>  #include "trace-event.h"
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> @@ -2474,7 +2475,30 @@ struct sort_entry sort_type_offset = {
>  
>  /* --sort typecln */
>  
> -#define DEFAULT_CACHELINE_SIZE 64
> +static int
> +hist_entry__cln_size(struct hist_entry *he)
> +{
> +	int ret = 0;
> +
> +	if (he && he->hists) {
> +		struct evsel *evsel = hists_to_evsel(he->hists);
> +
> +
> +		if (evsel) {
> +			struct perf_session *session = evsel__session(evsel);
> +
> +			ret = session->header.env.cln_size;
> +		}
> +	}
> +
> +	if (!ret || ret < 1) {
> +		int default_cacheline_size = 64; // avoid div/0 later
> +
> +		ret = default_cacheline_size;

... and use it here as well.

Thanks,
Namhyung


> +	}
> +
> +	return ret;
> +}
>  
>  static int64_t
>  sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
> @@ -2482,11 +2506,9 @@ sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
>  	struct annotated_data_type *left_type = left->mem_type;
>  	struct annotated_data_type *right_type = right->mem_type;
>  	int64_t left_cln, right_cln;
> +	int64_t cln_size_left = hist_entry__cln_size(left);
> +	int64_t cln_size_right = hist_entry__cln_size(right);
>  	int64_t ret;
> -	int cln_size = cacheline_size();
> -
> -	if (cln_size == 0)
> -		cln_size = DEFAULT_CACHELINE_SIZE;
>  
>  	if (!left_type) {
>  		sort__type_init(left);
> @@ -2502,8 +2524,8 @@ sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
>  	if (ret)
>  		return ret;
>  
> -	left_cln = left->mem_type_off / cln_size;
> -	right_cln = right->mem_type_off / cln_size;
> +	left_cln = left->mem_type_off / cln_size_left;
> +	right_cln = right->mem_type_off / cln_size_right;
>  	return left_cln - right_cln;
>  }
>  
> @@ -2511,10 +2533,7 @@ static int hist_entry__typecln_snprintf(struct hist_entry *he, char *bf,
>  				     size_t size, unsigned int width __maybe_unused)
>  {
>  	struct annotated_data_type *he_type = he->mem_type;
> -	int cln_size = cacheline_size();
> -
> -	if (cln_size == 0)
> -		cln_size = DEFAULT_CACHELINE_SIZE;
> +	int cln_size = hist_entry__cln_size(he);
>  
>  	return repsep_snprintf(bf, size, "%s: cache-line %d", he_type->self.type_name,
>  			       he->mem_type_off / cln_size);
> -- 
> 2.53.0
> 
> 
