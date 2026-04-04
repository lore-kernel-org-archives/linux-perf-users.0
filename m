Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CD27732;
	Sat,  4 Apr 2026 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262558; cv=none; b=CEIFKJJHpJFvSOZcbWNGAPAI0VgqCIiGeqVdcdERMrb6AT5rqqzLJUnMWyxsjpP7g/II5OS0QyYZVZw3DShl6m7gaKSGN+xzddANQ4iPNpkoAYAibmEx+wVqH3aizggmeNvVZFS3Cvj+TeoBQlgX1eJ/IXBnLqIaJSvSgKapf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262558; c=relaxed/simple;
	bh=0maWgxAGkF0hvMJ1x1s27Vo7/StJCbtnz5e+xMdAjp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl5MAeRIH+h4ZeRAF0LaYWHD7djWgep/n6QCj76bFORwObTi/TS0uUU6bCXGhz39AJ2L9nIZF6vHWzPir227/s3zQ6NXmdDtMPbvRsf+JVuEtpI+vgsfp7SLbZ/y40oN2HGKo7xnVUTCN5e6b7L97MYIbu47//uHktY3n2B3nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFPTp7+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFPTp7+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7CEC4CEF7;
	Sat,  4 Apr 2026 00:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775262558;
	bh=0maWgxAGkF0hvMJ1x1s27Vo7/StJCbtnz5e+xMdAjp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFPTp7+sKWwBV8M6SYTArNFcqUSCRdOjjK0nJLElePNSwMzHPA0UNKJwTzE9KZH2V
	 HfftauTjaaDamLCeLjTrj8w45Bin8QVjCW+eUbJG0QpMu3vZAi9rnC348JIZTWQ10I
	 ruVtQZbJQY2imaQjhIX/pxdtuW6NMP61CcVV2RQ3pxqcHbHfFAlfeaPF2oqizB+SYL
	 bipfd57hdKxk33VWo6ZUs1Q4JxE440SDhE3h8ao2q0fZH+HvDLnNZZb6rU9psCu4AN
	 qQAqEOco6zmuUZcGcFh6YuWLyMNRs2/s9Z6Jq5f06mR3s+ONPw5mhbYt3NfWPHLNUM
	 crLx39VHMosSg==
Date: Fri, 3 Apr 2026 17:29:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ricky Ringler <ricky.ringler@proton.me>
Cc: irogers@google.com, mingo@redhat.com, acme@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6] perf utilities: cln_size header
Message-ID: <adBbXHuhs6TlwJre@google.com>
References: <aaeKBOolC3AyHAFa@google.com>
 <20260305235655.40779-1-ricky.ringler@proton.me>
 <THyJLu3kRy_7q7V6-XpKu2hIZsSzkadNwnZ6YIOUSSTS2if2u3OWv6ROm_MtvBWVQVOJ03FVWw0POxzhU0LpeSBhoKSxTwKVV-JhZFJNCvg=@proton.me>
 <20260308172037.123654-1-ricky.ringler@proton.me>
 <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com>
 <20260321204145.26359-1-ricky.ringler@proton.me>
 <acW2j7hki-u50YYz@google.com>
 <20260328200442.134489-1-ricky.ringler@proton.me>
 <actrosC-vqhjMA-A@google.com>
 <20260403220758.41790-1-ricky.ringler@proton.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403220758.41790-1-ricky.ringler@proton.me>

On Fri, Apr 03, 2026 at 10:08:06PM +0000, Ricky Ringler wrote:
> Store cacheline size during perf record in header, so
> that cacheline size can be used for other features, like
> sort.
> 
> V6: Namhyung feedback and tests
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
> 
> Testing example with feat enabled:
> $ perf record ./Example
> $ perf report --header-only | grep -C 3 cacheline
> CPU_DOMAIN_INFO info available, use -I to display
> e_machine : 62
> e_flags : 0
> cacheline size: 64
> missing features: TRACING_DATA BUILD_ID BRANCH_STACK GROUP_DESC AUXTRACE \
> STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA
> ========
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

I'm curious how your compiler could build this.

> +
> +static int write_cln_size(struct feat_fd *ff,
> +		       struct evlist *evlist __maybe_unused)
> +{
> +	int cln_size = cacheline_size();
> +
> +
> +	if(!cln_size)
> +		cln_size = DEFAULT_CACHELINE_SIZE;

It should have a syntax error, right?

> +
> +	ff->ph->env.cln_size = cln_size;
> +
> +	return do_write(ff, &cln_size, sizeof(cln_size));
> +}
> +
>  static int write_stat(struct feat_fd *ff __maybe_unused,
>  		      struct evlist *evlist __maybe_unused)
>  {
[SNIP]
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

As I said in the previous comment, please use DEFAULT_CALLCHAIN_SIZE
here.

Thanks,
Namhyung

> +
> +		ret = default_cacheline_size;
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
