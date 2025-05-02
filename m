Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C43224B04;
	Fri,  2 May 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187142; cv=none; b=ECZLyGd7oREry9lB8ieMxdYbkFJU5mIocI+f0HtB+pnwgAWut/UbdTIhTzX9Xei0SCA+1tovtXDpCKV8nSS8DUkbirC7wU3e8qTkphpN1vHI1Lviq3hhxGApysuTKwrHx7k9/AU/pUquqE5UrsnkNo/bQQv263bdHew6pfLQEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187142; c=relaxed/simple;
	bh=RwgCDnQ37EObTe/l83jABDwxgXSvAaJZEbvdls3xVr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWLk3vxUMVeLI8IFKPDS/y1XTOFhvqA+K/f8xFvKJLta1bOsKkuWvi0VzPC9H1kVuNpDZUozmR07285HntIyq6wjEsmVi3LZpYo4I5/t50tg/laU2fdj6MWy2M+j0SQD36fJDfrRCFbLuqMK8G+lwUB3OZNyMzcLEVxACTon+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGa1Ng9Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGa1Ng9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B625C4CEE4;
	Fri,  2 May 2025 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746187141;
	bh=RwgCDnQ37EObTe/l83jABDwxgXSvAaJZEbvdls3xVr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGa1Ng9QOwviHBkEzyjbOGYNSiaM+mQvYc/nKz5Qq0XA5Ed2TF+IDD3zAle2bWPdU
	 FCUJ+eO6qbLOQPVmSkan8UqqI/iL2k480/lmex0DBsLSvkSRxWjVSBZtGpWBAr5qHD
	 xxVDPLnci9qhq1FMTuzQSdcwb2MdxiLNTJb1XLjqiwfPXVMkQ4A5rSfxvLcOfld3td
	 mWCIPO8LhRD9al7AiChjH4W7mEdhaBf3pWzJ7zMWmVs9uq+p9xDiyHsr4/bRXvpeQK
	 nNrBe5h6EgaivhdZqPTBRRrZBEGe44BQDC2NQhVoAbhV9xdnxFAsnfzPj5aYGpx+NT
	 npmxlfiAvqsEA==
Date: Fri, 2 May 2025 13:58:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf: Fix irq work dereferencing garbage
Message-ID: <aBSzgrz9zTaFW5dj@pavilion.home>
References: <20250424161128.29176-1-frederic@kernel.org>
 <20250424161128.29176-3-frederic@kernel.org>
 <20250424163024.GC18306@noisy.programming.kicks-ass.net>
 <aA9ic6m6WAcmVBAw@pavilion.home>
 <20250502102918.GW4198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502102918.GW4198@noisy.programming.kicks-ass.net>

Le Fri, May 02, 2025 at 12:29:18PM +0200, Peter Zijlstra a écrit :
> > @@ -13951,18 +13943,25 @@ perf_event_exit_event(struct perf_event *event,
> >  	/*
> >  	 * Child events can be freed.
> >  	 */
> > -	if (is_child) {
> > -		if (parent_event) {
> > -			mutex_unlock(&parent_event->child_mutex);
> > -			/*
> > -			 * Kick perf_poll() for is_event_hup();
> > -			 */
> > -			perf_event_wakeup(parent_event);
> > +	if (parent_event) {
> > +		mutex_unlock(&parent_event->child_mutex);
> > +		/*
> > +		 * Kick perf_poll() for is_event_hup();
> > +		 */
> > +		perf_event_wakeup(parent_event);
> 
> Should not this perf_event_wakeup() be inside the next if() as well?
> doing anything on parent_event when !ATTACH_CHILD seems dodgy.

Good point!

> 
> > +
> > +		/*
> > +		 * Match the refcount initialization. Make sure it doesn't happen
> > +		 * twice if pmu_detach_event() calls it on an already exited task.
> > +		 */
> > +		if (attach_state & PERF_ATTACH_CHILD) {
> >  			/*
> >  			 * pmu_detach_event() will have an extra refcount.
> > +			 * perf_pending_task() might have one too.
> >  			 */
> >  			put_event(event);
> >  		}
> > +
> >  		return;
> >  	}
> 
> This is a *much* saner patch, thank you!
> 
> So the thing I worried about... which is why I chose for the TOMBSTONE
> thing, is that this second invocation will now dereference parent_event,
> even though we've already released our reference count on it. 
> 
> This is essentially a use-after-free.
> 
> The thing that makes it work is RCU. And I think we're good, since the
> fail case is two perf_event_exit_event() invocations on the same event,
> separated by an RCU grace period, and I don't think this can happen.
> 
> But its a shame we can't reliably detect that.. Oh well.

It's not RCU but the reference count of the child that protects it.
In a second invocation, pmu_unregister() still holds a reference to
the child and that protects the parent as well because the reference
to the parent is only dropped once the child has dropped its own.

Hopefully that is one less opportunity for a headache :-)

-- 
Frederic Weisbecker
SUSE Labs
