Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA505221DAC;
	Tue, 11 Nov 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900306; cv=none; b=Yx0yfl6Uqvkr+CJN8+2a9AdFhmnmjDXaEGdFSRuX94X+g+P6gixtiV5U7GV9dfa7Xzenvl5q9lGtp7awF8nyKJWN+ATTMZRrfdRt/eS0K/PTKSoM4rKCSEBIy6Rc8ObunGSYDPxwEAaq98szWvGWksyZ1cesSgZwwwCnIHSWMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900306; c=relaxed/simple;
	bh=c302QH8O3LmdHuzWv6Zq0j1blY8jjYO8MIFzVyroBuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7AxFwYT7m1x3tu1DfSTjYJljCqWT2QdoOY3w6iv41gzfOz5KoA+9k/IgTpNubh7Ls7tQFueDBNkmWAvBj44+9aftMS9IY3Upic9sFVDVXuLZsxi7tNAroLVGc8sf6FxatNkkQ5PhTx1L2CtBhbe9eK6BjqH8dc3NUOm6kMudyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlJQMzl9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlJQMzl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46334C4AF09;
	Tue, 11 Nov 2025 22:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762900306;
	bh=c302QH8O3LmdHuzWv6Zq0j1blY8jjYO8MIFzVyroBuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlJQMzl9KrwnQRCag1dsvhKjUCm9QX3+Svh835cbvaF/dPEpW8cUBVjyjWotC/lxF
	 s1/hsgLQ3x08RNy3oO6ON8gHkkChjCv9znRlWwxaTJLUVM2u+th3AlawwbilwEMcDS
	 yEXI3YS+KoWndLlv4J8xl1W4yd9X7fYkJivPtJvqjaM9knviQ81BscemrIdKElO40v
	 ZaIXxQRRSTDn2VRMoU1khMjDWd6ZrBEMm5URIVEFMPy84aBJ/TkffvhNo0868D+4L8
	 xHbKdCV4/SWmmrWH8DKz2Ikx7LVXDsk88IaFFFtHQm0BE+XRfpXZWgAvKtFAWZdI7T
	 LlozLasoGE7TQ==
Date: Tue, 11 Nov 2025 14:31:42 -0800
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
Message-ID: <aRO5Tuz_-m5PX9Pz@google.com>
References: <20251111075944.2328021-1-namhyung@kernel.org>
 <ac137eff-674c-4fa4-b870-80878af032a0@intel.com>
 <aRORSxu22OSf-v0X@google.com>
 <7ea7c72d-7570-4eca-8a8a-d8f93363691e@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ea7c72d-7570-4eca-8a8a-d8f93363691e@intel.com>

On Tue, Nov 11, 2025 at 12:03:22PM -0800, Chen, Zide wrote:
> 
> 
> On 11/11/2025 11:40 AM, Namhyung Kim wrote:
> > On Tue, Nov 11, 2025 at 11:13:20AM -0800, Chen, Zide wrote:
> >>
> >>
> >> On 11/10/2025 11:59 PM, Namhyung Kim wrote:
> >>> It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_READ
> >>> on recent kernels.  Not having _TID makes the feature check wrongly detect
> >>> the inherit and _READ support.
> >>>
> >>> It was reported that the following command failed due to the error in
> >>> the missing feature check on Intel SPR machines.
> >>>
> >>>   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> >>>   Error:
> >>>   Failure to open event 'cpu/mem-loads,ldlat=3/PS' on PMU 'cpu' which will be removed.
> >>>   Invalid event (cpu/mem-loads,ldlat=3/PS) in per-thread mode, enable system wide with '-a'.
> >>>
> >>> Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features properly")
> >>> Reported-by: "Chen, Zide" <zide.chen@intel.com>
> >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>> ---
> >>>  tools/perf/util/evsel.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>> index 67a898cda86ab559..989c56d4a23f74f4 100644
> >>> --- a/tools/perf/util/evsel.c
> >>> +++ b/tools/perf/util/evsel.c
> >>> @@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
> >>>  	/* Please add new feature detection here. */
> >>>  
> >>>  	attr.inherit = true;
> >>> -	attr.sample_type = PERF_SAMPLE_READ;
> >>> +	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
> >>
> >>
> >> Seems this could have some unintended side effects. For example,
> >> consider a :ppp event with PERF_SAMPLE_READ and inherit attributes
> >> running on a system where the maximum precise_ip is 2:
> >>
> >> - It fails to open the event on the first attempt;
> >> - It goes through the inherit_sample_read detection and fails again
> >> after removing inherit;
> > 
> > This is not what we want.  The kernel supports inherit + SAMPLE_READ
> > so it should not remove the inherit bit.
> > 
> > 
> >> - Finally, it succeeds after falling back to precision 2 — but the
> >> inherit attribute has been unexpectedly removed.
> > 
> > So it'll fallback to precision 2 without removing inherit.
> > 
> >>
> >> I may have missed something, but I don’t quite understand why commit
> >> 3b193a57baf15 ("perf tools: Detect missing kernel features properly")
> >> performs the check on a dummy evsel instead of the original one. In this
> >> way, it might incorrectly fall back an attribute that doesn’t actually help.
> > 
> > Because different platforms have different limitations on hardware
> > events.  You cannot simply use current event for kernel feature check
> > since it can result in wrong decisions due to the limitation.  So we
> > picked the software event to avoid the hardware characteristics and to
> > focus on kernel features.
> > 
> >>
> >> This means evsel__detect_missing_features() could theoretically roll
> >> back a feature that might not actually work. Given that it cannot
> >> restore the original evsel state after a failed attempt, side effects
> >> may occur.
> > 
> > The purpose is to turn off the non-supported features only and try with
> > other settings like precise_ip and exclude_kernels and so on.
> 
> OK, thanks!

Can you please confirm if this patch fixes your problem?

Thanks,
Namhyung

