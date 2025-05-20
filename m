Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C451288C04;
	Tue, 20 May 2025 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771352; cv=none; b=VYTY5pKD0rZOMGsWqkAhw/B2J9QGxBb2D4jNtrxl8Xxq7Swa6dYzH2ffBcVVWhQEB+jktFCCcYx7pTjk6qtMSx1g5xN5gtewdYD6S7lJlI/jK1xlTyAoNlnW+rzXJyjtEn5sfdK/eYT62xDbYhnrRyUqRD4Bq+aIx95W/89vhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771352; c=relaxed/simple;
	bh=gdB/aUFh/EfFdDW3zJSjo8/8Qk4K6QKnp6agplPsdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLtybYrY4HZDuhkpiwRTQ27HzLxYW0xTJI1LjA3Ys6va7Mp0ZFaONVVKS+EcWBY9EUjMu9spJxBd6Epe8Ap6WFFL0wGelUZft35Wc/qpu6llqYEP2TwvuYu7AULoHPyaLmPHuL9Psh3LGuKMjyzkWoaiCOzPzO6/gYshByN7Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h60fgItG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h60fgItG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDA2C4CEE9;
	Tue, 20 May 2025 20:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747771351;
	bh=gdB/aUFh/EfFdDW3zJSjo8/8Qk4K6QKnp6agplPsdH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h60fgItGfIxOvadalfWdc89HnSZCZc5zitiLlB9I1kbjYZXWYnXyVW8On1otNd0QB
	 InUVV/ltU7pYux8T6wVDbWmRbfxJNW9js1LTNuWoOLd2tsBlY5ia1+XK8QwH6poSx9
	 R6p16ovf2o8fMKugEQm6GPdctTs0RaERTNPTyIQ20FfPKgIviSOfWVFrHSHxOyXVDB
	 Q+Um+3T1FzBF9A6zAjMrsWEOKPdAMCdl6z+dizRQJSYQEVdMVYULmbleXXa0Y3j56G
	 m9VlTpVueZqkikflfbRP1QlViR0/DMNqw7euvRZWk0HpfZfKNt60o1inAxX7INCa8K
	 tnk+xC8WFERKw==
Date: Tue, 20 May 2025 13:02:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, irogers@google.com,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, eranian@google.com,
	ctshao@google.com, tmricht@linux.ibm.com, leo.yan@arm.com
Subject: Re: [PATCH V3 02/16] perf: Fix the throttle logic for a group
Message-ID: <aCzf1epMZn20K55q@google.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
 <20250516182853.2610284-3-kan.liang@linux.intel.com>
 <aCoynoKRbpnOZ7QE@google.com>
 <8e2c5349-571d-4436-a10e-ae1a50ed6b1f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e2c5349-571d-4436-a10e-ae1a50ed6b1f@linux.intel.com>

On Tue, May 20, 2025 at 10:47:21AM -0400, Liang, Kan wrote:
> 
> 
> On 2025-05-18 3:18 p.m., Namhyung Kim wrote:
> > Hi Kan,
> > 
> > On Fri, May 16, 2025 at 11:28:39AM -0700, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The current throttle logic doesn't work well with a group, e.g., the
> >> following sampling-read case.
> >>
> >> $ perf record -e "{cycles,cycles}:S" ...
> >>
> >> $ perf report -D | grep THROTTLE | tail -2
> >>             THROTTLE events:        426  ( 9.0%)
> >>           UNTHROTTLE events:        425  ( 9.0%)
> >>
> >> $ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> >> 0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
> >> ... sample_read:
> >> .... group nr 2
> >> ..... id 0000000000000327, value 000000000cbb993a, lost 0
> >> ..... id 0000000000000328, value 00000002211c26df, lost 0
> >>
> >> The second cycles event has a much larger value than the first cycles
> >> event in the same group.
> >>
> >> The current throttle logic in the generic code only logs the THROTTLE
> >> event. It relies on the specific driver implementation to disable
> >> events. For all ARCHs, the implementation is similar. Only the event is
> >> disabled, rather than the group.
> >>
> >> The logic to disable the group should be generic for all ARCHs. Add the
> >> logic in the generic code. The following patch will remove the buggy
> >> driver-specific implementation.
> >>
> >> The throttle only happens when an event is overflowed. Stop the entire
> >> group when any event in the group triggers the throttle.
> >> The MAX_INTERRUPTS is set to all throttle events.
> >>
> >> The unthrottled could happen in 3 places.
> >> - event/group sched. All events in the group are scheduled one by one.
> >>   All of them will be unthrottled eventually. Nothing needs to be
> >>   changed.
> >> - The perf_adjust_freq_unthr_events for each tick. Needs to restart the
> >>   group altogether.
> >> - The __perf_event_period(). The whole group needs to be restarted
> >>   altogether as well.
> >>
> >> With the fix,
> >> $ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> >> 0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
> >> ... sample_read:
> >> .... group nr 2
> >> ..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
> >> ..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0
> > 
> > Thanks for working on this!
> > 
> >>
> >> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  kernel/events/core.c | 60 ++++++++++++++++++++++++++++++++------------
> >>  1 file changed, 44 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index af78ec118e8f..52490c2ce45b 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -2739,6 +2739,39 @@ void perf_event_disable_inatomic(struct perf_event *event)
> >>  static void perf_log_throttle(struct perf_event *event, int enable);
> >>  static void perf_log_itrace_start(struct perf_event *event);
> >>  
> >> +static void perf_event_unthrottle(struct perf_event *event, bool start)
> >> +{
> >> +	event->hw.interrupts = 0;
> >> +	if (start)
> >> +		event->pmu->start(event, 0);
> >> +	perf_log_throttle(event, 1);
> >> +}
> >> +
> >> +static void perf_event_throttle(struct perf_event *event)
> >> +{
> >> +	event->pmu->stop(event, 0);
> >> +	event->hw.interrupts = MAX_INTERRUPTS;
> >> +	perf_log_throttle(event, 0);
> >> +}
> >> +
> >> +static void perf_event_unthrottle_group(struct perf_event *event, bool skip_start_event)
> >> +{
> >> +	struct perf_event *sibling, *leader = event->group_leader;
> >> +
> >> +	perf_event_unthrottle(leader, skip_start_event ? leader != event : true);
> >> +	for_each_sibling_event(sibling, leader)
> >> +		perf_event_unthrottle(sibling, skip_start_event ? sibling != event : true);
> > 
> > This will add more PERF_RECORD_THROTTLE records for sibling events.
> 
> Yes
> 
> > Maybe we can generate it for the actual target event only?
> 
> The current code cannot track the actual target event for unthrottle.
> Because the MAX_INTERRUPTS are set for all events when event_throttle.

Right.

> 
> But I think we can only add a PERF_RECORD_THROTTLE record for the leader
> event, which can reduce the number of THROTTLE records.

Sounds good.

> 
> The sample right after the THROTTLE record must be generated by the
> actual target event. I think it should be good enough for the perf tool
> to locate the event.

IIRC perf tool doesn't track which event is throttled, but yeah, it'd be
possible to use the next sample to locate it.

> 
> I will add the below patch as a separate improvement in V4.
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 52490c2ce45b..cd559501cfbd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2744,14 +2744,16 @@ static void perf_event_unthrottle(struct
> perf_event *event, bool start)
>   	event->hw.interrupts = 0;
>   	if (start)
>   	event->pmu->start(event, 0);
> -	perf_log_throttle(event, 1);
> +	if (event == event->group_leader)
> +		perf_log_throttle(event, 1);
>   }
> 
>   static void perf_event_throttle(struct perf_event *event)
>   {
>   	event->pmu->stop(event, 0);
>   	event->hw.interrupts = MAX_INTERRUPTS;
> -	perf_log_throttle(event, 0);
> +	if (event == event->group_leader)
> +		perf_log_throttle(event, 0);
>   }

Looks good.

> 
> 
> > 
> > Also the condition for skip_start_event is if it's a freq event.
> > I think we can skip pmu->start() if the sibling is also a freq event.
> 
> The skip_start_event is if it will be start later separately. It intends
> to avoid the double start.
> 
> In the perf_adjust_freq_unthr_events(), it will only adjust and start
> the leader event, not group. If we skip pmu->start() for a freq sibling
> event, it will not start until the next context switch.

Oh, I missed that it only has leaders in the active list.

Thanks,
Namhyung

