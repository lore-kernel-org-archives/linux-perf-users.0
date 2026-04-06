Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019B2D0620;
	Mon,  6 Apr 2026 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775453162; cv=none; b=EXMSViaNkYbehlwuoyViRgzTueO/Jnc0b4IfQcZNHv7ubOFt8YNbV44brtRIBAgmrXd2whIK5rqAfvuSMfcfbggrK8PRhaD1fHGJNBxZPwCecoRSINuoocquWCcSAIPIUUatjw31zz6BGdgXY4GxQEpf8LfsTTom6eVfn2dBGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775453162; c=relaxed/simple;
	bh=C/XvBpdsnZx0OtQ+6roawjIykjIdvM1xS0YeJo1zRro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfgFcElzStICzVs2lYWfc+4uX+DLzl3ID5xCEud8F0Jv6ywkrAV+4wbXtMJd4HGE+NEVci+ZEqIZGhHScCAkAq659tHVqKAOb2npVmn0XAru0OxfmbYzNX/DCBsxzzwuLcUusN1+ixFoJMVRK+HRLstoctiqFzHacFea7aag0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/mP3Ro/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/mP3Ro/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42990C4CEF7;
	Mon,  6 Apr 2026 05:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775453162;
	bh=C/XvBpdsnZx0OtQ+6roawjIykjIdvM1xS0YeJo1zRro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/mP3Ro/PQypdzLTiZ2pGUBi7VXPXxG7ZYZi40sQ/2PpwuZ/0QUCIxXEMW5nJvonR
	 /TZDQdJ/Vj+004r6IBkuJh/tC6RdJ4XTKQJONs0ffXaDcmXVD7BNes9SVj1KewmwsX
	 fM7utGC38ed8sqk6/nP8J/OJ/Y/zaCP96BCrsO6SZM4op58GkJyM/eNanpvtKl1Ew2
	 Ro7aL4lTV5/tNdFiZCyLJSKXEAC8WuS4xsU1BRfCa3eFN1+vwyCMm8tSQ10R0tkMxy
	 1vBP3AoiPdlXx8FTMekmEntLBV2B3YvCPv1+JEKRU6p5svcni4/0fFIVkphnPZ5LOu
	 3W1rPLZSP+8vg==
Date: Sun, 5 Apr 2026 22:26:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ricky Ringler <ricky.ringler@proton.me>
Cc: irogers@google.com, mingo@redhat.com, acme@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6] perf utilities: cln_size header
Message-ID: <adND6AGUKu8d0YlO@google.com>
References: <aaeKBOolC3AyHAFa@google.com>
 <20260308172037.123654-1-ricky.ringler@proton.me>
 <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com>
 <20260321204145.26359-1-ricky.ringler@proton.me>
 <acW2j7hki-u50YYz@google.com>
 <20260328200442.134489-1-ricky.ringler@proton.me>
 <actrosC-vqhjMA-A@google.com>
 <20260403220758.41790-1-ricky.ringler@proton.me>
 <adBbXHuhs6TlwJre@google.com>
 <20260404011313.51901-4-ricky.ringler@proton.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260404011313.51901-4-ricky.ringler@proton.me>

On Sat, Apr 04, 2026 at 01:16:56AM +0000, Ricky Ringler wrote:
> Forgive me for wasting your time with my last message...
> I switched work machines and attached the wrong patch file.

That's fine but you could send it as v7 so that the tools can pick the
latest version without confusion.

> 
> ---

Also, adding this mark invalidates the following paragraphs and leave
them out from the commit message..  I'll update it this time but keep
that in mind for the next time.

Thanks,
Namhyung

> 
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
>  tools/perf/util/header.c    | 31 ++++++++++++++++++++++++++++++
>  tools/perf/util/header.h    |  3 +++
>  tools/perf/util/sort.c      | 38 ++++++++++++++++++++++++++-----------
>  5 files changed, 63 insertions(+), 11 deletions(-)
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
> index 9142a8ba4019..2a2c64b1a384 100644
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
> @@ -1304,6 +1305,20 @@ static int write_cache(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +static int write_cln_size(struct feat_fd *ff,
> +		       struct evlist *evlist __maybe_unused)
> +{
> +	int cln_size = cacheline_size();
> +
> +
> +	if (!cln_size)
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
> @@ -2261,6 +2276,11 @@ static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
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
> @@ -3154,6 +3174,16 @@ static int process_cache(struct feat_fd *ff, void *data __maybe_unused)
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
> @@ -3763,6 +3793,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
>  	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
>  	FEAT_OPR(E_MACHINE,	e_machine,	false),
> +	FEAT_OPR(CLN_SIZE,	cln_size,	false),
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index cc40ac796f52..8429e856fd7c 100644
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
> @@ -202,6 +203,8 @@ int write_padded(struct feat_fd *fd, const void *bf,
>  
>  int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cntp);
>  
> +#define DEFAULT_CACHELINE_SIZE 64
> +
>  /*
>   * arch specific callback
>   */
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 42d5cd7ef4e2..50eb58837b10 100644
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
> @@ -2474,7 +2475,27 @@ struct sort_entry sort_type_offset = {
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
> +	if (!ret || ret < 1)
> +		ret = DEFAULT_CACHELINE_SIZE; // avoid div/0 later
> +
> +	return ret;
> +}
>  
>  static int64_t
>  sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
> @@ -2482,11 +2503,9 @@ sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
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
> @@ -2502,8 +2521,8 @@ sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
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
> @@ -2511,10 +2530,7 @@ static int hist_entry__typecln_snprintf(struct hist_entry *he, char *bf,
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
