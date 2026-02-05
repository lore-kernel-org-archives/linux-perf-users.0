Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B61FECBA;
	Thu,  5 Feb 2026 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298942; cv=none; b=afaU1Vl/eo9C/oLgkxaDwD/w+I9fovNewDldfrL/4Raw/KSfIKxR9WLDK0Jc6hnOLpf2DAkmj2kwUmRVhgiqrQFpzGeHlaJqbOMOEPvnUh+CXZVGX+ekVnvSNQN/q6EF/vEuabxxS078/gaRPgngDq+Ox5MXGnsE4CF/DTOqScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298942; c=relaxed/simple;
	bh=aqrGt2c2wdFNXADSCpd5Wk0KBrGd5ptYraTvAQ5XafQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AishhYTYIDq0axdYIPsuJ9byIKWSmPay4TmamJCPvaXv59fJZnhB7p3pkoG/EQWqP8/NgHbRpcIKCG2QhRS0uQs+UlRRMCDU4KvI3QrRM1ssDCqdKcWhPnck/2IxjOk0NDLtm++bijckIZKo1nIHIpJgXS7gRaCoRs3ZTRc70BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=bow8mq8O; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="bow8mq8O"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id AA660A8A0D;
	Thu, 05 Feb 2026 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1770298357;
	bh=DUQvS/F+Vgbaz49D396NegNSmzl0Mp6WvUFBBCegj0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bow8mq8O3hIlZ25pL2+vdywU2iApx8jY8fjyfyVBgAzHJWldRzjHx9gewVcEmn2mK
	 FnTXK0C18pIA+8evkuqe3dS+CZJi3T0nfL7MfqSEMnLaTONtFG6Mo2tjKzJl9EXOX+
	 +S2wHSE9wCpJuQu9So3Uf9LeUVYpqLObZGtRuiZY=
Date: Thu, 5 Feb 2026 13:32:34 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
Message-ID: <aYSb8mKDKAxXF9KZ@shell.ilvokhin.com>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>

On Thu, Feb 05, 2026 at 03:46:31AM -0800, Breno Leitao wrote:
> Perf stat is crashing on arm64 hosts with the following issue:
> 
> 	# make -C tools/perf DEBUG=1
> 	# perf stat sleep 1
> 	perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core.fd)' failed.
> 	[1]    1220794 IOT instruction (core dumped)  ./perf stat
> 
> The sorting function introduced by commit a745c0831c15c ("perf stat:
> Sort default events/metrics") compares events based on their individual
> properties. This can cause events from different groups to be
> interleaved, resulting in group members appearing before their leaders
> in the sorted evlist.
> 
> When the iterator opens events in list order, a group member may be
> processed before its leader has been opened.
> 
> For example, CPU_CYCLES (idx=32) with leader STALL_SLOT_BACKEND (idx=37)
> could be sorted before its leader, causing the crash when CPU_CYCLES
> tries to get its group fd from the not-yet-opened leader.
> 
> Fix this by comparing events based on their leader's attributes instead
> of their own attributes when the events are in different groups. This
> ensures all members of a group share the same sort key as their leader,
> keeping groups together and guaranteeing leaders are opened before their
> members.
> 
> Reported-by: Denis Yaroshevskiy <dyaroshev@meta.com>
> Fixes: a745c0831c15c ("perf stat: Sort default events/metrics")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Cc; linux-arm-kernel@lists.infradead.org
> ---
>  tools/perf/builtin-stat.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ab40d85fb1259..3a423ca31d8d3 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1938,25 +1938,33 @@ static int default_evlist_evsel_cmp(void *priv __maybe_unused,
>  	const struct evsel *lhs = container_of(lhs_core, struct evsel, core);
>  	const struct perf_evsel *rhs_core = container_of(r, struct perf_evsel, node);
>  	const struct evsel *rhs = container_of(rhs_core, struct evsel, core);
> +	const struct evsel *lhs_leader = evsel__leader(lhs);
> +	const struct evsel *rhs_leader = evsel__leader(rhs);
>  
> -	if (evsel__leader(lhs) == evsel__leader(rhs)) {
> +	if (lhs_leader == rhs_leader) {
>  		/* Within the same group, respect the original order. */
>  		return lhs_core->idx - rhs_core->idx;
>  	}
>  
> +	/*
> +	 * Compare using leader's attributes so that all members of a group
> +	 * stay together. This ensures leaders are opened before their members.
> +	 */
> +
>  	/* Sort default metrics evsels first, and default show events before those. */
> -	if (lhs->default_metricgroup != rhs->default_metricgroup)
> -		return lhs->default_metricgroup ? -1 : 1;
> +	if (lhs_leader->default_metricgroup != rhs_leader->default_metricgroup)
> +		return lhs_leader->default_metricgroup ? -1 : 1;
>  
> -	if (lhs->default_show_events != rhs->default_show_events)
> -		return lhs->default_show_events ? -1 : 1;
> +	if (lhs_leader->default_show_events != rhs_leader->default_show_events)
> +		return lhs_leader->default_show_events ? -1 : 1;
>  
>  	/* Sort by PMU type (prefers legacy types first). */
> -	if (lhs->pmu != rhs->pmu)
> -		return lhs->pmu->type - rhs->pmu->type;
> +	if (lhs_leader->pmu != rhs_leader->pmu)
> +		return lhs_leader->pmu->type - rhs_leader->pmu->type;
>  
> -	/* Sort by name. */
> -	return strcmp(evsel__name((struct evsel *)lhs), evsel__name((struct evsel *)rhs));
> +	/* Sort by leader's name. */
> +	return strcmp(evsel__name((struct evsel *)lhs_leader),
> +		      evsel__name((struct evsel *)rhs_leader));
>  }
>  
>  /*
> 
> ---
> base-commit: 5fd0a1df5d05ad066e5618ccdd3d0fa6cb686c27
> change-id: 20260205-perf_stat-a0a2a37e21c5
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

Tested-by: Dmitry Ilvokhin <d@ilvokhin.com>
