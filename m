Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFF1DFDE;
	Fri, 16 May 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399914; cv=none; b=YZas9BSWcb62oTO2sNk5S68jW5siialN9cskrizuqYnrEUM1T9pGLEPB0LsROf5jNt6ge5k0Ps8CmEzvgbylVkDn3SmDtctsUMbrUllJZ5c94M+VM6bgvwYGhyPHsW42QSXuvOfW8jOTspzO+nYS38pOKfzMBInvSJ6PHNRVoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399914; c=relaxed/simple;
	bh=qWHagNLgKywh+R7HpZi0DiyWCx5YErHXT4uvwdR4c9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/WmcQMyML+mOqwwH1G9GF5XsPqPQXsleWAN+8rjbWFZWsLCXkNziVX5OtlOU8U6c/cRGOldomC8DW9lFh31tuuLfCqCQ1PXOR7dKS3w3HveANV78BZjezmIntYl3Y5Cv6+gbqmp5hU7nj7k3UJIrBvErVdFCIhavl36Ud6VHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7686B169C;
	Fri, 16 May 2025 05:51:39 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069643F673;
	Fri, 16 May 2025 05:51:50 -0700 (PDT)
Date: Fri, 16 May 2025 13:51:46 +0100
From: Leo Yan <leo.yan@arm.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com
Subject: Re: [PATCH V2 01/15] perf: Fix the throttle logic for a group
Message-ID: <20250516125146.GE412060@e132581.arm.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
 <20250514151401.2547932-2-kan.liang@linux.intel.com>
 <20250515094300.GC412060@e132581.arm.com>
 <4a44b8cb-7c73-4926-8b9f-1f63929ea48f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a44b8cb-7c73-4926-8b9f-1f63929ea48f@linux.intel.com>

On Thu, May 15, 2025 at 08:55:05AM -0400, Liang, Kan wrote:

[...]

> >> +static void perf_event_unthrottle_group(struct perf_event *event, bool start)
> >> +{
> >> +	struct perf_event *sibling, *leader = event->group_leader;
> >> +
> >> +	perf_event_unthrottle(leader, leader != event || start);
> >> +	for_each_sibling_event(sibling, leader)
> >> +		perf_event_unthrottle(sibling, sibling != event || start);
> > 
> > Seems to me that the condition "leader != event || start" is bit tricky
> > (similarly for the check "sibling != event || start").
> > 
> > If a session sets the frequency (with option -F in perf tool), the
> > following flow is triggered:
> > 
> >   perf_adjust_freq_unthr_events()
> >     `> perf_event_unthrottle_group(event, false);
> > 
> > The argument "start" is false, so all sibling events will be enabled,
> > but the event pointed by the "event" argument remains disabled.  
> 
> Right. Because the following code will adjust the period of the event
> and start it.
> The PMU is disabled at the moment. There is no difference in starting
> the leader first or the member first.

Thanks for explaination. In the case above, as you said, all events will
be enabled either in perf_event_unthrottle_group() or in
perf_adjust_freq_unthr_events() with a recalculated period.

Just a minor suggestion. Seems to me, the parameter "start" actually
means "only_enable_sibling". For more readable, the function can be
refine as:

static void perf_event_unthrottle_group(struct perf_event *event,
                                        bool only_enable_sibling)
{
	struct perf_event *sibling, *leader = event->group_leader;

	perf_event_unthrottle(leader,
                only_enable_sibling ? leader != event : true);
        ...
}

Thanks,
Leo
