Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4644508E4
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624582; cv=none; b=Z+PP28gUTIVc2DqmKHWVu4fDIh+rX7V0XGuPaDePJUe7nNMvps/mV+rqaqr2hwVWD6KHL+nURGP4XOudhZ862GUdmPqsq/0GldyoKvre1dIU5Lz44K29JIK8Bkpz55J4oLzao30dmeZyLZ1GFcA2l9Evj1JgnZ3bo6iDxz3PpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624582; c=relaxed/simple;
	bh=qfhyLRaPXn/Brs5tI57ZmQIgYFgDPjJdjPgyEN64EWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h47aLGgAanHISdFvhgVopNglVbruIn94n1XtgdUGJll7biN6MW846kLhSAMilRM5BoFb5seMCjAMo5EA+n8pagpeg+JD+gbfKfqIf3Mev/g/Y5JAOOgCS1y1ZhiXDT4IiM2szYGVM/H0V156lFJGIX7LltWi02LFzTpJam8Mm4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oXp3XwV2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oXp3XwV2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B430C1688;
	Tue, 16 Jun 2026 08:42:54 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8DAD3F62B;
	Tue, 16 Jun 2026 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781624579; bh=qfhyLRaPXn/Brs5tI57ZmQIgYFgDPjJdjPgyEN64EWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXp3XwV2DWq8kpEi9ishP0kOZmxL/sxaoayB+PitRuRHqUjSxtbHkUeTJkDoTwEES
	 z4os8zMgegOcI6dM3MQuSL/Ny3WUdi2Vmgj5AUEzoNeExZNMX53bnIOamppKxu2WYA
	 FP6WPNTAzuzTvmiVNxcpoWeLayGLMmGKfrILtQjE=
Date: Tue, 16 Jun 2026 16:42:56 +0100
From: Leo Yan <leo.yan@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 5/9] perf cs-etm: Use thread-stack for last branch
 entries
Message-ID: <20260616154256.GB31870@e132581.arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-5-f8fad931c413@arm.com>
 <20260616151314.5BBD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616151314.5BBD11F000E9@smtp.kernel.org>

On Tue, Jun 16, 2026 at 03:13:13PM +0000, sashiko-bot@kernel.org wrote:

[...]

> > @@ -2025,7 +1965,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> >  
> >  	/* Reset last branches after flush the trace */
> >  	if (etm->synth_opts.last_branch)
> > -		cs_etm__reset_last_branch_rb(tidq);
> > +		thread_stack__flush(tidq->frontend_thread);
> 
> [Severity: High]
> Can this cause cross-CPU state corruption when flushing shared thread stacks?
> 
> When cs_etm__flush() is called due to a local trace discontinuity or the end of
> a block on a specific trace queue (CPU), it calls thread_stack__flush() on
> the frontend_thread.
> 
> If the traced thread is shared across multiple CPUs (such as the global idle
> thread pid == 0), thread_stack__flush() will iterate over ts->arr_sz and
> reset the branch stacks for all CPUs associated with that thread:
> 
> tools/perf/util/thread-stack.c:thread_stack__flush() {
> 	...
> 	for (pos = 0; pos < ts->arr_sz; pos++) {
> 		int ret = __thread_stack__flush(thread, ts + pos);
> 	...
> }
> 
> This replaces the previously safe localized reset for the trace queue with a
> global flush. Could a localized discontinuity on CPU A silently wipe out the
> active branch stack and callchain history of the shared thread executing
> concurrently on CPU B?

So far, this only affects idle threads across CPUs. In most cases, idle
threads are not the profiling target, and it requires to refactor the
common code that manages idle threads on a per-CPU basis.

I would defer this until there is a clear requirement.

That said, I hope we rather spend time to improve cs-etm discontinuity
issue (from both driver and tooling).
