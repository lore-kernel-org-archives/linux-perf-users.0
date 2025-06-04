Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045256B81;
	Wed,  4 Jun 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032310; cv=none; b=ueiNymQJqlrJw2DdB8vqxX9Fo1bZYDew6Q5Jlun/J1+wJoXhPVIM7QLseA2y8xfhbKkc9yoPX3TZ+iR7XZ1G/g9dRlYlohEte4rIGzI6Ip/9DLoDdrLTlQFFvH+Uo74ds/+6M+SENDw0Tyc4YAkKAyFzsUOSAK00GdfSNKB3148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032310; c=relaxed/simple;
	bh=3HHpt7djO8MsGfUXUzePpCpx/Fnuo9SaY/kGssvfXMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHostD71q/RtEBec1kDU2lcLYr2jYHzjry81tp/tHFg+EoeDJHacv+9fTba4zTW9C7z600B+psp6SDPr2A71Ca8mnF+t6eJ/wzvWMhhwAGkwHWCj2GT8Ki7/FToCm1ODnJ1ipsLyXt4xYU7tYyhJFf35RwL9TCb0+tMcBAqFit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A8311758;
	Wed,  4 Jun 2025 03:18:10 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D59CE3F673;
	Wed,  4 Jun 2025 03:18:26 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:18:21 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604101821.GC8020@e132581.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604080339.GB35970@noisy.programming.kicks-ass.net>

On Wed, Jun 04, 2025 at 10:03:39AM +0200, Peter Zijlstra wrote:

[...]

> > > My suggestion is not reliable. Roughly read code, except for the
> > > PERF_EVENT_STATE_EXIT case, I think other error cases should also clean
> > > up the cgroup pointer.  The reason is I don't see other places to
> > > clean up the cgroup pointer for these error cases:
> > > 
> > >   PERF_EVENT_STATE_REVOKED
> > >   PERF_EVENT_STATE_DEAD
> > 
> > Those should be done here; on the first transition into these states.
> > 
> > > Only in the PERF_EVENT_STATE_ERROR state, we don't need to cleanup
> > > cgroup as this has already been handled in merge_sched_in().
> > > 
> > > So a correct condition would be:
> > > 
> > >     if (event->state > PERF_EVENT_STATE_OFF ||
> > >         event->state <= PERF_EVENT_STATE_EXIT)
> > >         perf_cgroup_event_disable(event, ctx);
> > 
> > I'm too tired to get my head straight. I'll look tomorrow.
> 
> 
> Right; had a sleep. Lets do this :-)

Thanks a lot for the state machine diagram.

> So the normal states are:
> 
>             ACTIVE    ---.
>                ^         |
>                |         |
>        sched_{in,out}()  |
>                |         |
>                v         |
>       ,---> INACTIVE  <--+
>       |                  |
>       |            {dis,en}able()
>   sched_in()             |
>       |       OFF     <--+
>       |                  |
>       `--->  ERROR    ---'
> 
> That is:
> 
> sched_in:     INACTIVE          -> {ACTIVE,ERROR}

Strictly speaking, sched_in() can keep INACTIVE state if an event is
rotated.

> sched_out:    ACTIVE            -> INACTIVE
> disable:      {ACTIVE,INACTIVE} -> OFF
> enable:       {OFF,ERROR}       -> INACTIVE
> 
> Where OFF/ERROR are 'disable' and have this perf_cgroup_event_disable()
> called.
> 
> Then we have {EXIT,REVOKED,DEAD} states which are various shades of
> defunct events:
> 
>  - EXIT means task that the even was assigned to died, but child events
>    still live, and further children can still be created. But the event
>    itself will never be active again. It can only transition to
>    {REVOKED,DEAD};
> 
>  - REVOKED means the PMU the event was associated with is gone; all
>    functionality is stopped but the event is still alive. Can only
>    transition to DEAD;
> 
>  - DEAD event really is DYING tearing down state and freeing bits.
> 
> And now we have the sitation that __perf_remove_from_context() can do:
> 
>   {ACTIVE,INACTIVE,OFF,ERROR} -> {OFF,EXIT,REVOKED,DEAD}

A detailed transition is:

  Case 1: {ACTIVE} -> {INACTIVE} -> {OFF,EXIT,REVOKED,DEAD}
  Case 2: {ERROR} -> {ERROR,EXIT,REVOKED,DEAD}
  Case 3: {OFF} -> {OFF,EXIT,REVOKED,DEAD}

> Where the {OFF,ERROR} -> * transition already have
> perf_cgroup_event_disable(), but the {ACTIVE,INACTIVE} -> * part has
> not.

Just a minor concern.

I noticed perf_put_aux_event() sets the ERROR state for sibling events
of an AUX event. IIUC, the AUX event is the group leader, so we only
need to clean up the cgroup pointer for the AUX event, and simply set
the ERROR state for its sibling events, correct?

> The condition:
> 
>   if (event->state > PERF_EVENT_STATE_OFF)
> 
> captures exactly that {ACTIVE,INACTIVE} that still needs the cgroup
> disable. Every other state is already a disabled state.
> 
> 
> Agreed?

Except above concern, otherwise, the conclusion makes sense to me.

> Also, I should probably stick most of all this in a comment somewhere.

Totally agree. The comment would be very useful!

Thanks,
Leo
