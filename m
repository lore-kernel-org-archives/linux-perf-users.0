Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF43D3CEF;
	Fri, 18 Sep 2026 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762397; cv=none; b=mLLrFtcY4Sw8Z+brDpnRh+sL4b9pc02JXJmCruEvxHeklncl0PAxEhM/+LFwEUKoKYZCeVj3fFEcr1UJizNQeJEOiXn33+V20+PYwitzq+7loPRgr8TwDcLi7d0+w+9eLTZH2GC2+v4BQvHr7qu8EWEb2pJvftnL2H8+Akn/XAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762397; c=relaxed/simple;
	bh=lABoidUuRqjUzpcq0GaCiclTvSnaim7AKsqwxYTE+VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+i8Wnfr9JoLRKZKW4DY2/UcCaNBggAubA23fp09ncZc+2GBx96hp7kJyu0x33C0eQ8wUZiZcBn8+RcXGD5clYYG17gIEfsNszmPhU6crBSMYBjqWw7mjf1cYDDDNeM3ZuHayg8C8dQOMYM+V1H+U/IqSBvC0xa/Npi+9ajeRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja2DfG/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja2DfG/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61E81F000FF;
	Fri, 18 Sep 2026 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762395;
	bh=t/+3bSu2Qtz5vi9I1mkw1Cs04Ktng9wh88p+d9aHIgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ja2DfG/5uv2sEnO2lfFe0KRcqp7wjMZ8zsNRdFjMWXIStlPl36GcS8VWb65Xoatxw
	 t9tZAG/c5zJUwtOh4k+bLW+ivDwDYP23CmU+OcnGO7SZdBAPUkLNjgK63gkwhbl1ie
	 mPnHIjnw/6YNu1P3uWxq275aiaqHE1oE49+Ni8xB4R+/Lq5DFO0TQqr6zLnmBaVShe
	 F3Lp+23a7IWVo3pFAqSdDKNIYddFkTCstNjnn94+O2xo37w717Rs91c8/IgeCJpGlE
	 Lfvyk5E3WfTAPA62JckfUDZPrk4oiCZ+m4hEDYQ70OdfCz3npenqoEuebl0Ineestd
	 reGEwsVD5Ycgg==
Date: Fri, 18 Sep 2026 17:13:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, thomas.falcon@intel.com,
	dapeng1.mi@linux.intel.com, xudong.hao@intel.com
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots event
Message-ID: <aq2bV6oH8OT5tk4d@x2>
References: <20260916202740.257376-1-zide.chen@intel.com>
 <CAP-5=fV7mJEx27OQra2yaTegwRdzFUYohivFHFBvwD0cdb3=SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV7mJEx27OQra2yaTegwRdzFUYohivFHFBvwD0cdb3=SQ@mail.gmail.com>

On Wed, Sep 16, 2026 at 02:22:45PM -0700, Ian Rogers wrote:
> On Wed, Sep 16, 2026 at 1:37 PM Zide Chen <zide.chen@intel.com> wrote:
> >
> > arch_is_topdown_slots() requires config1 == 0, so it misidentified
> > "cpu/slots,metrics_clear=1/" as not being the slots event, and an
> > additional slots event gets inserted, which fails event scheduling
> > since the group now needs two fixed counter 3.
> >
> >   $ perf stat -e "{cpu/slots,metrics_clear=1/,cpu/topdown-retiring/}" -- sleep 1
> >   WARNING: events were regrouped to match PMUs
> >        <not counted>      slots
> >      <not supported>      cpu/slots,metrics_clear=1/
> >        <not counted>      cpu/topdown-retiring/
> >
> > Drop the config1 == 0 check from arch_is_topdown_slots(). This is
> > safe: config1 has no bearing on the event's identifying config value
> > (TOPDOWN_SLOTS, 0x0400).
> >
> > The attr.type == PERF_TYPE_RAW check is what actually matters: only the
> > core PMU is registered with PERF_TYPE_RAW, and on x86, 0x400 is
> > guaranteed to be slots event on core CPU.
> >
> > arch_is_topdown_metrics() keeps its own config1 == 0 check, since
> > genuine metrics events have no "metrics_clear" and config1 remains 0.
> >
> > Add a test verifying that an explicit "slots,metrics_clear=1" event in
> > a group does not trigger an extra slots event injection.
> >
> > Fixes: 5b546de9cc17 ("perf topdown: Use attribute to see an event is a topdown metic or slots")
> > Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Note, there's a Sashiko warning about a potentially missing #include
> for musl compatibility that maybe you or Arnaldo could address.

Merging, will look add address that comment,

Thanks,

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/arch/x86/tests/topdown.c | 28 ++++++++++++++++++++++++++++
> >  tools/perf/arch/x86/util/topdown.c  |  3 +--
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
> > index 2b6f47ce4932..b1ce9f83db00 100644
> > --- a/tools/perf/arch/x86/tests/topdown.c
> > +++ b/tools/perf/arch/x86/tests/topdown.c
> > @@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unu
> >         return TEST_OK;
> >  }
> >
> > +/*
> > + * An explicit "slots,metrics_clear=1" event is still the slots event and
> > + * must not cause an extra slots event to be injected into the group.
> > + */
> > +static int test__x86_topdown_metrics_clear(struct test_suite *test __maybe_unused,
> > +                                          int subtest __maybe_unused)
> > +{
> > +       struct perf_pmu *pmu;
> > +       char event_str[128];
> > +       int ret;
> > +
> > +       if (!topdown_sys_has_perf_metrics())
> > +               return TEST_OK;
> > +
> > +       pmu = perf_pmus__find_by_type(PERF_TYPE_RAW);
> > +       if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
> > +               return TEST_OK;
> > +
> > +       snprintf(event_str, sizeof(event_str),
> > +                "{%s/slots,metrics_clear=1/,%s/topdown-retiring/}",
> > +                pmu->name, pmu->name);
> > +       ret = test_sort(event_str, 2, 1);
> > +       TEST_ASSERT_EQUAL("explicit metrics_clear slots event isn't duplicated", ret, TEST_OK);
> > +
> > +       return TEST_OK;
> > +}
> > +
> >  static struct test_case x86_topdown_tests[] = {
> >         TEST_CASE("topdown events", x86_topdown),
> >         TEST_CASE("topdown sorting", x86_topdown_sorting),
> >         TEST_CASE("topdown slots injection", x86_topdown_slots_injection),
> > +       TEST_CASE("topdown metrics_clear no extra slots", x86_topdown_metrics_clear),
> >         { .name = NULL, }
> >  };
> >
> > diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> > index bafd285119d7..64bc64e335a2 100644
> > --- a/tools/perf/arch/x86/util/topdown.c
> > +++ b/tools/perf/arch/x86/util/topdown.c
> > @@ -37,8 +37,7 @@ bool topdown_sys_has_perf_metrics(void)
> >  bool arch_is_topdown_slots(const struct evsel *evsel)
> >  {
> >         return evsel->core.attr.type == PERF_TYPE_RAW &&
> > -              evsel->core.attr.config == TOPDOWN_SLOTS &&
> > -              evsel->core.attr.config1 == 0;
> > +              evsel->core.attr.config == TOPDOWN_SLOTS;
> >  }
> >
> >  bool arch_is_topdown_metrics(const struct evsel *evsel)
> > --
> > 2.55.0
> >
