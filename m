Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24A52F29A;
	Tue, 29 Sep 2026 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693593; cv=none; b=stWuFh0jxy5clW8M5J6Hgx7gCxBdENBr7KCMHYmqagcRM9i6B9nhc5LQWQgValyxc/TyIDruc+qDgrDxegH85qNjcDzW3vnvLKripw2JorUp9AJpdSQVNLvgYBDxmh/QtyT2ZmdE2z6zS+D/WT/KcUABwOWWMWxoDb5Z8/ARN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693593; c=relaxed/simple;
	bh=xe0u2OqcNn3XLy6J5fEP3c71Qbz5WPCvV1bZlG39UNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdTbRVSuVuE7o54HcNbfWf0sXINcHivlc6FtDnwvP38xUMxAMnmf3UNQPxq6RzxVjebuvsBcpaT43hvTM16UfoIZXn3tASMUAlLEccXAA3oNkkiTY2mWsLxSfuODCOUnTVeRa945iCUFEyMGbb2d3vM3tA4z1FpD7IMYOHrq/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RJf75crA; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RJf75crA"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4721516;
	Tue, 29 Sep 2026 07:53:03 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B4123F86F;
	Tue, 29 Sep 2026 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790693587; bh=xe0u2OqcNn3XLy6J5fEP3c71Qbz5WPCvV1bZlG39UNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJf75crAw12LpUzgMwjbb2pnc0M07hmf/YC4DUYUj6h76MCPo1QPjoyZbYMUBv6i1
	 ZvODaa7mSdPZ+0iI/UnFcUxhMiiRxb8xS9RM6hHIDUT0KZph4CAeN0BAc5KOtTDJt4
	 6zkel5aGVO3z4zJq84cV0h0Jx2tHyg1Hi/mhy/H0=
Date: Tue, 29 Sep 2026 15:53:05 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko AI <sashiko-bot@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf/core: Fix ITRACE start suppression for inherited
 events
Message-ID: <20260929145305.GI14479@e132581.arm.com>
References: <20260903-perf_core_itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com>
 <f0aa7195-9c79-4ac7-8bb0-d508927a01cf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0aa7195-9c79-4ac7-8bb0-d508927a01cf@linaro.org>

On Mon, Sep 28, 2026 at 10:38:42AM +0100, James Clark wrote:
> 
> On 03/09/2026 10:35, Leo Yan wrote:
> > PMU drivers call perf_event_itrace_started() for the event that has
> > started tracing. This sets PERF_ATTACH_ITRACE in that event's
> > attach_state.
> > 
> > For inherited events, however, perf_log_itrace_start() replaces the
> > child event with its parent before checking PERF_ATTACH_ITRACE. The
> > setter and checker therefore operate on different events. If the
> > parent's flag is clear, the child continues to emit ITRACE_START
> > records on subsequent schedule-ins. If the parent has already started,
> > its flag can instead suppress the child's initial record.
> 
> This last part would need an earlier fixes: commit. The problem of
> suppressing child ITRACE_START records existed since the beginning on
> ec0d772 ("perf: Add ITRACE_START record to indicate that tracing has
> started").
> 
> Although the fixes: commit would be correct if the only problem was that
> setting and getting are on different events.

Makes sense. However, if follow your suggestion to change the setter to
fix the setter/checker mismatch, 9a6694cfa239 remains the appropriate
Fixes tag, since it introduced that mismatch; and it is a feasible
point for back port.

> > Remove the parent substitution so that perf_log_itrace_start() checks
> > the same event that the PMU driver marks as started.
> > 
> > This is safe for tool consumers. Intel PT uses the ITRACE_START record
> > to set the current thread context. CoreSight ETM uses the record only
> > to find or create the corresponding thread. Neither decoder depends on
> > the parent event.
> > 
> 
> It's probably harmless to emit more ITRACE_STARTs, but it doesn't fit the
> original purpose of why it was added. It seems to be for when tracing first
> starts, which would be _after_ the corresponding sched event. Once tracing
> has started you can follow the subsequent sched events, so you don't need
> more ITRACE_START records for each child. Could we not fix it by changing
> the setter to follow the parent event to match, which would respect the
> original meaning?

My concern was whether an inherited event and its parent could trace
concurrently on different CPUs.

Normal inherited AUX recording uses CPU restricted events (cpu != -1),
children inherit the parent event’s CPU restriction, a particular parent
event and its children cannot trace concurrently on different CPUs.

Since inherit with cpu == -1 prevents buffer mapping [1], my concern for
this case is also not valid.

I will update the patch to update setter. Thanks for suggestion.

[1] https://man7.org/linux/man-pages/man2/perf_event_open.2.html
