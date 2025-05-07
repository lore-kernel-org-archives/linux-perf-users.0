Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF727290BA9;
	Wed,  7 May 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654621; cv=none; b=r/O3D7dlfSl0N4WKVDRWmQlyRMJk15fJUdbxFGDtXwE+GF7RwrEDIiDqAdPnm/VfKQJxFQuZDVU8O+gODix36JR1pYXJzxni6wV/OfmNuLlcxIMjO3mcOvsHYlyu1hQaPdzoYA54MzwFCG+qFDDMgp9t0T6ZLIIapvolOfMPpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654621; c=relaxed/simple;
	bh=KR9vHap+h4BYbh2jF3iPqRsmCcxQWni8vbjUC6MVsOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN52gzFYk+AVlNS/vYNjdpuLHJ9R9FxhNYV7LL8U1GsNM+6JW1OwvRj9zG9atE/BOnlRAupGYbJLlo3RQOiIp7h/Z0mp0d5Rf8xXHs+BEMgDesuIGvuPC7vNHG8C3QlX3vgRCp0nwjccmv4K0SCsQEqBoZdnq70eEHVpwKEj97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+PRIM/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+PRIM/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA9CC4CEE2;
	Wed,  7 May 2025 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746654621;
	bh=KR9vHap+h4BYbh2jF3iPqRsmCcxQWni8vbjUC6MVsOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+PRIM/t8v+b7572vvJQe2DvMka6MY6OB6DrFLQBiiRcdG2epumPv0rNwz3WJ/9C0
	 c1FlG49DNRYyt3V4xB809iAwWoLfoBO2tzeYfc305HgKxvCeTZ1CszfUyG28aq3FrX
	 Sw4ZOVc66InUKK4wXGYjcnz5ulDtqthJFZIt4VE2lL3XAWJEBsTpbtFTttoPdFgXKH
	 8mSBV6Am4BqSc4/ywqkVDaO+JePBDvyTXQF5KNRvEJuf3GaqAje1i+KxxAAC+m0YyI
	 gDjsVLu7LeBUCCaHw+y9H+mmOdeqlS2Hy7gCqNCO8xmFpovjHyt3wvYjsO4gwHSF4e
	 iH/E/BLItLGzA==
Date: Wed, 7 May 2025 14:50:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Consider raw events as legacy events
Message-ID: <aBvVm2xkiwqDT5EX@google.com>
References: <20250506222312.1125082-1-namhyung@kernel.org>
 <CAP-5=fVvth_HnfnPNxtHe=FzxT9hNNKKDLGCSvQfLqwTY4WpHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVvth_HnfnPNxtHe=FzxT9hNNKKDLGCSvQfLqwTY4WpHg@mail.gmail.com>

Hi Ian,

On Wed, May 07, 2025 at 08:42:27AM -0700, Ian Rogers wrote:
> On Tue, May 6, 2025 at 3:23 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > When it finds a matching pmu for a legacy event, it should look for
> > core pmus.  The raw events also refers to core events so it should be
> > handled together.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/pmus.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index b99292de76693dbb..0134321fc520b1fc 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -726,7 +726,8 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
> >         pmu = perf_pmus__find_by_type(evsel->core.attr.type);
> >         legacy_core_type =
> >                 evsel->core.attr.type == PERF_TYPE_HARDWARE ||
> > -               evsel->core.attr.type == PERF_TYPE_HW_CACHE;
> > +               evsel->core.attr.type == PERF_TYPE_HW_CACHE ||
> > +               evsel->core.attr.type == PERF_TYPE_RAW;
> 
> I don't think this is right. The PERF_TYPE_RAW isn't a legacy type as
> we map sysfs/json names to the format encoding. More than this, the
> extended type information will not be present for a raw type and so
> this change could cause an invalid PMU to be looked up on
> hybrid/BIG.little systems. On x86 the cpu or cpu_core PMU will have
> type PERF_TYPE_RAW (4). As is common ARM decided to do things
> differently, meaning there is no type 4 to a PMU mapping. I think we
> need a change like:
> ```
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index b99292de7669..6632209c6664 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -727,14 +727,21 @@ struct perf_pmu *evsel__find_pmu(const struct
> evsel *evsel)
>        legacy_core_type =
>                evsel->core.attr.type == PERF_TYPE_HARDWARE ||
>                evsel->core.attr.type == PERF_TYPE_HW_CACHE;
> -       if (!pmu && legacy_core_type) {
> -               if (perf_pmus__supports_extended_type()) {
> -                       u32 type = evsel->core.attr.config >>
> PERF_PMU_TYPE_SHIFT;
> +       if (!pmu && legacy_core_type && perf_pmus__supports_extended_type()) {
> +               u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
> 
> -                       pmu = perf_pmus__find_by_type(type);
> -               } else {
> -                       pmu = perf_pmus__find_core_pmu();
> -               }
> +               pmu = perf_pmus__find_by_type(type);
> +       }
> +       if (!pmu && (legacy_core_type || evsel->core.attr.type ==
> PERF_TYPE_RAW)) {
> +               /*
> +                * For legacy events, if there was no extended type info then
> +                * assume the PMU is the first core PMU.
> +                *
> +                * On architectures like ARM there is no sysfs PMU with type
> +                * PERF_TYPE_RAW, assume the RAW events are going to be handled
> +                * by the first core PMU.
> +                */
> +               pmu = perf_pmus__find_core_pmu();
>        }
>        ((struct evsel *)evsel)->pmu = pmu;
>        return pmu;
> ```
> which handles both the case that the extended type was missing on
> hybrid/BIG.little and the ARM raw type problem.

Looks good to me.  Thanks for the suggestion!

Thanks,
Namhyung

