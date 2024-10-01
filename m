Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0D19ABC3;
	Tue,  1 Oct 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818564; cv=none; b=JPE3VF/cbeZkmRSoqG/jdBYHUmFoBcAQDyEbhVgizmjgZvh3SQp3v9DK0m+n9B0UxOkJ8pM1Moilq+00UIqqf+gCh3h/fFJPgMxWuygc05XA83FRwzAPdD438zVBMEiZTLlXSQRbrJZwlt2RiLrVlLeE4TwbKkzdvxbHcm62E3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818564; c=relaxed/simple;
	bh=RINnI8ZLTc2D0Ht2bvA8UL8+qn8W6PPVXCeR9E6ylY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzNQIm+1sIEHvoJ3viuhB21FsvRhc26DcuG+l3lzhgidwhuMCABs/A8gYWvQxRmm9FnbaGDJ7mLHPDVbXsbedihPZxFYTJ5rhEWuHsBumQPrKY7YUr/8xcpbDp9H1j35D8szKq63Ak7WrrWSiSksk/7i1d/ClJdzobFl1fe9fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3TQVGL1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3TQVGL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D102C4CECD;
	Tue,  1 Oct 2024 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727818564;
	bh=RINnI8ZLTc2D0Ht2bvA8UL8+qn8W6PPVXCeR9E6ylY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3TQVGL1qRcO1jBrgG/HhL/9Tch4JA74ZtGkzExkcp+WtRgtNTsIajnAGAtu+7yKY
	 chMgfHPhx3wMz343g8EQzeOSD4otoefPevPHajbUquUyBT8H7J/BHXUxJsenyor8t7
	 fhGbb1iCm0qXx2v650nsIc1KKFlMdAP0oYWWIJqg3gOHZpR/XVPHhD+g1DK/y4rNcX
	 MdcR4qy3LP+1K/Tr9w9O+/UCqWJmJ9hMkaGj3ZMSiQI12LNNeOLIXJo24kST1zRsP9
	 bhbCutpuIPHDZ2cTlxkjVn22fTP+9EtJQtW2YqgZozswLZxzsPLVux+HJWiqjLWu6G
	 UnnP/yI/on8NQ==
Date: Tue, 1 Oct 2024 14:36:02 -0700
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
Message-ID: <ZvxrQsHML0A1kF1P@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>

On Tue, Oct 01, 2024 at 11:00:20AM -0700, Ian Rogers wrote:
> On Mon, Sep 30, 2024 at 5:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The perf_event_open might fail due to various reasons, so blindly
> > reducing precise_ip level might not be the best way to deal with it.
> >
> > It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> > given precise level.  Let's try again with the correct error code.
> >
> > This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
> > user events with exclude_kernel=1 cannot make progress.  Let's add the
> > evsel__handle_error_quirks() to this case specially.  I plan to work on
> > the kernel side to improve this situation but it'd still need some
> > special handling for IBS.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 32e30c293d0c6198..ef8356260eea54cd 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
> >         return false;
> >  }
> >
> > +static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
> > +{
> > +       /* AMD IBS doesn't support exclude_kernel, forward it to core PMU */
> 
> Should the quirk handling be specific to evsels with the IBS PMU given
> the comment above? ie this is a PMU specific workaround rather than an
> AMD specific workaround, however, the PMU only exists on AMD :-)
> 
> > +       if (error == -EINVAL && evsel->precise_max && evsel->core.attr.precise_ip &&
> > +           evsel->core.attr.exclude_kernel && x86__is_amd_cpu()) {
> 
> So here rather than x86__is_amd_cpu it would be
> !strcmp(evsel->pmu->name, "ibs_...") . But it may be cleaner to move
> the logic into pmu.c.

I guess the problem is that AMD driver does implicit forwarding to IBS
if the legacy hardware events have precise_ip.  So it might have just
core pmu (or no pmu) in the evsel.
 
Thanks,
Namhyung

> 
> > +               evsel->core.attr.precise_ip = 0;
> > +               pr_debug2_peo("removing precise_ip on AMD\n");
> > +               display_attr(&evsel->core.attr);
> > +               return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >                 struct perf_thread_map *threads,
> >                 int start_cpu_map_idx, int end_cpu_map_idx)
> > @@ -2580,9 +2594,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >         return 0;
> >
> >  try_fallback:
> > -       if (evsel__precise_ip_fallback(evsel))
> > -               goto retry_open;
> > -
> >         if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
> >                                          idx, threads, thread, err)) {
> >                 /* We just removed 1 thread, so lower the upper nthreads limit. */
> > @@ -2599,11 +2610,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >         if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
> >                 goto retry_open;
> >
> > -       if (err != -EINVAL || idx > 0 || thread > 0)
> > -               goto out_close;
> > +       if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
> > +               goto retry_open;
> >
> > -       if (evsel__detect_missing_features(evsel))
> > +       if (err == -EINVAL && evsel__detect_missing_features(evsel))
> >                 goto fallback_missing_features;
> > +
> > +       if (evsel__handle_error_quirks(evsel, err))
> > +               goto retry_open;
> > +
> >  out_close:
> >         if (err)
> >                 threads->err_thread = thread;
> > --
> > 2.46.1.824.gd892dcdcdd-goog
> >
