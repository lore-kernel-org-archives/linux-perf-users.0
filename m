Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63FB12B148;
	Tue,  4 Jun 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514330; cv=none; b=dsl8mlZm/KoAHRu/SCp69YZDYvS6F3cWFpowRp6U44bL0TbWGcB47cZrqHBdMTBRhsLYciTnxggbS88J6Xt0zc8BQPTY1HWz3smgR8lYKeX7BccGKmJSfNgSikEr8GKQTX+cw32Srvgilp5fsI2wPMXD6sEBeWU6H8676xFPSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514330; c=relaxed/simple;
	bh=byrbxIeFUv8qWRieFnQIoYcmf1QHDFVOAfsLUq8svpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK/u1F2OZ1koIoMAzfBVIHVvnWS9lON6g+TQ63iMfD8DfcZGXC55O/cTOSoozxv8u5GFVYGf1BpxAOosZ53NV+Maom580ufo6n8qKmx4JgvRO2a6sKbYBFSfUdizqs/Djvg1qEB5z5vc66Wvu94uCNF/ZayHu8ZnDkwkGGOgD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOnvISgi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOnvISgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1F9C2BBFC;
	Tue,  4 Jun 2024 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514330;
	bh=byrbxIeFUv8qWRieFnQIoYcmf1QHDFVOAfsLUq8svpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOnvISgipa8sPei/yu3VCtfmhHJoLFBLrLVKJbtOFCuqZHd8SjkdH1AyULTqsRhsb
	 CnO0oizgC628CRjLtDyd+ciqhOCDbv5s8inMCn0qUq89WXzz1wEZg5beAvZBShkw1T
	 R/U1U3NakpSaW6037Af5tInvV8vUUB3luOPFHTAUwUneu9qbFKujk4NYROApiDpPh8
	 UgPuL1cBSvxvgXIiunAg8MH7k/02u/2zyW+L8E9N5shV99Fuw8MaM2cTIHVzrUJC8+
	 Ol2bJrUsJnrADN7HxgaeuQLEue5m4AysrEcjEaqTvlwYnqN9I/Lo9fMottTFgp80xV
	 EvV9CtUvbqGmw==
Date: Tue, 4 Jun 2024 12:18:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf hist: Simplify __hpp_fmt() using hpp_fmt_data
Message-ID: <Zl8wVwNaKDXLTWbq@x1>
References: <20240603224412.1910049-1-namhyung@kernel.org>
 <20240603224412.1910049-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603224412.1910049-3-namhyung@kernel.org>

On Mon, Jun 03, 2024 at 03:44:10PM -0700, Namhyung Kim wrote:
> The struct hpp_fmt_data is to keep the values for each group members so
> it doesn't need to check the event index in the group.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/hist.c | 75 +++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index e30fcb1e87e7..539978c95cfd 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -46,65 +46,62 @@ static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
>  	return hpp__call_print_fn(hpp, print_fn, fmt, len, val);
>  }
>  
> +struct hpp_fmt_data {
> +	struct hists *hists;
> +	u64 val;
> +	int samples;
> +};

Can we try to avoid vague terms like 'data' and use a hopefully more
clear 'hpp_fmt_value' instead?

>  static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
>  		      hpp_field_fn get_field, const char *fmt, int len,
>  		      hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
>  {
> -	int ret;
> +	int ret = 0;
>  	struct hists *hists = he->hists;
>  	struct evsel *evsel = hists_to_evsel(hists);
> +	struct evsel *pos;
>  	char *buf = hpp->buf;
>  	size_t size = hpp->size;
> +	int i, nr_members = 1;
> +	struct hpp_fmt_data *data;

Here we then use:

	struct hpp_fmt_value *values;

> +
> +	if (evsel__is_group_event(evsel))
> +		nr_members = evsel->core.nr_members;
> +
> +	data = calloc(nr_members, sizeof(*data));
> +	if (data == NULL)
> +		return 0;


> +
> +	i = 0;
> +	for_each_group_evsel(pos, evsel)
> +		data[i++].hists = evsel__hists(pos);
>  
> -	ret = __hpp__fmt_print(hpp, hists, get_field(he), he->stat.nr_events,
> -			       fmt, len, print_fn, fmtype);
> +	data[0].val = get_field(he);
> +	data[0].samples = he->stat.nr_events;
>  
>  	if (evsel__is_group_event(evsel)) {
> -		int prev_idx, idx_delta;
>  		struct hist_entry *pair;
> -		int nr_members = evsel->core.nr_members;
> -
> -		prev_idx = evsel__group_idx(evsel);
>  
>  		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
> -			u64 period = get_field(pair);
> -			u64 total = hists__total_period(pair->hists);
> -			int nr_samples = pair->stat.nr_events;
> -
> -			if (!total)
> -				continue;
> +			for (i = 0; i < nr_members; i++) {
> +				if (data[i].hists != pair->hists)
> +					continue;
>  
> -			evsel = hists_to_evsel(pair->hists);
> -			idx_delta = evsel__group_idx(evsel) - prev_idx - 1;
> -
> -			while (idx_delta--) {
> -				/*
> -				 * zero-fill group members in the middle which have
> -				 * no samples, pair->hists is not correct but it's
> -				 * fine since the value is 0.
> -				 */
> -				ret += __hpp__fmt_print(hpp, pair->hists, 0, 0,
> -							fmt, len, print_fn, fmtype);
> +				data[i].val = get_field(pair);
> +				data[i].samples = pair->stat.nr_events;
> +				break;
>  			}
> -
> -			ret += __hpp__fmt_print(hpp, pair->hists, period, nr_samples,
> -						fmt, len, print_fn, fmtype);
> -
> -			prev_idx = evsel__group_idx(evsel);
>  		}
> +	}
>  
> -		idx_delta = nr_members - prev_idx - 1;
> -
> -		while (idx_delta--) {
> -			/*
> -			 * zero-fill group members at last which have no sample.
> -			 * the hists is not correct but it's fine like above.
> -			 */
> -			ret += __hpp__fmt_print(hpp, evsel__hists(evsel), 0, 0,
> -						fmt, len, print_fn, fmtype);
> -		}
> +	for (i = 0; i < nr_members; i++) {
> +		ret += __hpp__fmt_print(hpp, data[i].hists, data[i].val,
> +					data[i].samples, fmt, len,
> +					print_fn, fmtype);
>  	}
>  
> +	free(data);
> +
>  	/*
>  	 * Restore original buf and size as it's where caller expects
>  	 * the result will be saved.
> -- 
> 2.45.1.288.g0e0cd299f1-goog
