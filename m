Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5A367F4A;
	Wed,  1 Apr 2026 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775015497; cv=none; b=Wx9Rdo2gcwOIHoqwHEjGwjH9GYvQijB2PvxJudlv3z3QsBCwuchNWIgp5oB+k6VkHvXz4CB/lKLyRl4g2kWcGaYa0uYxnWXI1U2RbHesV2vakoMB0WroU/ySfq0PAqJD0ZnZ7wtHd+o5J/5QXm+AjI+6ddGENFpochZzCvND8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775015497; c=relaxed/simple;
	bh=4BSPU1L9CvllfWTQDoPCOFJp3E4D5EWbfnZIUv7WUgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCAUZ2Ocn0Vi0TPkMB62XzABgx50CG6T8Q4nWIAlgDVQ8wGyXEeJaAh5Zj7s6iRTWGkFIAYu1aUYlQtpRCQXtvxfYIpGPFnIQiVAeq9IrAtLvKV0yKt9S8+AXo0Zh8vRzuec6NW0hUMfdMejqYW+LMuyIQ+HyYJN62E1WcchE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qdr+ORMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qdr+ORMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0CBC4CEF7;
	Wed,  1 Apr 2026 03:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775015497;
	bh=4BSPU1L9CvllfWTQDoPCOFJp3E4D5EWbfnZIUv7WUgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qdr+ORMt2z9n0QoZDrHHb5iOwXd6q1xmA1SsGvc2m/4Vq/TNqFmNN3CEnuovKxEpj
	 8xHhJVG9MjFONFFM2+Vs9PFYxf6NCoaonIVCSbqm2LRvX4mmBgmyd9c00v9Edh2epR
	 q01OLxOXzpaLaxrFXqxWKlIUaJ6BDjJtqgBrkhbcYm1Gv6tWcCQUbJbCM6pRGSL6js
	 fehYldcKtp54PF2TWu2Y2NzdvXvvcaAN7hC4WbuHE6cgheCCyweb5n/Vqd24uPiK2Y
	 iWXgSRWecuPi22xNuyVZI9Nk7wWajhfM7aLa/TSXWhioo5C5BBqws9flfvptp8sUro
	 lCvmhs+ru97jg==
Date: Tue, 31 Mar 2026 20:51:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
Message-ID: <acyWR2GAWIY7TKyD@google.com>
References: <20260326224454.2101190-1-irogers@google.com>
 <dcf5a92b-ef14-43d5-9f21-568252fd630b@linaro.org>
 <actqG7NHUWR8x7x_@google.com>
 <CAP-5=fVOtY8NYQnhwgyexyjDN+W4Vf2Yo+_Tm6chZSfYFx-OMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVOtY8NYQnhwgyexyjDN+W4Vf2Yo+_Tm6chZSfYFx-OMQ@mail.gmail.com>

On Tue, Mar 31, 2026 at 07:05:58AM -0700, Ian Rogers wrote:
> On Mon, Mar 30, 2026 at 11:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Mar 30, 2026 at 03:44:21PM +0100, James Clark wrote:
> > >
> > >
> > > On 26/03/2026 10:44 pm, Ian Rogers wrote:
> > > > Only uncore PMUs can have an identifier, so add an optimized
> > > > perf_pmus__scan routine for that case to avoid all PMU types being
> > > > created.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Reviewed-by: James Clark <james.clark@linaro.org>
> > >
> > > > ---
> > > >   tools/perf/util/metricgroup.c |  8 ++------
> > > >   tools/perf/util/pmus.c        | 18 +++++++++++++++++-
> > > >   tools/perf/util/pmus.h        |  1 +
> > > >   3 files changed, 20 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > > > index 7e39d469111b..769b38400832 100644
> > > > --- a/tools/perf/util/metricgroup.c
> > > > +++ b/tools/perf/util/metricgroup.c
> > > > @@ -410,13 +410,9 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
> > > >     if (!pm->metric_expr || !pm->compat)
> > > >             return 0;
> > > > -   while ((pmu = perf_pmus__scan(pmu))) {
> > > > -
> > > > -           if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, pmu->id))
> > > > -                   continue;
> > > > -
> > > > +   while ((pmu = perf_pmus__scan_for_uncore_id(pmu, pm->compat)))
> > > >             return d->fn(pm, table, d->data);
> >
> > Sashiko review: it's natural to convert it to 'if'.
> 
> Yeah, I saw and disagreed. The pattern with the  "while ((pmu =
> perf_pmus__scan...(pmu)))" functions is for them to be a while loop.
> With an "if" it would read:
> ```
> pmu = perf_pmus__scan...(pmu);
> if (pmu)
>    return ...
> ```
> and we lose the consistency of having while loops in the code.

I understand it's a pattern to scan PMUs but having an unused
variable assignment in a while loop with a return statement seems
unnatural and maybe someone would send a patch for it later.

At least we can add a comment saying it's intended?

Thanks,
Namhyung

