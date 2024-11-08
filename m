Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5769233D80;
	Fri,  8 Nov 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090719; cv=none; b=BXwoWHUdyb5ENEdE/oGvtVqeGkxkVcIpoq0YwHlRR5A+Ec5fQUijIw2Zy6v+ADeWu+NU+WwJiPNbW+B6/OOM7O011yoglEZRO0JVCjyz7P91BNOfgQIAQf3uTVhU8DCrPqCiv8Iv1atafBYf9S93wWaDjyEiX5QQ3ZedGx99AT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090719; c=relaxed/simple;
	bh=OGGv9Ad1QjLyRUu0I2TAYu2k20sOVJkLksSuDtRoGmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyu0RuRta9xBeqtfR0h4nuIrukCDGI7UJQIdHZimWsjWwoy5CfAU9sKZeuapORi3yzYWElb1bKR06DZCiIJe4zzJKbx+g/F3wq3fdAU55zcLJAd9F9hyS7Ykd5J1SqODsP7Ndl9arp4P0sQ1rm2e89kaCgF/WU1gqyHO5fkS6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1xyEJlq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1xyEJlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80218C4CECD;
	Fri,  8 Nov 2024 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731090718;
	bh=OGGv9Ad1QjLyRUu0I2TAYu2k20sOVJkLksSuDtRoGmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1xyEJlqGTfBQL2g3ifsQSoNwPeldh0m7nm1tAuub0onRz0BsZgsLp4JlU5do1IxB
	 ds0meydDzkiROZV5LpYyuHZt3QayowteMTcKPuBEpezlXG6n7qdRpiBjLcyuQjqbvq
	 VgilTzN0jdR7oRFG9ufPwIFHjj3/jKj5B6iVdFfeHnL2jQPflFjEHe1gB0CRlNXoed
	 oBFNf4yPhEUDmhzjqfjmgZGhRRopROip02NI1IcynbQqVSsHW407mMTBTQFsiSCM/B
	 1KOXKtUPy4Pz9247eojn3ZSy+PifxmcHhnfJ9K4lnOUuJHWcEJVvybSPOfZ8pM5ofe
	 FHXLORT6pZ1mQ==
Date: Fri, 8 Nov 2024 10:31:56 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V14 08/11] perf tools: Add missing_features for
 aux_start_paused, aux_pause, aux_resume
Message-ID: <Zy5ZHHgO69gQwZRo@google.com>
References: <20241022155920.17511-1-adrian.hunter@intel.com>
 <20241022155920.17511-9-adrian.hunter@intel.com>
 <20241108154152.GA197781@e132581.arm.com>
 <Zy5M1WJ97GprNniq@google.com>
 <b97a8aa8-37b1-4d8f-9de0-f294fcd07adb@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b97a8aa8-37b1-4d8f-9de0-f294fcd07adb@intel.com>

On Fri, Nov 08, 2024 at 08:01:02PM +0200, Adrian Hunter wrote:
> On 8/11/24 19:39, Namhyung Kim wrote:
> > Hello,
> > 
> > On Fri, Nov 08, 2024 at 03:41:52PM +0000, Leo Yan wrote:
> >> Hi Adrian,
> >>
> >> On Tue, Oct 22, 2024 at 06:59:14PM +0300, Adrian Hunter wrote:
> >>>
> >>> Display "feature is not supported" error message if aux_start_paused,
> >>> aux_pause or aux_resume result in a perf_event_open() error.
> >>>
> >>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>> Acked-by: Ian Rogers <irogers@google.com>
> >>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >>> ---
> >>>
> >>>
> >>> Changes in V13:
> >>>         Add error message also in EOPNOTSUPP case (Leo)
> >>>
> >>>
> >>>  tools/perf/util/evsel.c | 12 ++++++++++++
> >>>  tools/perf/util/evsel.h |  1 +
> >>>  2 files changed, 13 insertions(+)
> >>>
> >>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>> index 95593b55d9a7..88b31a005ac6 100644
> >>> --- a/tools/perf/util/evsel.c
> >>> +++ b/tools/perf/util/evsel.c
> >>> @@ -2102,6 +2102,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
> >>>                 perf_missing_features.inherit_sample_read = true;
> >>>                 pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
> >>>                 return true;
> >>> +       } else if (!perf_missing_features.aux_pause_resume &&
> >>> +           (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
> >>> +            evsel->core.attr.aux_start_paused)) {
> >>> +               perf_missing_features.aux_pause_resume = true;
> >>> +               pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
> >>> +               return false;
> >>
> >> This patch fails to apply on the latest perf-tools-next branch due to
> >> conflict:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> >>   branch: perf-tools-next
> >>
> >> You might need to rebase it on the latest code base.
> > 
> > Yep, please do for the tooling patches.
> 
> I'd noticed that, but there is more work to sort it out.
> The probing simply won't work when there are dependencies
> on other events, or other attr members.  But there is no
> point in trying to "fallback" in that case either.  It is
> just a failure, but what *is* still needed is a sensible
> error message.

Do you need to probe with two or more events?  I guess we can extend
evsel__detect_missing_pmu_features to check more complicated setups.
For now, it only checks exclude_guest attribute.

> 
> The other patches, including the ones that come after,
> still apply by the way, or they did the other day, so
> they could be applied anyway.

Do you want me to process the series without this patch?  I think
this is needed to support old kernels and I'd like to have it together.
Would be hard for you to update this change in the current form and work
on improving it later?

Thanks,
Namhyung

