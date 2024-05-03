Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2D57CAF
	for <linux-perf-users@vger.kernel.org>; Fri,  3 May 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741695; cv=none; b=PmXEFI0RYNzxFfUfv/HLYJ8XyII3hZpi3GKSz2ixcSskZL99wYl2GOfBWz3XOZHpvMG0eA9Q7GOzdbGvPWvTNDWRhv3WG9kYp1pwX5W4MTbOT4k2gk0xES6JLFIhFGE2/6N1MSDf/pSYgyzytWIRsVFU1+FAqtERfHPRNideqkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741695; c=relaxed/simple;
	bh=4UdNEYFwFzTPZWMT3rkYKsaF/Kmv6wUwSmEqp4s0JKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9K2kTyK2Md2+kq5WP3xYsWuPSidaiJboOTR4PUbkrWAV6NkTpB3PxgCYZEUch2WEuUaLItfDngKiY/6xbw6qOs1WhumO8BRm69IngONmTeg81MRgY7k6aiRw67/IcfY1bzh7ZiByysV+7yoeNq/WWko52DfDWz0mQBeCpBdWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCoA0FZq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCoA0FZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A24BC116B1;
	Fri,  3 May 2024 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714741695;
	bh=4UdNEYFwFzTPZWMT3rkYKsaF/Kmv6wUwSmEqp4s0JKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCoA0FZq+h/tzyoUU3scphjETM71272U0q6uYgm2DwotsIjGNgVrImG+G+wPwJO+x
	 zHaLmqRwpSzRFGB4hQBzIZfheE0UP1szXktMz6PrBdWD4fiYtNxyFH4p4AzL/y75Q9
	 hqXrvrzZVJesx9Dm64Wky3m/1Sqt0mTYhwXo/GftHrXEBw5HK2qjv2vRbqx38COC2q
	 BoL5vsAXGEDFrYpwy0ZPgLRT//2nQIOsk/mE8pkI13dAoPwHSQRI0JFR5kLWh1foMI
	 ptizH9Ctkgf0VK2kUZfDFxFoPWzjQOq54nz4GL+9O0i8JSA4dfu4qP/LkgbsGl7mx+
	 7qLqRw5k5rehA==
Date: Fri, 3 May 2024 14:08:09 +0100
From: Will Deacon <will@kernel.org>
To: chenqiwu <qiwuchen55@gmail.com>
Cc: catalin.marinas@arm.com, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, kaleshsingh@google.com,
	ardb@kernel.org, alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [RESEND v3] arm64: Add USER_STACKTRACE support
Message-ID: <20240503130808.GB18392@willie-the-truck>
References: <20231219022229.10230-1-qiwu.chen@transsion.com>
 <20240419130921.GA3148@willie-the-truck>
 <20240424141135.GA3664@rlk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424141135.GA3664@rlk>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 24, 2024 at 10:11:35PM +0800, chenqiwu wrote:
> On Fri, Apr 19, 2024 at 02:09:21PM +0100, Will Deacon wrote:
> > On Tue, Dec 19, 2023 at 10:22:29AM +0800, chenqiwu wrote:
> > > Currently, userstacktrace is unsupported for ftrace and uprobe
> > > tracers on arm64. This patch uses the perf_callchain_user() code
> > > as blueprint to implement the arch_stack_walk_user() which add
> > > userstacktrace support on arm64.
> > > Meanwhile, we can use arch_stack_walk_user() to simplify the
> > > implementation of perf_callchain_user().
> > > This patch is tested pass with ftrace, uprobe and perf tracers
> > > profiling userstacktrace cases.
> > > 
> > > changes in v3:
> > >   - update perf_callchain_user() to use arch_stack_walk_user()
> > >     and delete the redundant code as Mark's suggestion in v2.
> > >   - update the commit message.
> > > 
> > > Tested-by: chenqiwu <qiwu.chen@transsion.com>
> > > Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
> > > ---
> > >  arch/arm64/Kconfig                 |   1 +
> > >  arch/arm64/kernel/perf_callchain.c | 118 +---------------------------
> > >  arch/arm64/kernel/stacktrace.c     | 120 +++++++++++++++++++++++++++++
> > >  3 files changed, 125 insertions(+), 114 deletions(-)
> > 
> > This mostly looks good to me, with one potential issue:
> > 
> > > @@ -107,35 +25,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
> > >  		return;
> > >  	}
> > >  
> > > -	perf_callchain_store(entry, regs->pc);
> > > -
> > > -	if (!compat_user_mode(regs)) {
> > > -		/* AARCH64 mode */
> > > -		struct frame_tail __user *tail;
> > > -
> > > -		tail = (struct frame_tail __user *)regs->regs[29];
> > > -
> > > -		while (entry->nr < entry->max_stack &&
> > 
> > The old code is checking entry->nr against entry->max_stack here...
> > 
> > > +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> > > +					const struct pt_regs *regs)
> > > +{
> > > +	if (!consume_entry(cookie, regs->pc))
> > > +		return;
> > > +
> > > +	if (!compat_user_mode(regs)) {
> > > +		/* AARCH64 mode */
> > > +		struct frame_tail __user *tail;
> > > +
> > > +		tail = (struct frame_tail __user *)regs->regs[29];
> > > +		while (tail && !((unsigned long)tail & 0x7))
> > > +			tail = unwind_user_frame(tail, cookie, consume_entry);
> > 
> > ... but it looks like you've dropped that with the rework. Why is that ok?
> > 
> It's no necessary to check entry->nr in arch_stack_walk_user(), because
> the caller function stack_trace_save_user() registers the consume_entry
> callback for saving user stack traces into a storage array, checking
> entry->nr against entry->max_stack is put into
> stack_trace_consume_entry().

Gotcha, and in the case of perf that same checking is done by
perf_callchain_store() for which we now check the return value.

Will

