Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DE33F3;
	Wed, 12 Nov 2025 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908197; cv=none; b=Pg4DOlKoUhPxBMkIR/WyRiswtyRSeNuSJJWwEJmWU8nilaoH/eRojBF/3cLYMHpemWbxVYilLJrny9qxDeNVuoA1t6qxoEcoUF3CQvJdDzlzuzmok4p4TRLWRgvvf5Jb7PEjptZWTL16y317gfPJXYOXUAzCeqr5c1o61X0Fk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908197; c=relaxed/simple;
	bh=atpFUL7pJYRuvuflts9DoB2NTZpWxZJSKckn+I2ruEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1mF8FAKYQ7zBXk6htCVL8bjf7sasGhLb+ViZ/lUgJdkVpw1RcHc3AVmib25osVRDQZJ/SOP97vYc0g4TMaMgcFg+OyBI4HjXZX/ahMRCprEiaCzz53WdGuesZ5iiQaNK4Z14EGuxCKFowxcf5jqF5DWPX0dm4ihrXhteHBPw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azgas3dy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azgas3dy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DE2C116D0;
	Wed, 12 Nov 2025 00:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762908196;
	bh=atpFUL7pJYRuvuflts9DoB2NTZpWxZJSKckn+I2ruEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azgas3dy3XFARqqEvidJa0zDJCCN7XnLwbpkIQFjp6vDAvrACAJaLkMLIHlYDAevM
	 5qOm3TBzkj+RieWN/Dy5D7LLJF3nKDdvz3bWveIYxl2W1DFI3zbNO9o1wZVaDSWyhC
	 mcebqrnLATC0AgtqvMHdolQt3p++6aL4WisX1NPbZRvej6HV6+fQBIUBcjagTlXly0
	 ham7uuRIpfi6YVap8OBvO+fPt0YvNoqpMeyG7OdtjlDoMwY38pq32tfAx5sSWtZBag
	 YtNUe+2WRCNNE3TOw893hcCA1TmEaUNvBkhQGq1jilSUWKoNCbERS1ODymBfaU0VsH
	 lKl36mF/+Ne8Q==
Date: Tue, 11 Nov 2025 16:43:13 -0800
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
Message-ID: <aRPYITVx_MHKEeFd@google.com>
References: <20251111075944.2328021-1-namhyung@kernel.org>
 <ac137eff-674c-4fa4-b870-80878af032a0@intel.com>
 <aRORSxu22OSf-v0X@google.com>
 <7ea7c72d-7570-4eca-8a8a-d8f93363691e@intel.com>
 <aRO5Tuz_-m5PX9Pz@google.com>
 <3f2e834b-36d1-4227-b1bd-843e824ac353@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f2e834b-36d1-4227-b1bd-843e824ac353@intel.com>

On Tue, Nov 11, 2025 at 02:36:19PM -0800, Chen, Zide wrote:
> 
> 
> On 11/11/2025 2:31 PM, Namhyung Kim wrote:
> > On Tue, Nov 11, 2025 at 12:03:22PM -0800, Chen, Zide wrote:
> >>
> >>
> >> On 11/11/2025 11:40 AM, Namhyung Kim wrote:
> >>> On Tue, Nov 11, 2025 at 11:13:20AM -0800, Chen, Zide wrote:
> >>>>
> >>>>
> >>>> On 11/10/2025 11:59 PM, Namhyung Kim wrote:
> >>>>> It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_READ
> >>>>> on recent kernels.  Not having _TID makes the feature check wrongly detect
> >>>>> the inherit and _READ support.
> >>>>>
> >>>>> It was reported that the following command failed due to the error in
> >>>>> the missing feature check on Intel SPR machines.
> >>>>>
> >>>>>   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> >>>>>   Error:
> >>>>>   Failure to open event 'cpu/mem-loads,ldlat=3/PS' on PMU 'cpu' which will be removed.
> >>>>>   Invalid event (cpu/mem-loads,ldlat=3/PS) in per-thread mode, enable system wide with '-a'.
> >>>>>
> >>>>> Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features properly")
> >>>>> Reported-by: "Chen, Zide" <zide.chen@intel.com>
> >>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>>>> ---
> >>>>>  tools/perf/util/evsel.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>>>> index 67a898cda86ab559..989c56d4a23f74f4 100644
> >>>>> --- a/tools/perf/util/evsel.c
> >>>>> +++ b/tools/perf/util/evsel.c
> >>>>> @@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
> >>>>>  	/* Please add new feature detection here. */
> >>>>>  
> >>>>>  	attr.inherit = true;
> >>>>> -	attr.sample_type = PERF_SAMPLE_READ;
> >>>>> +	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
> >>>>
> >>>>
> >>>> Seems this could have some unintended side effects. For example,
> >>>> consider a :ppp event with PERF_SAMPLE_READ and inherit attributes
> >>>> running on a system where the maximum precise_ip is 2:
> >>>>
> >>>> - It fails to open the event on the first attempt;
> >>>> - It goes through the inherit_sample_read detection and fails again
> >>>> after removing inherit;
> >>>
> >>> This is not what we want.  The kernel supports inherit + SAMPLE_READ
> >>> so it should not remove the inherit bit.
> >>>
> >>>
> >>>> - Finally, it succeeds after falling back to precision 2 — but the
> >>>> inherit attribute has been unexpectedly removed.
> >>>
> >>> So it'll fallback to precision 2 without removing inherit.
> >>>
> >>>>
> >>>> I may have missed something, but I don’t quite understand why commit
> >>>> 3b193a57baf15 ("perf tools: Detect missing kernel features properly")
> >>>> performs the check on a dummy evsel instead of the original one. In this
> >>>> way, it might incorrectly fall back an attribute that doesn’t actually help.
> >>>
> >>> Because different platforms have different limitations on hardware
> >>> events.  You cannot simply use current event for kernel feature check
> >>> since it can result in wrong decisions due to the limitation.  So we
> >>> picked the software event to avoid the hardware characteristics and to
> >>> focus on kernel features.
> >>>
> >>>>
> >>>> This means evsel__detect_missing_features() could theoretically roll
> >>>> back a feature that might not actually work. Given that it cannot
> >>>> restore the original evsel state after a failed attempt, side effects
> >>>> may occur.
> >>>
> >>> The purpose is to turn off the non-supported features only and try with
> >>> other settings like precise_ip and exclude_kernels and so on.
> >>
> >> OK, thanks!
> > 
> > Can you please confirm if this patch fixes your problem?
> 
> Yes, it works!

Thanks, I'll add your Tested-by then!

Namhyung

