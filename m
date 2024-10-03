Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725841CDFA8;
	Thu,  3 Oct 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995083; cv=none; b=MYQ5f0vv5UbGCpNZUyg61DDVJoekYREVahrrrF26/REcJcNQR93ToGfjA1jtwOpUHIC5BT5jGijMxG4nkHpu0s5ETmaxHgTmt3hdyP/sregF01Bsitm4tJ7DRCyVNSUub0AlhlklEq1DiQey/q+ixBM061+q1Xy2xhwBVj7rQPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995083; c=relaxed/simple;
	bh=e+x18129Zw5gaaJvvUH6Ulin83cGDGRGUsac7pecx/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af48NObcEOHULmHN0qn4QSDOdoWPNh5gQmWiet5IpDA38hl7B5eTDH7AevAafR+rg5imilPc3lVfm7YZ2V7V7eXE0U/L4TXRGGK3bmZOG53rUsTM5hOsmod+3TcxFJdeWJG2qD3y+14mRaAjbM9hUiVDI6pnQQqTXIIL14PlklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dskF6RBW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dskF6RBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE731C4CEC5;
	Thu,  3 Oct 2024 22:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727995083;
	bh=e+x18129Zw5gaaJvvUH6Ulin83cGDGRGUsac7pecx/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dskF6RBW5EXYNBg/3TFZnkAPdKTjHatErKrUgdVpPhiP8tbsaZkXGJ5aUjfxWpDAh
	 NfQZ1vZIPTXIjiiZnOVf2GLJBMZBOMohs04B/CcZwgLJHd2M4svR4iDRwQxaMOnMpQ
	 nFy75KQeV+sXlOFBQpze4KBMCkfjhffiZdc8vYr1kU4igT35J8+ea4gYcx2BQvQQ7R
	 Ck4j5033hr9HxQwYwIOzSYRosFNv4CuF0oM0J5zXMdjjPV+mpvEXWL77bV2BVdmdpW
	 QSH9O9gebRYq6vp8qrxNJ7mcizWpfJFo/2oUtPeJZdE03bA0AEsH6nApQ4Mo0B8gGe
	 k1Sid0Vjgt+gg==
Date: Thu, 3 Oct 2024 15:38:01 -0700
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
Message-ID: <Zv8cyZN1p7EI08XA@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
 <ZvxrQsHML0A1kF1P@google.com>
 <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>
 <Zv7O_XJZcSIS9I_i@google.com>
 <CAP-5=fUVLEo0f5ygccnf11J2zdZbFmoGF5UatAb+E8T9vwbeAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUVLEo0f5ygccnf11J2zdZbFmoGF5UatAb+E8T9vwbeAg@mail.gmail.com>

On Thu, Oct 03, 2024 at 10:32:47AM -0700, Ian Rogers wrote:
> On Thu, Oct 3, 2024 at 10:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Oct 01, 2024 at 03:21:50PM -0700, Ian Rogers wrote:
> > > On Tue, Oct 1, 2024 at 2:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Tue, Oct 01, 2024 at 11:00:20AM -0700, Ian Rogers wrote:
> > > > > On Mon, Sep 30, 2024 at 5:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > The perf_event_open might fail due to various reasons, so blindly
> > > > > > reducing precise_ip level might not be the best way to deal with it.
> > > > > >
> > > > > > It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> > > > > > given precise level.  Let's try again with the correct error code.
> > > > > >
> > > > > > This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
> > > > > > user events with exclude_kernel=1 cannot make progress.  Let's add the
> > > > > > evsel__handle_error_quirks() to this case specially.  I plan to work on
> > > > > > the kernel side to improve this situation but it'd still need some
> > > > > > special handling for IBS.
> > > > > >
> > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > ---
> > > > > >  tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
> > > > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > > > index 32e30c293d0c6198..ef8356260eea54cd 100644
> > > > > > --- a/tools/perf/util/evsel.c
> > > > > > +++ b/tools/perf/util/evsel.c
> > > > > > @@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
> > > > > >         return false;
> > > > > >  }
> > > > > >
> > > > > > +static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
> > > > > > +{
> > > > > > +       /* AMD IBS doesn't support exclude_kernel, forward it to core PMU */
> > > > >
> > > > > Should the quirk handling be specific to evsels with the IBS PMU given
> > > > > the comment above? ie this is a PMU specific workaround rather than an
> > > > > AMD specific workaround, however, the PMU only exists on AMD :-)
> > > > >
> > > > > > +       if (error == -EINVAL && evsel->precise_max && evsel->core.attr.precise_ip &&
> > > > > > +           evsel->core.attr.exclude_kernel && x86__is_amd_cpu()) {
> > > > >
> > > > > So here rather than x86__is_amd_cpu it would be
> > > > > !strcmp(evsel->pmu->name, "ibs_...") . But it may be cleaner to move
> > > > > the logic into pmu.c.
> > > >
> > > > I guess the problem is that AMD driver does implicit forwarding to IBS
> > > > if the legacy hardware events have precise_ip.  So it might have just
> > > > core pmu (or no pmu) in the evsel.
> > >
> > > I think the no PMU case should probably have a PMU possibly similar to
> > > the tool PMU in:
> > > https://lore.kernel.org/all/20240912190341.919229-1-irogers@google.com/
> > > But that's not in place yet. You can always use
> > > perf_pmus__scan_core(NULL) or
> > > perf_pmus__find_by_type(evsel->core.attr.type or PERF_TYPE_RAW).
> > > evsel->pmu->is_core && x86__is_amd_cpu() would identify an AMD core
> > > PMU whereas the code above could fire for IBS or other PMUs.
> >
> > But IBS is the only PMU on AMD that provides precise_ip IIRC.  So I
> > don't think other events would have it nor have any effect on changing
> > the value.  So maybe we can skip the PMU scanning and just drop to 0?
> 
> cpu supports precise_ip as it forwards it to IBS, IBS is an ambiguous
> term as there are ibs_op and ibs_fetch PMUs. The code is using values
> in the attribute to infer the PMU that is being used, it feels it
> would be more intention revealing to do things like:
> ```
> if (error == ... && perf_pmu__is_ibs_op_or_fetch(evsel->pmu)) ..
> ```

I guess it'd get a core PMU for the default cycles event.  I think the
intention is already confusing with the implicit forwarding.

Thanks,
Namhyung


> perhaps to not burden the code this can be:
> ```
> if (...) {
>   assert(perf_pmu__is_ibs_op_or_fetch(evsel->pmu));
> ```
> 
> Thanks,
> Ian
