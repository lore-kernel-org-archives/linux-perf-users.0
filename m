Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA2280319;
	Wed,  4 Jun 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024233; cv=none; b=BCFg0hSwnrtvh992TjxrL5+j8Bn5Yob/sQB/wzr9boZB8bTcZfCDSFAdlNNT9q7cUGo20wK2JuOQ8PY9qyPLzyaI1yQGx3kw20ZhVOvZ9k/UUW8APlFZNbW7PBqrcezP9NlLf2miQg1/u/BxV3o382AK6UsPCCzaOk2sqFVT9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024233; c=relaxed/simple;
	bh=s/lHWPOo8ujarL1wxZGVeaoXIYtuWp17/aQ4Lkb8WCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5bzdRymTH7SHjGxKpE1VGiq4HILcYXbA8xbGKxj+Qpq2q/IJ2PncoRg656BISblG4ro0KQNs8+CqV7DMyZa4ZCXIwra9NkDwq1Mg9w3Vw9zPOR8x23y/N3gktiTPKpjo8BYltpw5mrnivmN5QnwiTIj0Tgue3PJbqdZOmIvatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ui2E3wyr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ui2E3wyr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xaoyFvQwKIYu5nwGYw5DvgtC4POUAUMRWFKFbgDSrok=; b=Ui2E3wyrhSiR5tHo0yMCvpVDdF
	mUsAC6iyWpkXI/qjlE2oww60KX+PxnfJi/wz503G49Lf7cIwi1EgBuziRm4yo6jnHV5KyXO4Cv7nd
	OEoTrX1g2Vee07PGHOMvHpBLh5qiLzGsXMoFgdjHxc5KG/wFZGPcEpVql6BBEy4Y9FEFJRweIDqkv
	GcaaFxDJUh5n+fvlKTbLtFIoqFmfm+TbFrtnh78jdBYcSEtFnWdaYPJJw9kwVFi87LmBO/bcVfP/6
	Ps3vnepcRRjYAvhr9pXKfRSYtK551PkxesLqigESqveDZtC3UscllDc6/gH+u8QBaeJLF25wYhgy8
	lDw12ntA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMj64-00000002tPO-1hgL;
	Wed, 04 Jun 2025 08:03:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C6763300787; Wed,  4 Jun 2025 10:03:39 +0200 (CEST)
Date: Wed, 4 Jun 2025 10:03:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604080339.GB35970@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603144414.GC38114@noisy.programming.kicks-ass.net>

On Tue, Jun 03, 2025 at 04:44:14PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 03, 2025 at 03:00:40PM +0100, Leo Yan wrote:
> 
> > > +	if (event->state > PERF_EVENT_STATE_OFF)
> > > +		perf_cgroup_event_disable(event, ctx);
> > > +
> > 
> > As we discussed, seems to me, the issue is caused by an ambigous state
> > machine transition:
> > 
> > When a PMU event state is PERF_EVENT_STATE_EXIT, the current code does
> > not transite the state to PERF_EVENT_STATE_OFF. As a result, the
> > list_del_event() function skips to clean up cgroup pointer for non OFF
> > states. This is different from the code prior to the commit a3c3c6667,
> > which transits states EXIT -> INACTIVE -> OFF.
> 
> Right.
> 
> > My suggestion is not reliable. Roughly read code, except for the
> > PERF_EVENT_STATE_EXIT case, I think other error cases should also clean
> > up the cgroup pointer.  The reason is I don't see other places to
> > clean up the cgroup pointer for these error cases:
> > 
> >   PERF_EVENT_STATE_REVOKED
> >   PERF_EVENT_STATE_DEAD
> 
> Those should be done here; on the first transition into these states.
> 
> > Only in the PERF_EVENT_STATE_ERROR state, we don't need to cleanup
> > cgroup as this has already been handled in merge_sched_in().
> > 
> > So a correct condition would be:
> > 
> >     if (event->state > PERF_EVENT_STATE_OFF ||
> >         event->state <= PERF_EVENT_STATE_EXIT)
> >         perf_cgroup_event_disable(event, ctx);
> 
> I'm too tired to get my head straight. I'll look tomorrow.


Right; had a sleep. Lets do this :-)


So the normal states are:

	    ACTIVE    ---.
	       ^         |
	       |         |
       sched_{in,out}()  |
	       |         |
	       v         |
      ,---> INACTIVE  <--+
      |                  |
      |            {dis,en}able()
  sched_in()             |
      |       OFF     <--+
      |                  |
      `--->  ERROR    ---'

That is:

sched_in:	INACTIVE          -> {ACTIVE,ERROR}
sched_out:	ACTIVE            -> INACTIVE
disable:	{ACTIVE,INACTIVE} -> OFF
enable:         {OFF,ERROR}       -> INACTIVE

Where OFF/ERROR are 'disable' and have this perf_cgroup_event_disable()
called.

Then we have {EXIT,REVOKED,DEAD} states which are various shades of
defunct events:

 - EXIT means task that the even was assigned to died, but child events
   still live, and further children can still be created. But the event
   itself will never be active again. It can only transition to
   {REVOKED,DEAD};

 - REVOKED means the PMU the event was associated with is gone; all
   functionality is stopped but the event is still alive. Can only
   transition to DEAD;

 - DEAD event really is DYING tearing down state and freeing bits.

And now we have the sitation that __perf_remove_from_context() can do:

  {ACTIVE,INACTIVE,OFF,ERROR} -> {OFF,EXIT,REVOKED,DEAD}

Where the {OFF,ERROR} -> * transition already have
perf_cgroup_event_disable(), but the {ACTIVE,INACTIVE} -> * part has
not.

The condition:

  if (event->state > PERF_EVENT_STATE_OFF)

captures exactly that {ACTIVE,INACTIVE} that still needs the cgroup
disable. Every other state is already a disabled state.


Agreed?

Also, I should probably stick most of all this in a comment somewhere.
