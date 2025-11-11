Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89476329E42;
	Tue, 11 Nov 2025 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890067; cv=none; b=Fp4/p55j+Fx2JaX/iCVupXzRFEpjTXQF2tRQIiyHwOUkUiaOs3Q9HHwgrdKoAxEj+nsOLM3xemIQNsu5PilRLDfu+mi7bAJ5LiGlR3WbYQ7QN9yvT3vbmKpWf5TbOy8T3MXdMS7HbaqKGoTGdeRimS92J543z0O5zolbiVMiGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890067; c=relaxed/simple;
	bh=NzhKpMSaS0aeqcyiziATUPF8wn0JUM1MQ4SBCpM8dQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJy3bLc6iLEpkRzMcMHldogf762M2QZNv74GR0ZsIWav2Mg6vAD86HbkZffeMokS5Psp4h3BwLvkzkBEtftOccOUPIgpz7F9rkP4WJ/ZVYlZxgIpdPJLBND8XYxLHE++Vyif92QMZZalctYk5tIndv0d0zW03tdPM0iT+6XMXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc+/2dtc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc+/2dtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68BAC4CEF5;
	Tue, 11 Nov 2025 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762890062;
	bh=NzhKpMSaS0aeqcyiziATUPF8wn0JUM1MQ4SBCpM8dQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uc+/2dtcdzGAJiR8ApFaiz2BVXf7HWRly7NIZT92+qxB2uhdmjUksCOT6bCFGqVWK
	 GwLorK1SgCyR2vcsJ12El+XzfL2NpYwbJDst0G6pI6lr6/F/NvdUWt/3F6zUIKw/N2
	 FwfhGg8bsZfMNX+gaZivvo0WKsAUHmnl8GmSNCWvHX1/6BkmlxqLz8HUxE5hu15sjO
	 tao2IpgqnTqv5qotrjNId1PpEBTbUSUNhDkWJn2iWj6YCzrtr8J7ygIEpklyNLTwS2
	 em4gSu9ZKvV5k9ZU/MCxmWhHx014p6lCo+jJUV6iqVjlh2KIQE5ZpBSvqo5hcsIj6P
	 iUHe3g9XCcNyg==
Date: Tue, 11 Nov 2025 11:40:59 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix missing feature check for inherit +
 SAMPLE_READ
Message-ID: <aRORSxu22OSf-v0X@google.com>
References: <20251111075944.2328021-1-namhyung@kernel.org>
 <ac137eff-674c-4fa4-b870-80878af032a0@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac137eff-674c-4fa4-b870-80878af032a0@intel.com>

On Tue, Nov 11, 2025 at 11:13:20AM -0800, Chen, Zide wrote:
> 
> 
> On 11/10/2025 11:59 PM, Namhyung Kim wrote:
> > It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_READ
> > on recent kernels.  Not having _TID makes the feature check wrongly detect
> > the inherit and _READ support.
> > 
> > It was reported that the following command failed due to the error in
> > the missing feature check on Intel SPR machines.
> > 
> >   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> >   Error:
> >   Failure to open event 'cpu/mem-loads,ldlat=3/PS' on PMU 'cpu' which will be removed.
> >   Invalid event (cpu/mem-loads,ldlat=3/PS) in per-thread mode, enable system wide with '-a'.
> > 
> > Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features properly")
> > Reported-by: "Chen, Zide" <zide.chen@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 67a898cda86ab559..989c56d4a23f74f4 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
> >  	/* Please add new feature detection here. */
> >  
> >  	attr.inherit = true;
> > -	attr.sample_type = PERF_SAMPLE_READ;
> > +	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
> 
> 
> Seems this could have some unintended side effects. For example,
> consider a :ppp event with PERF_SAMPLE_READ and inherit attributes
> running on a system where the maximum precise_ip is 2:
> 
> - It fails to open the event on the first attempt;
> - It goes through the inherit_sample_read detection and fails again
> after removing inherit;

This is not what we want.  The kernel supports inherit + SAMPLE_READ
so it should not remove the inherit bit.


> - Finally, it succeeds after falling back to precision 2 — but the
> inherit attribute has been unexpectedly removed.

So it'll fallback to precision 2 without removing inherit.

> 
> I may have missed something, but I don’t quite understand why commit
> 3b193a57baf15 ("perf tools: Detect missing kernel features properly")
> performs the check on a dummy evsel instead of the original one. In this
> way, it might incorrectly fall back an attribute that doesn’t actually help.

Because different platforms have different limitations on hardware
events.  You cannot simply use current event for kernel feature check
since it can result in wrong decisions due to the limitation.  So we
picked the software event to avoid the hardware characteristics and to
focus on kernel features.

> 
> This means evsel__detect_missing_features() could theoretically roll
> back a feature that might not actually work. Given that it cannot
> restore the original evsel state after a failed attempt, side effects
> may occur.

The purpose is to turn off the non-supported features only and try with
other settings like precise_ip and exclude_kernels and so on.

Thanks,
Namhyung

