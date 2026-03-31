Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F54370D65;
	Tue, 31 Mar 2026 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938653; cv=none; b=u2bO/jEiHr/0VeqMbPwSrhAp5pw3BYQ2g5JJ5qxAhGuxhdwWAG8xtuGWQlVoB7uG63yd0CrLJJp/N+tcLQ2vGqd/TIXKYXj7zImaNI5ldnOF1h/8Ve/uI1Bkn0ZEwPioCYc5h5zES4Yu+qruTBStIXrwOYwosVea9n1hdNuMcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938653; c=relaxed/simple;
	bh=BMJo0V9g3cbNMoitA27GyS5FMiNdbtTu3n072W0v+G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAAEoR16323QzuB9tNRVCIGTd+s/Of89Kp31rt8SE3YiaTUf+cIS+Y0Vgfrd7jowM5kxLGAgvBdxgiFBybD5ZuyxD7v8/fU7m6UFMOgdEOerY7g+NX2pDBzSjKC8bmFF1RA3KeRbsxcXB1VyPRZQwglfLqCb21r+q3Lt7rTtMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFMf8A7J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFMf8A7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038BEC19424;
	Tue, 31 Mar 2026 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774938653;
	bh=BMJo0V9g3cbNMoitA27GyS5FMiNdbtTu3n072W0v+G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFMf8A7Jcvaa+mXDEc+3eSS8Sn48PUnfY1gBWwb8bF91kkR6BpfF5l9+amPOEs5TS
	 4A48v53DhtvTf44HcyINb9izZ4Qlm7z88tDfWsWomntx2t9hN/A/cOnfUZQNZN8nak
	 01t1la8f1BNk5xog9HI67VTpLxxWDIth7Pm7kWraRrLSZXHOB5u9/a7Nppe9m25uzN
	 LvvHQDNU0F3/N0M+8y7Z8Ckb1Q4bzN6I97iifN5Mzi1I0p/qMTFhvDMq599FmfSfiF
	 kQtIG9aoTsSvqgY0eJBc6H2gRNo2dqPut6A4R7DpqcZ+DgxnvT4+JBjLurItAxm5kg
	 hupD4Q+biMkmQ==
Date: Mon, 30 Mar 2026 23:30:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
Message-ID: <actqG7NHUWR8x7x_@google.com>
References: <20260326224454.2101190-1-irogers@google.com>
 <dcf5a92b-ef14-43d5-9f21-568252fd630b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcf5a92b-ef14-43d5-9f21-568252fd630b@linaro.org>

On Mon, Mar 30, 2026 at 03:44:21PM +0100, James Clark wrote:
> 
> 
> On 26/03/2026 10:44 pm, Ian Rogers wrote:
> > Only uncore PMUs can have an identifier, so add an optimized
> > perf_pmus__scan routine for that case to avoid all PMU types being
> > created.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> > ---
> >   tools/perf/util/metricgroup.c |  8 ++------
> >   tools/perf/util/pmus.c        | 18 +++++++++++++++++-
> >   tools/perf/util/pmus.h        |  1 +
> >   3 files changed, 20 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 7e39d469111b..769b38400832 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -410,13 +410,9 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
> >   	if (!pm->metric_expr || !pm->compat)
> >   		return 0;
> > -	while ((pmu = perf_pmus__scan(pmu))) {
> > -
> > -		if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, pmu->id))
> > -			continue;
> > -
> > +	while ((pmu = perf_pmus__scan_for_uncore_id(pmu, pm->compat)))
> >   		return d->fn(pm, table, d->data);

Sashiko review: it's natural to convert it to 'if'.

Thanks,
Namhyung


> > -	}
> > +
> >   	return 0;
> >   }
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 98be2eb8f1f0..9859d7056fb7 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -409,7 +409,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
> >   	if (!pmu) {
> >   		/*
> >   		 * Core PMUs, other sysfs PMUs and tool PMU can have any name or
> > -		 * aren't wother optimizing for.
> > +		 * aren't worth optimizing for.
> >   		 */
> >   		unsigned int to_read_pmus =  PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
> >   			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
> > @@ -486,6 +486,22 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
> >   	return NULL;
> >   }
> > +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat)
> > +{
> > +	if (!pmu) {
> > +		/* Only uncore PMUs can have identifiers. */
> > +		unsigned int to_read_pmus = PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
> > +
> > +		pmu_read_sysfs(to_read_pmus);
> > +		pmu = list_prepare_entry(pmu, &other_pmus, list);
> > +	}
> > +	list_for_each_entry_continue(pmu, &other_pmus, list) {
> > +		if (pmu->id && pmu_uncore_identifier_match(compat, pmu->id))
> > +			return pmu;
> > +	}
> > +	return NULL;
> > +}
> > +
> >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
> >   {
> >   	struct perf_pmu *pmu = NULL;
> > diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> > index 7cb36863711a..0d55edb3f2fc 100644
> > --- a/tools/perf/util/pmus.h
> > +++ b/tools/perf/util/pmus.h
> > @@ -23,6 +23,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
> >   struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
> >   struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
> >   struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
> > +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat);
> >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
> 
