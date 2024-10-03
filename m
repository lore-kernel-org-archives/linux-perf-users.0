Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C419D081;
	Thu,  3 Oct 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975167; cv=none; b=qOuTsQv0IPbhzefj2uAp01XMOsx2Dw5XBZAZAGZwN+dLF+FOle3DDrCuKCO3pbvgZL8iAbRbEhuqyHtkddqY5jothGMOAUMz940Q3ZBrz5mjiD2GLllwsDOwz8akS2Kk46jrPmWvpf2RvlgtkqrrIVtYY5TkoScbcdAOUNrVL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975167; c=relaxed/simple;
	bh=QSTQ+9PEY3u0XzGXIV5WSLIpCUo5HVkATM0lo7LTnB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUCAT9GBMgYpD+HfI2U7k5zBEG4X0BHdGJi1PUNS0oUy3j6fdx/5Wg/wd6aAWxK9FxNNaMuEIc6S/HSNHW2i8Au7mfugtVBy0PtJNlYm/f6DOnW7JLG/f25irsCKOzmGxuMxUJ/WhgkeBydwege+h8WpeYodkXIjronUzpYy4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf4z29NA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf4z29NA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD811C4CECC;
	Thu,  3 Oct 2024 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727975167;
	bh=QSTQ+9PEY3u0XzGXIV5WSLIpCUo5HVkATM0lo7LTnB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rf4z29NAgs9UGDwLaO/nh35LwR4/CL6QAY90CNWcv+SqgDkHDplZcAnk98g7mMlfn
	 MWtqLtr709WLIa8cAeuFrvLXy/OWrW4V6VU9y2FEQdJ2jZ7PzxWvUWD3Oq+8yUMZJe
	 Zzf9aa/WPmwe3olRIZYa+Ns87VsPL7R0HSJmNj2FHO7BCDOiabChVv08KR3oN4oAJc
	 eLbjJ5H93XBJDAgI7N7CCGI+pp6N/uEQFBWUiqtZKoaxnR56si7vg0J9DdR1V9Lpw0
	 NqUoV/NQWLj8pBKZKERulO17tyLXtNVuZW+63z8VHRUCnprAVTBgiXb0Z/EJGTwdX3
	 YSGveMWQ3VIpw==
Date: Thu, 3 Oct 2024 10:06:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 7/8] perf tools: Check fallback error and order
Message-ID: <Zv7O_XJZcSIS9I_i@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
 <ZvxrQsHML0A1kF1P@google.com>
 <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>

On Tue, Oct 01, 2024 at 03:21:50PM -0700, Ian Rogers wrote:
> On Tue, Oct 1, 2024 at 2:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Oct 01, 2024 at 11:00:20AM -0700, Ian Rogers wrote:
> > > On Mon, Sep 30, 2024 at 5:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > The perf_event_open might fail due to various reasons, so blindly
> > > > reducing precise_ip level might not be the best way to deal with it.
> > > >
> > > > It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> > > > given precise level.  Let's try again with the correct error code.
> > > >
> > > > This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
> > > > user events with exclude_kernel=1 cannot make progress.  Let's add the
> > > > evsel__handle_error_quirks() to this case specially.  I plan to work on
> > > > the kernel side to improve this situation but it'd still need some
> > > > special handling for IBS.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
> > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > index 32e30c293d0c6198..ef8356260eea54cd 100644
> > > > --- a/tools/perf/util/evsel.c
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
> > > >         return false;
> > > >  }
> > > >
> > > > +static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
> > > > +{
> > > > +       /* AMD IBS doesn't support exclude_kernel, forward it to core PMU */
> > >
> > > Should the quirk handling be specific to evsels with the IBS PMU given
> > > the comment above? ie this is a PMU specific workaround rather than an
> > > AMD specific workaround, however, the PMU only exists on AMD :-)
> > >
> > > > +       if (error == -EINVAL && evsel->precise_max && evsel->core.attr.precise_ip &&
> > > > +           evsel->core.attr.exclude_kernel && x86__is_amd_cpu()) {
> > >
> > > So here rather than x86__is_amd_cpu it would be
> > > !strcmp(evsel->pmu->name, "ibs_...") . But it may be cleaner to move
> > > the logic into pmu.c.
> >
> > I guess the problem is that AMD driver does implicit forwarding to IBS
> > if the legacy hardware events have precise_ip.  So it might have just
> > core pmu (or no pmu) in the evsel.
> 
> I think the no PMU case should probably have a PMU possibly similar to
> the tool PMU in:
> https://lore.kernel.org/all/20240912190341.919229-1-irogers@google.com/
> But that's not in place yet. You can always use
> perf_pmus__scan_core(NULL) or
> perf_pmus__find_by_type(evsel->core.attr.type or PERF_TYPE_RAW).
> evsel->pmu->is_core && x86__is_amd_cpu() would identify an AMD core
> PMU whereas the code above could fire for IBS or other PMUs.

But IBS is the only PMU on AMD that provides precise_ip IIRC.  So I
don't think other events would have it nor have any effect on changing
the value.  So maybe we can skip the PMU scanning and just drop to 0?

Thanks,
Namhyung

> 
> > >
> > > > +               evsel->core.attr.precise_ip = 0;
> > > > +               pr_debug2_peo("removing precise_ip on AMD\n");
> > > > +               display_attr(&evsel->core.attr);
> > > > +               return true;
> > > > +       }
> > > > +
> > > > +       return false;
> > > > +}
> > > > +
> > > >  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> > > >                 struct perf_thread_map *threads,
> > > >                 int start_cpu_map_idx, int end_cpu_map_idx)
> > > > @@ -2580,9 +2594,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> > > >         return 0;
> > > >
> > > >  try_fallback:
> > > > -       if (evsel__precise_ip_fallback(evsel))
> > > > -               goto retry_open;
> > > > -
> > > >         if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
> > > >                                          idx, threads, thread, err)) {
> > > >                 /* We just removed 1 thread, so lower the upper nthreads limit. */
> > > > @@ -2599,11 +2610,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> > > >         if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
> > > >                 goto retry_open;
> > > >
> > > > -       if (err != -EINVAL || idx > 0 || thread > 0)
> > > > -               goto out_close;
> > > > +       if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
> > > > +               goto retry_open;
> > > >
> > > > -       if (evsel__detect_missing_features(evsel))
> > > > +       if (err == -EINVAL && evsel__detect_missing_features(evsel))
> > > >                 goto fallback_missing_features;
> > > > +
> > > > +       if (evsel__handle_error_quirks(evsel, err))
> > > > +               goto retry_open;
> > > > +
> > > >  out_close:
> > > >         if (err)
> > > >                 threads->err_thread = thread;
> > > > --
> > > > 2.46.1.824.gd892dcdcdd-goog
> > > >
