Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516872628D;
	Wed,  4 Mar 2026 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587526; cv=none; b=UaamAv99EERHTcmh1KlYBQltwZyBfWI0sqCtEWvJvNrLisxwRhnqsr1XwctNU7SeaDUbvhPka/rqiEtXmqSWq+qgo3n3WkUjJwjCQ3Dvb+5Y8xCFb9UHAOZ4CawV5CveZGaS/n4xC+lm1C6AJk4ih4yHdySElJ0J/243HAKN+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587526; c=relaxed/simple;
	bh=BtL5MdUhSoH83DNKaYf/rfXosmFsYzlmvSICrhIy78s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0tbuqh3b/HkX8DTz9lAj+NpMfYG2gQP2BzyBXdV7LPSpjAiwb869vVhcfgmHlotf4DtIWGZBaEH+Qh77jKNs5+8tyNVn18kUkNOGJEjEJGaVW1LbZOvY92HQStW1apowG8+hWbypdFhQiOO9VKg5NO8q3u5kom+/t9/ckaXTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM0DbHbf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM0DbHbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902B5C116C6;
	Wed,  4 Mar 2026 01:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587525;
	bh=BtL5MdUhSoH83DNKaYf/rfXosmFsYzlmvSICrhIy78s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BM0DbHbfTDAK+wSeShWjakQk95czx78iTT25GqEpBe3zX/8e72aPk2dG1J+sCkV15
	 WEGdBmW+uredD7/vO0m12lZiuxUgTx3kkU2pbr6b89qNze/PQi0jwMQbKkDVlvi6Li
	 R0NZRguKPlqbjDVCcVfU6yauh4FCKUPcVqD7M2BGtnH9OFT+v6wFs8DLbwaFXCvBwz
	 6yRcZO1ESoyhnbAY5zsUxfUv+3Lw13/v8saw9PBU/xBPKKkv/JjSH4ez6R6rCCjYrP
	 wivz+ZKeHhWkXl/zPsfR/MDVfm4wB48ZuYHCkdb+jaJ3gI6IL5SO1GQM0yG8kNqhgB
	 En7nQccRhOsJw==
Date: Tue, 3 Mar 2026 17:25:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ricky Ringler <ricky.ringler@proton.me>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf utilities: cln_size header
Message-ID: <aaeKBOolC3AyHAFa@google.com>
References: <20260214040659.168769-2-ricky.ringler@proton.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260214040659.168769-2-ricky.ringler@proton.me>

Hello,

On Sat, Feb 14, 2026 at 04:07:25AM +0000, Ricky Ringler wrote:
> Store cacheline size during perf record in header, so
> that cacheline size can be used for other features, like
> sort.
> 
> Follow-up patch from message ID "aYZiQk6Uftzlb_JV@x1"
> 
>  Testing:
> - Built perf
> - Ran record + report with feat enabled
> - Ran record + report with feat disabled

Sorry for the delay.  Can you please rebase this on top of the current
perf-tools-next?  We added a couple more header features recently.

Thanks,
Namhyung

> 
> Tested-by: Ricky Ringler <ricky.ringler@proton.me>
> Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
> ---
>  tools/perf/builtin-inject.c |  1 +
>  tools/perf/util/env.h       |  1 +
>  tools/perf/util/header.c    | 29 +++++++++++++++++++++++++++++
>  tools/perf/util/header.h    |  1 +
>  tools/perf/util/sort.c      | 37 ++++++++++++++++++++++++++-----------
>  5 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index aa7be4fb5838..9639154459d9 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2047,6 +2047,7 @@ static bool keep_feat(int feat)
>  	case HEADER_CLOCK_DATA:
>  	case HEADER_HYBRID_TOPOLOGY:
>  	case HEADER_PMU_CAPS:
> +	case HEADER_CLN_SIZE:
>  		return true;
>  	/* Information that can be updated */
>  	case HEADER_BUILD_ID:
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 9977b85523a8..04580c64847b 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -93,6 +93,7 @@ struct perf_env {
>  	struct cpu_topology_map	*cpu;
>  	struct cpu_cache_level	*caches;
>  	int			 caches_cnt;
> +	unsigned int		cln_size;
>  	u32			comp_ratio;
>  	u32			comp_ver;
>  	u32			comp_type;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f5cad377c99e..ad15829acc69 100644
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
> @@ -1288,6 +1289,18 @@ static int write_cache(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +static int write_cln_size(struct feat_fd *ff,
> +		       struct evlist *evlist __maybe_unused)
> +{
> +	int cln_size = cacheline_size();
> +
> +	if (!cln_size)
> +		cln_size = 0;
> +	ff->ph->env.cln_size = cln_size;
> +
> +	return do_write(ff, &cln_size, sizeof(cln_size));
> +}
> +
>  static int write_stat(struct feat_fd *ff __maybe_unused,
>  		      struct evlist *evlist __maybe_unused)
>  {
> @@ -2084,6 +2097,11 @@ static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
>  	}
>  }
>  
> +static void print_cln_size(struct feat_fd *ff, FILE *fp __maybe_unused)
> +{
> +	fprintf(fp, "# cacheline size: %u\n", ff->ph->env.cln_size);
> +}
> +
>  static void print_compressed(struct feat_fd *ff, FILE *fp)
>  {
>  	fprintf(fp, "# compressed : %s, level = %d, ratio = %d\n",
> @@ -2933,6 +2951,16 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
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
> @@ -3453,6 +3481,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
>  	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
>  	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
> +	FEAT_OPR(CLN_SIZE,	cln_size,	false),
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index c058021c3150..04394331630f 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -53,6 +53,7 @@ enum {
>  	HEADER_CLOCK_DATA,
>  	HEADER_HYBRID_TOPOLOGY,
>  	HEADER_PMU_CAPS,
> +	HEADER_CLN_SIZE,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index aa79eb6476dd..e636b9f88e5c 100644
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
> @@ -2474,7 +2475,26 @@ struct sort_entry sort_type_offset = {
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
> +		if (evsel && evsel->evlist->session && evsel->evlist->session)
> +			ret = evsel->evlist->session->header.env.cln_size;
> +	}
> +
> +	if (!ret || ret < 1) {
> +		int default_cacheline_size = 64; // avoid div/0 later
> +
> +		ret = default_cacheline_size;
> +	}
> +
> +	return ret;
> +}
>  
>  static int64_t
>  sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
> @@ -2482,11 +2502,9 @@ sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
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
> @@ -2502,8 +2520,8 @@ sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
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
> @@ -2511,10 +2529,7 @@ static int hist_entry__typecln_snprintf(struct hist_entry *he, char *bf,
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
