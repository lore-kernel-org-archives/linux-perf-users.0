Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400441C1F3F;
	Fri,  8 Nov 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087576; cv=none; b=efinhuStBfOUMgtLfnckhACBupgFxbBJWd5+MbkRqhvM+hBfB5EZacEMZOL7TGOmT2u1AmNaEJAuaueEPdjA091YPcPIgtx5eydc1bsqvf2CjyLduj8ONGn1NQvsp/df7+DC6o1Xs6U+TuvnhHLsgcHFthZVbMG695lvHDRpi+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087576; c=relaxed/simple;
	bh=XaQuID8TiBvkIJf++1pkBK7/hInFT3o78kefgCoQrrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3KxYUrEjXmn+R5x1xNw/3kHa5NBe6KjzLJ+J2nC/AamZOLYugO3EkBzZ0e0QY1nyckOEJF4tuY50X1Kkl15xgzZwHZ/lh70EcSX5MacPK1T00z473uDqz+9cyRcAXQi51FPXkBQ2WUE5QpnJt28cio2+WtgeOo3OfxE9ckcizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3/ZQTYa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3/ZQTYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C76C4CECD;
	Fri,  8 Nov 2024 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087576;
	bh=XaQuID8TiBvkIJf++1pkBK7/hInFT3o78kefgCoQrrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3/ZQTYaURutgBxr6XMKFBmeTH0eKRChi4TpAbxg7YZsoL5qJp0vKhFLW//S2vv1V
	 8VAav/SUFJW/+jz0/DQ/kDwQM9OCBUwd3zn/+P6ZIb/EdPEW60QaIKL5P3Su2aVBgp
	 m6zeQyXjRj8TRe7FwaNq8dNJrevNivjeKpm1BG7IJZmCzVvKvUL/SJyC/jImEEuTiA
	 HfdRU7fCD94SmTrULBSL+3GID33C3LgLLo6ZXeQVTO3saP/u7IeTvsDSKWnlEPNTLx
	 tC0wyAwYM5+UlGkf9J2w1bJljd9kXcgtyWM0OmUMfGoycIGU570oG9I5L+oP5CJDrQ
	 T3bHapN/LVC9A==
Date: Fri, 8 Nov 2024 09:39:33 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Zy5M1WJ97GprNniq@google.com>
References: <20241022155920.17511-1-adrian.hunter@intel.com>
 <20241022155920.17511-9-adrian.hunter@intel.com>
 <20241108154152.GA197781@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108154152.GA197781@e132581.arm.com>

Hello,

On Fri, Nov 08, 2024 at 03:41:52PM +0000, Leo Yan wrote:
> Hi Adrian,
> 
> On Tue, Oct 22, 2024 at 06:59:14PM +0300, Adrian Hunter wrote:
> > 
> > Display "feature is not supported" error message if aux_start_paused,
> > aux_pause or aux_resume result in a perf_event_open() error.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Acked-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > ---
> > 
> > 
> > Changes in V13:
> >         Add error message also in EOPNOTSUPP case (Leo)
> > 
> > 
> >  tools/perf/util/evsel.c | 12 ++++++++++++
> >  tools/perf/util/evsel.h |  1 +
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 95593b55d9a7..88b31a005ac6 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2102,6 +2102,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
> >                 perf_missing_features.inherit_sample_read = true;
> >                 pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
> >                 return true;
> > +       } else if (!perf_missing_features.aux_pause_resume &&
> > +           (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
> > +            evsel->core.attr.aux_start_paused)) {
> > +               perf_missing_features.aux_pause_resume = true;
> > +               pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
> > +               return false;
> 
> This patch fails to apply on the latest perf-tools-next branch due to
> conflict:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
>   branch: perf-tools-next
> 
> You might need to rebase it on the latest code base.

Yep, please do for the tooling patches.

Thanks,
Namhyung

