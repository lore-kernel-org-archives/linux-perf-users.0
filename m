Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5719D087
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922052; cv=none; b=GNOUhe7h0eJUjHzLsFKC4ZpsDo6bnrbN71mwfrSUG4Sy5VAfm/bd3+gs4F2LxGG1c9VHjOrFMA84w40dWoA0MQgkYfHHCJuggsKoIhufOZUuaru6NeZP49NEwp1MaMNDkTzlPGzveBPFmtKk+AoUP4Qq9vUe+iUeoOzHTDFmnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922052; c=relaxed/simple;
	bh=6FA/Hz2IOxyxB+YAJ+TvHhJprzTOSm8EJrNzBWhE/wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NZ6Cok0Tba9K8soiSnnA9PYWq2yV37SLLd6dd+dDvDe8VeKnaVBrzN9bXXoBVSxVJl+9Wi6n031Jh18VwbtVEqyskDegK8++I+b9nxRDWoCcyT9fEg8EIW0Y8TXfLrF0AxwvSqeq4X7K8+b8P0E3yGd96edB37cXcKouev3v+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPzY0auQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPzY0auQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721922051; x=1753458051;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6FA/Hz2IOxyxB+YAJ+TvHhJprzTOSm8EJrNzBWhE/wk=;
  b=iPzY0auQ8fbXRPaqAUa5cwSztpm77M+8+AOip3ohrDbiDcHE0f7EgJBs
   JwHBB0KwphUlbQRMzHPaj7boln1X1zoU4spAf4aqxYvY3eh0pcxLMbBmz
   /+qrct24ScTw/fBCavO6YE6b9mqiqKbANUpxuHgKwrELmfyqZGzmhxCtj
   5EqklpYmsMzM2tsT2+7yWU4fmzSSp0hliFv0rt4HjvpyWCqKjm7UOH3SN
   5OCgrrahG4tw+DlKkJvX1Vj3dG28z/sTGGs9Os48E1d3VVqnbGzHzexat
   D8Gm1u8ZpEl96cJFZo1DeCzBRIOyrcESVjC+MfTQHNYV4ATkgburA+1PI
   g==;
X-CSE-ConnectionGUID: Q+CdhlMIR7OgBkBfqqSlkg==
X-CSE-MsgGUID: V9vNdksxRQeeJjBY9PNVWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19365686"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19365686"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 08:40:50 -0700
X-CSE-ConnectionGUID: /9+/813LQxWeBTfT78Hnvg==
X-CSE-MsgGUID: tKYekonTTfG6dW71gLSa1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="52893088"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 08:40:46 -0700
Message-ID: <bb8e5202-bffa-4cd6-b49c-6372d51b405b@intel.com>
Date: Thu, 25 Jul 2024 18:40:40 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] perf auxtrace: Iterate all AUX events when finish
 reading
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org
References: <20240725064620.1651819-1-leo.yan@arm.com>
 <20240725064620.1651819-2-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240725064620.1651819-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/24 09:46, Leo Yan wrote:
> When finished to read AUX trace data from mmaped buffer, based on the

Here and elsewhere 'mmapped' is more common than 'mmaped' so maybe:

	mmaped -> mmapped

> AUX buffer index the core layer needs to search the corresponding PMU
> event and re-enable it to continue tracing.
> 
> However, current code only searches the first AUX event. It misses to
> search other enabled AUX events, thus, it returns failure if the buffer
> index does not belong to the first AUX event.
> 
> This patch extends the auxtrace_record__read_finish() function to
> search for every enabled AUX events, so all the mmaped buffer indexes
> can be covered.

Looking at this again, a couple more things came to mind - see below.

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/auxtrace.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index b99e72f7da88..61835a6a9ea3 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -670,18 +670,33 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>  int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>  {
>  	struct evsel *evsel;
> +	int ret = -EINVAL;
>  
> -	if (!itr->evlist || !itr->pmu)
> +	if (!itr->evlist)
>  		return -EINVAL;
>  
>  	evlist__for_each_entry(itr->evlist, evsel) {
> -		if (evsel->core.attr.type == itr->pmu->type) {
> +		if (evsel__is_aux_event(evsel)) {
>  			if (evsel->disabled)
> -				return 0;
> -			return evlist__enable_event_idx(itr->evlist, evsel, idx);
> +				continue;

That will make the evsel->disabled case an error, which
might be a problem. Possibly the event can be disabled
(e.g. via control fifo) but still have data to read out.

> +			/*
> +			 * Multiple AUX events might be opened in a session.
> +			 * Bail out for success case as the AUX event has been
> +			 * found and enabled, otherwise, continue to check if
> +			 * the next AUX event can cover the mmaped buffer with
> +			 * 'idx'.
> +			 */

Thinking about this some more, raised some questions:

How do we know there is only one AUX event per mmap?  They
would have to be on different CPUs for that to be true?
And wouldn't --per-thread have all AUX events in every mmap?

> +			ret = evlist__enable_event_idx(itr->evlist, evsel, idx);
> +			if (ret >= 0)
> +				return ret;
>  		}
>  	}
> -	return -EINVAL;
> +
> +	/* Failed to find an event for the buffer 'idx' */
> +	if (ret < 0)
> +		pr_err("Failed to enable event (idx=%d): %d\n", idx, ret);
> +
> +	return ret;
>  }
>  
>  /*

