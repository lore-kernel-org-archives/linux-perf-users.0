Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C1230BDF;
	Tue,  4 Nov 2025 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228140; cv=none; b=lo0JW+fcuYhslT1ht2gSw2LeSHMF/QR/UEhm8XQ5qUEmz7GemcohjXEYbnLTi6gWjrkqHyY02h/3fgWcqCqovDbG5yJxsaLCdCk/69/4A/Pvi7a5x8GORaG8J47GW1VU4rfgvVXIvAR4m1RX7yag27iV/WYUal78CKYwaHKBM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228140; c=relaxed/simple;
	bh=2bkhXRxdJbRGonobS275DIWBRk3WTARXTyVtRmh7dTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUhnDG3Zbcv0B6lRGX8KdxBOh76tchu0RyQK7TlU91bkE7lMVqlXzHLG4nGpUBoejA1StF2kYhMn7MGDNTyVcMlP+NNWQpDk6h/Rob8+K1Qcsz6G9keOTpNmv4iybipO9AP5WWSGj5/pGlpExkZdRq9+/KNZieoFK4SxEQv5LgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLqWKMCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLqWKMCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA4AC4CEF7;
	Tue,  4 Nov 2025 03:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762228139;
	bh=2bkhXRxdJbRGonobS275DIWBRk3WTARXTyVtRmh7dTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLqWKMCbAygN0utECwZS9zX+3SvXk5JjT55bL7RoN9cDrDYuYLE3SpAgkY2j0a76+
	 8NEAl2kAc21Yj9QSfWCrmi/mBd1NJy0XUyYpKJCbHqtrbKm5fgfLEAfT8cL1A26amP
	 4ParqWs67UtgGSUW5M322Yd19slAgI8F4UZiLp4ljiwwkUCjGnyjZwKBuxyWbYTS/I
	 q0wiXWLsauLhrlgrREcmBqDpwcQFfox7OJKEFbcLgD9iPp6y7r92fdyWEtbPv77Syc
	 8IKraFhfIruuUCatjShiWYjAlEoxzI7PD6EQAIrnga5lt48TBoCh7Ih1fpt6L8eZ23
	 9mK79Lopd0sfA==
Date: Mon, 3 Nov 2025 19:48:57 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
Message-ID: <aQl3qfyTdAb68l1l@google.com>
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <aPrktlANBHFtV52B@google.com>
 <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>
 <aP1ucJiJYBavTHV7@google.com>
 <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>

Hello,

Sorry for the delay.

On Mon, Oct 27, 2025 at 11:56:52AM -0700, Chen, Zide wrote:
> 
> 
> On 10/25/2025 5:42 PM, Namhyung Kim wrote:
> > On Fri, Oct 24, 2025 at 11:03:17AM -0700, Chen, Zide wrote:
> >>
> >>
> >> On 10/23/2025 7:30 PM, Namhyung Kim wrote:
> >>> Hello,
> >>>
> >>> On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
> >>>> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> >>>> unconditionally called the precise_ip fallback and moved it after the
> >>>> missing-feature checks so that it could handle EINVAL as well.
> >>>>
> >>>> However, this introduced an issue: after disabling missing features,
> >>>> the event could fail to open, which makes the subsequent precise_ip
> >>>> fallback useless since it will always fail.
> >>>>
> >>>> For example, run the following command on Intel SPR:
> >>>>
> >>>> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> >>>>
> >>>> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
> >>>> precise_ip == 3. It then sets attr.inherit = false, which triggers a
> >>>
> >>> I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
> >>> how did the leader event (mem-loads-aux) succeed with inherit = true
> >>> then?
> >>
> >> Initially, the inherit = true for both the group leader
> >> (cpu/mem-loads-aux/S) and the event in question (cpu/mem-loads,ldlat=3/PS).
> >>
> >> When the second event fails with EINVAL, the current logic calls
> >> evsel__detect_missing_features() first. Since this is a PERF_SAMPLE_READ
> >> event, the inherit attribute falls back to false, according to the
> >> fallback order implemented in evsel__detect_missing_features().
> > 
> > Right, that means the kernel doesn't support PERF_SAMPLE_READ with
> > inherit = true.  How did the first event succeed to open then?
> 
> The perf tool sets PERF_SAMPLE_TID for Inherit + PERF_SAMPLE_READ
> events, as implemented in commit 90035d3cd876 ("tools/perf: Allow
> inherit + PERF_SAMPLE_READ when opening event").
> 
> Meanwhile, commit 7e8b255650fc ("perf: Support PERF_SAMPLE_READ with
> inherit") rejects a perf event if has_inherit_and_sample_read(attr) is
> true and PERF_SAMPLE_TID is not set in attr->sample_type.
> 
> Therefore, the first event succeeded, while the one opened in
> evsel__detect_missing_features() which doesn't have PERF_SAMPLE_TID failed.

Why does the first succeed and the second fail?  Don't they have the
same SAMPLE_READ and SAMPLE_TID + inherit flags?

> 
> 
> >>
> >>>
> >>>> kernel check failure since it doesn't match the group leader's inherit
> >>>> attribute. As a result, it continues to fail even after precise_ip is
> >>>> reduced.
> >>>>
> >>>> By moving the precise_ip fallback earlier, this issue is resolved, as
> >>>> well as the kernel test robot report mentioned in commit
> >>>> c33aea446bf555ab.
> >>>>
> >>>> No negative side effects are expected, because the precise_ip level is
> >>>> restored by evsel__precise_ip_fallback() if the fallback does not help.
> >>>
> >>> I'm not sure.. some events may need a different (i.e. lower) precise
> >>> level than the max.  I think checking the missing feature later will
> >>> use the max precise level always.
> >>
> >> Yes, but seems the basic idea of the event open fallback logic is to
> >> check whether it's lucky enough to open the event by falling back one
> >> single attribute, not multiple attributes.
> >>
> >> evsel__precise_ip_fallback() can restore the precise_ip level after a
> >> failed attempt, while evsel__detect_missing_features() cannot recover
> >> the event attributes from its failed try.
> > 
> > I think precise_ip_fallback() is just a trial and error for each possible
> > value.  While detect_missing_features() checks what the current kernel
> > supports.  Trying different precise_ip values with unsupported attributes
> > doesn't make sense.
> 
> When it returns -EINVAL, the cause could be an unsupported precise_ip or
> something else. We could either end up with "trying different precise_ip
> values with unsupported attributes", or "trying attributes with
> unsupported precise_ip".
> 
> The perf tool’s fallback logic is a “best effort” mechanism to fix only
> one issue, not multiple ones. So, IMO, we should place
> evsel__detect_missing_features() as the last fallback attempt, since it
> does not restore the event attributes after a failed try.

The missing feature check is about the global kernel behavior so there's
no point to try if we know the kernel won't support those features.
While precise fallback is per-PMU (and per-event?) behavior so it'd be
natural to try that after removing must-fail attributes from the missing
feature tests.

Thanks,
Namhyung

> >>
> >> Therefore, falling back precise_ip first maintains the intended
> >> “one-by-one” fallback logic. If it’s placed later, it may combine two
> >> fallbacks, which can cause failures like the example above.  Of course,
> >> in theory, there might be cases where an event can be opened if both
> >> precise_ip and another feature are relaxed together, but I haven’t
> >> exhaustively checked whether such cases actually exist.
> >>
> >>> Thanks,
> >>> Namhyung
> >>>
> >>>>
> >>>> This also aligns with commit 2b70702917337a8d ("perf tools: Remove
> >>>> evsel__handle_error_quirks()").
> >>>>
> >>>> Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
> >>>> Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> >>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> >>>> ---
> >>>>  tools/perf/util/evsel.c | 6 +++---
> >>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>>> index ca74514c8707..6ce32533a213 100644
> >>>> --- a/tools/perf/util/evsel.c
> >>>> +++ b/tools/perf/util/evsel.c
> >>>> @@ -2714,12 +2714,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> >>>>  	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
> >>>>  		goto retry_open;
> >>>>  
> >>>> +	if (evsel__precise_ip_fallback(evsel))
> >>>> +		goto retry_open;
> >>>> +
> >>>>  	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
> >>>>  		goto fallback_missing_features;
> >>>>  
> >>>> -	if (evsel__precise_ip_fallback(evsel))
> >>>> -		goto retry_open;
> >>>> -
> >>>>  out_close:
> >>>>  	if (err)
> >>>>  		threads->err_thread = thread;
> >>>> -- 
> >>>> 2.51.0
> >>>>
> >>
> 
