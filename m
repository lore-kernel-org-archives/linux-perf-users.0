Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCD1D63C7;
	Thu,  5 Jun 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122972; cv=none; b=mhqLpn02SWqrIGITa0ArHWEAslR0sewOrV7Er0cKYgdB0vKrRQceGA7cslH+1imSVOrvoPJ9lyFE8pHSLTJw3rQojFYV6d9y1kpoqhc8U1Vu/Ar1P/l/Ov/BYnuNIt7lUvwv0EXsd7mv/Kq9DYwfcfTWJafMM6zdparMsxZQfKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122972; c=relaxed/simple;
	bh=keFCUiiYXh91U4xTipO8BIMtTgha35W/CKZZ5Gh6W+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJHkM0/naK5YxWuOAGhP0GhBYCukbnqKlLHlgOJL6DwKa6rG/oFxHurm9ise9D+NoFSZbSJV5zzTE8BaltmjMUjEvrXvJ4EKkEXNtMU73QCCMtiTu+20x2Kh9jlEKwBpCRDlwAhNdzXLCVDXFpgKDAdfQ+vPehInIZfR3a/5nYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qw9gDO8R; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qw9gDO8R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WqixUjhn8x3j9PoWAdaiUBk4NGYFB5LGObX47NMD4ow=; b=qw9gDO8RsldwTGSQ54FzLCi/9p
	kDZXyAVf7vb+FEg2VCLq4l/N5bRv8VZDDgzuwZUu8uRuEYIdphhp8beqw9iIjoUq4WTvzfRMzYn/E
	WRoUksBDw2ZKzW76bMw/cyGz9mG5uOcdBnayzGpKDuJIu6RArR3YjIwHHnYi3AeHzn91ZG5MeTbmg
	Er3sllKN9Eka6xwwVBSWlPuxaQDmSiAGzbM2kbHMWygoPn3CqS8rnr+XYy4aEuOs8bAVz3ma7XOgz
	0BFXngN9e683TX14T/pNCJEWY+78++K5CeoZTbfMRzRHt0r0cvDDPeGaR7kug7pG2B2OAc5FFaH1q
	cxknz9EA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN8mg-000000019Y4-0PSS;
	Thu, 05 Jun 2025 11:29:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BEC13005AF; Thu,  5 Jun 2025 13:29:21 +0200 (CEST)
Date: Thu, 5 Jun 2025 13:29:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250605112921.GR39944@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
 <20250604141640.GL38114@noisy.programming.kicks-ass.net>
 <20250604154639.GE8020@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604154639.GE8020@e132581.arm.com>

On Wed, Jun 04, 2025 at 04:46:39PM +0100, Leo Yan wrote:
> On Wed, Jun 04, 2025 at 04:16:40PM +0200, Peter Zijlstra wrote:
> 
> [...]
> 
> > It might be prudent to do something like so:
> 
> Thanks for the patch.
> 
> > +static void __event_disable(struct perf_event *event,
> > +			    struct perf_event_context *ctx,
> > +			    enum perf_event_state state)
> > +{
> > +	if (event == event->group_leader)
> > +		group_sched_out(event, ctx);
> 
> I am a bit struggle for this code line. It disables all events in a
> group, but only clear cgroup pointer for group leader but miss to clear
> for sibling events.

What happens is that perf_event_disable() will only mark the group
leader as OFF. By having the group leader marked OFF, the whole group
becomes ineligible to run. But the siblings are still INACTIVE and thus
don't need to get perf_cgroup_event_disable() called.

perf_event_enable() does the symmetric thing, it only marks the group
leader INACTIVE (and then tries to schedule it, possibly resulting in
ACTIVE).

Now, it is entirely possible to call {dis,en}able() on siblings, in
which case only the sibling gets marked OFF and gets scheduled out, but
the rest of the group can continue functioning.

So I think this was indeed correct.

> If the cgroup pointer is only used for group leader, maybe we only
> maintain (set and clear) the cgroup pointer for the leader?

And the patch re-used this function on siblings, do it would never hit
this group_sched_out() case.

But yes, slightly confusing. Let me see if I can make a less confusing
patch, and if not, sprinkle comments.
