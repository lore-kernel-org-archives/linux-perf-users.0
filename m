Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE702192F9;
	Thu, 14 May 2026 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803142; cv=none; b=ffGsaz/qMQNHu0qzQfv5S/YmJlL9EJvBC7qwuvAShFy5l5rOy4K3I60objzQ1F08dqroWyMLLxBcK1P5Lq/t9vQTQ4TQ/th3rBnLVRoo0aFDWNZwzj8rhHVEW3f2lMr2EKTiGqPyE8P+p+adjFcmzSJIw+Ycsvj61x3Rd9ZvwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803142; c=relaxed/simple;
	bh=YxgXXw6NbjD061mthp+VeEbFfMoa0CP5ZqTLL/EqDow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4F6DI8HH4xXAjNmfz0Xop0xd6lUSfSxAlCGdJDW6lvOBf/peycZtbf/dR4lZubhgHZ58R+4OxAfzgHSAI0KX+I9sitQpIFReQvXVBo6dPo+GStZ2WrDHq5DWwrniOMB6FyUmDOuy7w0f9ap41Ly0lShYCpbW0yGw2rfCjVRnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErQIS0nU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErQIS0nU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024FDC2BCB3;
	Thu, 14 May 2026 23:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778803141;
	bh=YxgXXw6NbjD061mthp+VeEbFfMoa0CP5ZqTLL/EqDow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErQIS0nUNSLFBuLTBqgTi45RHPZRvoXibTaEVpV4jcHtCbFUyZkmQqApSDRLA2aKI
	 WRckKskOzNnn5NzhguL/o30ckheA21rvlhfKVOEUA8kyp/QMNtuSrWeVSxEfFcr9Qr
	 GtesW9iHZjuz2m4N0w1+5HxDP7RfJLgX5E8iSISVpj7iE3wMPnojVPllt3C3FayMHX
	 bMEDSiRVfnwsctQEE7N6ZlkKp6BEZRRrApJK9/aVcnP+2qYXcf4Iqcd0cSdLT/1HSn
	 OW4zFAF36qSluepXdIsJ8F6YBpNw27IrEX/b3Egxnw+f/6aLCBMjWgVoe6ORE4fMSj
	 VpNQcyledrdOQ==
Date: Thu, 14 May 2026 20:58:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, namhyung@kernel.org,
	adrian.hunter@intel.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, thomas.falcon@intel.com
Subject: Re: [PATCH v2] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
Message-ID: <agZhwrpP3pG5zBWh@x1>
References: <acyWR2GAWIY7TKyD@google.com>
 <20260430161725.3131665-1-irogers@google.com>
 <8c5343a3-a110-420b-9b61-3e4dd0e3c902@linaro.org>
 <CAP-5=fXRjQKaHQWvNXiDyNZmDvtC=uYujgFsz7wmC5AJVK9d-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXRjQKaHQWvNXiDyNZmDvtC=uYujgFsz7wmC5AJVK9d-w@mail.gmail.com>

On Thu, May 14, 2026 at 10:39:08AM -0700, Ian Rogers wrote:
> On Wed, May 6, 2026 at 2:12 AM James Clark <james.clark@linaro.org> wrote:
> > On 30/04/2026 5:17 pm, Ian Rogers wrote:
> > > Only uncore PMUs can have an identifier, so add an optimized
> > > perf_pmus__scan routine for that case to avoid all PMU types being
> > > created.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >   tools/perf/util/metricgroup.c | 11 +++--------
> > >   tools/perf/util/pmus.c        | 18 +++++++++++++++++-
> > >   tools/perf/util/pmus.h        |  1 +
> > >   3 files changed, 21 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > > index 4db9578efd81..5a489e97c413 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -415,14 +415,9 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
> > >       if (!pm->metric_expr || !pm->compat)
> > >               return 0;
> > >
> > > -     while ((pmu = perf_pmus__scan(pmu))) {
> > > -
> > > -             if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, pmu->id))
> > > -                     continue;
> > > -
> > > -             return d->fn(pm, table, d->data);
> > > -     }
> > > -     return 0;
> > > +     /* Only process with the iterator if there is a a PMU that matches the ID. */
> > > +     pmu = perf_pmus__scan_for_uncore_id(pmu, pm->compat);
> > > +     return pmu ? d->fn(pm, table, d->data) : 0;
> > >   }
> > >
> > >   int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
> > > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > > index 9a2023ceeefd..5e3f571450fe 100644
> > > --- a/tools/perf/util/pmus.c
> > > +++ b/tools/perf/util/pmus.c
> > > @@ -409,7 +409,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
> > >       if (!pmu) {
> > >               /*
> > >                * Core PMUs, other sysfs PMUs and tool PMU can have any name or
> > > -              * aren't wother optimizing for.
> > > +              * aren't worth optimizing for.
> > >                */
> > >               unsigned int to_read_pmus =  PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
> > >                       PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
> > > @@ -486,6 +486,22 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
> > >       return NULL;
> > >   }
> > >
> > > +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat)
> > > +{
> > > +     if (!pmu) {
> > > +             /* Only uncore PMUs can have identifiers. */
> > > +             unsigned int to_read_pmus = PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
> > > +
> > > +             pmu_read_sysfs(to_read_pmus);
> > > +             pmu = list_prepare_entry(pmu, &other_pmus, list);
> > > +     }
> > > +     list_for_each_entry_continue(pmu, &other_pmus, list) {
> > > +             if (pmu->id && pmu_uncore_identifier_match(compat, pmu->id))
> > > +                     return pmu;
> > > +     }
> > > +     return NULL;
> > > +}
> > > +
> > >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
> > >   {
> > >       struct perf_pmu *pmu = NULL;
> > > diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> > > index 7cb36863711a..0d55edb3f2fc 100644
> > > --- a/tools/perf/util/pmus.h
> > > +++ b/tools/perf/util/pmus.h
> > > @@ -23,6 +23,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
> > >   struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
> > >   struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
> > >   struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
> > > +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat);
> > >
> > >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
> > >
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Ping.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
