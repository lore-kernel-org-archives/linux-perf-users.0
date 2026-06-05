Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1513D539;
	Fri,  5 Jun 2026 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702379; cv=none; b=g6dFCb1a4Ot8o/Z24GoR9hSvRa5Oc+YqvyzYwNscEYHJzggF10tcRBzICydYqFD8CaZu8mqK/fg6P1p3tBtGtGhOa9LfvfZ3/fQVxAfJ0R/UVRIWJCaAI03NAt5af9hrdL8y2GDWUASQiMDyMJZLzk5Eeccs7QOf5CERv16J67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702379; c=relaxed/simple;
	bh=1yNcfK7eyF7DBLwdIVKeYx193kANK6dyVC9KCznh3rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dhqn6mn/nEUgx/9C3ZkSUVeESFHZcavtDuB+DMlyhyqXV1DI9ZxWVjW8BEflIcyPWueGWcyOzUyw1JxXpssioyF0YDBRoC0HiMNLn39q6tRztG04U7QqLX56U4fkNdHlHy+br3juYVz+MMQAg5zr4ssGkDfF9THd2upVAB3OVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHvo1NHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHvo1NHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2DB1F00893;
	Fri,  5 Jun 2026 23:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702378;
	bh=bfgZJpXhhPov5BEla8SQNZJSxOSY1OW2cCXZ8taqn9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UHvo1NHtNijnudJ1KexB6x5guYbNU1GMzvAKBjUZA9QZT9CmZlST10TdDrsIYwiAY
	 5o0HeDh93E8wALWemHKpbPWbxqiE+8E5xtK4ytZKDjfIiIflTQm7Zxai4LYF2cuJr4
	 0eJICSZY1mhtX7P/Uk4oM48WSxxlfn7EnNmDM978blxiU7b2oLW4+f3aV0NproT6XY
	 e5DCAZGrRpjTxC3JrM0HKoaKVMI05rCPq3UTMbmWeycbmmkHW62AdR/1auJbuoveWG
	 JXCODT4uSrigJ6hcqzvBjUfNeWJ7qHcep62LwZqIjv7u8f9lzNJ8r9vTGJJz1DBaT5
	 SzeFzeF4dOY6Q==
Date: Fri, 5 Jun 2026 16:32:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf timechart: Release event samples at the end
Message-ID: <aiNcqfkyWo4zPsxC@google.com>
References: <20260605231155.2415760-2-namhyung@kernel.org>
 <20260605232318.218551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605232318.218551F00893@smtp.kernel.org>

On Fri, Jun 05, 2026 at 11:23:17PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Double-free of the `backtrace` string in `timechart__release()` due to shared pointers across multiple `cpu_sample` objects.
> --
> 
> commit 3e2b8bb6971b84cf83df8b57e574d558c36bdaf8
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf timechart: Release event samples at the end
> 
> This commit adds timechart__release() to clean up data structures created
> during sample processing to prevent memory leaks when the perf tool exits.
> 
> > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> > index 28f33e39895d3..73a08236ac299 100644
> > --- a/tools/perf/builtin-timechart.c
> > +++ b/tools/perf/builtin-timechart.c
> [ ... ]
> > @@ -1509,6 +1509,59 @@ static void write_svg_file(struct timechart *tchart, const char *filename)
> >  	svg_close();
> >  }
> >  
> > +static void timechart__release(struct timechart *tchart)
> > +{
> > +	struct per_pid *p = tchart->all_data;
> [ ... ]
> > +		while (c) {
> > +			struct per_pidcomm *next_comm = c->next;
> > +			struct cpu_sample *cs = c->samples;
> > +			struct io_sample *ios = c->io_samples;
> > +
> > +			while (cs) {
> > +				struct cpu_sample *next = cs->next;
> > +
> > +				free((char *)cs->backtrace);
> > +				free(cs);
> > +				cs = next;
> > +			}
> 
> [Severity: High]
> Will this result in a double-free of the backtrace string?
> 
> Looking at sched_switch(), when a context switch occurs between two active
> processes, it shares the exact same backtrace pointer across multiple
> cpu_sample objects:
> 
> if (prev_p->current && prev_p->current->state != TYPE_NONE)
> 	pid_put_sample(tchart, prev_pid, TYPE_RUNNING, cpu,
> 		       prev_p->current->state_since, timestamp,
> 		       backtrace);
> if (p && p->current) {
> 	if (p->current->state != TYPE_NONE)
> 		pid_put_sample(tchart, next_pid, p->current->state, cpu,
> 			       p->current->state_since, timestamp,
> 			       backtrace);
> 
> Because timechart__release() iterates over all processes and unconditionally
> calls free() on cs->backtrace, won't it attempt to free the same pointer 
> multiple times when it cleans up these overlapping samples?

Actually this is handled in another series.

Thanks,
Namhyung

