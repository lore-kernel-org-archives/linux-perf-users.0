Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C721D9354;
	Fri, 13 Sep 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229365; cv=none; b=P/g0RlB9vIKxzZcCsACPhTqU+ZkkdKfc61SNCE1WUUtPVX32G0RLrdcbybe1+Wldx7cFkym48yQ2iPjp1g79yUJuSOFD+0Sv/Fela9yWYfuCGJhi5bFe1uhcQraevwJxBY7sGsQPVaIDEDZNst/smjslMptxmS78hKztFKScCA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229365; c=relaxed/simple;
	bh=UOptbxQ899uu2tULQrr+slKxaEOCsSD5y1TsMVN0amk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkZv7/x1r2XRyExIr0we1ryuRWjUc58IF/D4ULN4mdc6A331jq3e5awluTxpwhCIGxUOoB0P74kd9sT6QFaPQO3hZ7ZGSA5IKx4Vyt9A7FN7775j4H69qAc7491kfLb6lRm4Syr+CjPWrFdtqba8jBHHK9dGf7Y7ocVpGAR2SeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt43WVVC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt43WVVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6AEC4CEC0;
	Fri, 13 Sep 2024 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726229364;
	bh=UOptbxQ899uu2tULQrr+slKxaEOCsSD5y1TsMVN0amk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qt43WVVCBaWI/VzTf+dDIC5hKoyLG/7taAcJvXb1q13rcMkBOXuqUYg6dxow+0XhY
	 S5LNY6g7xVX/7WMJqe+9cvRH4urgsWA4HMi10xgN1R9Lj/GiWc7xF/FFhaWgzRYjJz
	 8LmBQpA4OOzmd1NdxFjZIM9ePDwUWdXTQxYoYcUlidR+ui8UH+urIeY2fi2xh59wuL
	 NSHtIOmT0RFVWD9NRFOULDjvENxy9s7Kod0j/9d2LMDa2bxT0rzOZOi7+TnLIZlJ++
	 cfY0W+QnSY19LZ5c6SvRLslJtnJ907uGx1tw/6BNHvyMk8V+BCZTvXhJonCiRoOtZE
	 zwL9dwuLzWBmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D8FFCE1257; Fri, 13 Sep 2024 05:09:22 -0700 (PDT)
Date: Fri, 13 Sep 2024 05:09:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com
Subject: Re: [BUG BISECTED] Missing RCU reader in perf_event_setup_cpumask()
Message-ID: <e0260345-5069-43c8-bf90-96f6c0c22a33@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2b66dff8-b827-494b-b151-1ad8d56f13e6@paulmck-laptop>
 <20240913104752.GU4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913104752.GU4723@noisy.programming.kicks-ass.net>

On Fri, Sep 13, 2024 at 12:47:52PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 13, 2024 at 01:00:44AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > On next-20240912 running rcutorture scenario TREE05, I see this
> > deterministically:
> > 
> > [   32.603233] =============================
> > [   32.604594] WARNING: suspicious RCU usage
> > [   32.605928] 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238 Not tainted
> > [   32.607812] -----------------------------
> > [   32.609140] kernel/events/core.c:13946 RCU-list traversed in non-reader section!!
> > [   32.611595]
> > [   32.611595] other info that might help us debug this:
> > [   32.611595]
> > [   32.614247]
> > [   32.614247] rcu_scheduler_active = 2, debug_locks = 1
> > [   32.616392] 3 locks held by cpuhp/4/35:
> > [   32.617687]  #0: ffffffffb666a650 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
> > [   32.620563]  #1: ffffffffb666cd20 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_thread_fun+0x4e/0x200
> > [   32.623412]  #2: ffffffffb677c288 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context+0x32/0x2f0
> > [   32.626399]
> > [   32.626399] stack backtrace:
> > [   32.627848] CPU: 4 UID: 0 PID: 35 Comm: cpuhp/4 Not tainted 6.11.0-rc5-00040-g4ba4f1afb6a9 #55238
> > [   32.628832] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   32.628832] Call Trace:
> > [   32.628832]  <TASK>
> > [   32.628832]  dump_stack_lvl+0x83/0xa0
> > [   32.628832]  lockdep_rcu_suspicious+0x143/0x1a0
> > [   32.628832]  perf_event_exit_cpu_context+0x2e5/0x2f0
> > [   32.628832]  ? __pfx_perf_event_exit_cpu+0x10/0x10
> > [   32.628832]  perf_event_exit_cpu+0x9/0x10
> > [   32.628832]  cpuhp_invoke_callback+0x130/0x2a0
> > [   32.628832]  ? lock_release+0xc7/0x290
> > [   32.628832]  ? cpuhp_thread_fun+0x4e/0x200
> > [   32.628832]  cpuhp_thread_fun+0x183/0x200
> > [   32.628832]  smpboot_thread_fn+0xd8/0x1d0
> > [   32.628832]  ? __pfx_smpboot_thread_fn+0x10/0x10
> > [   32.628832]  kthread+0xd4/0x100
> > [   32.628832]  ? __pfx_kthread+0x10/0x10
> > [   32.628832]  ret_from_fork+0x2f/0x50
> > [   32.628832]  ? __pfx_kthread+0x10/0x10
> > [   32.628832]  ret_from_fork_asm+0x1a/0x30
> > [   32.628832]  </TASK>
> > 
> > I bisected this to:
> > 
> > 4ba4f1afb6a9 ("perf: Generic hotplug support for a PMU with a scope")
> > 
> > This adds a perf_event_setup_cpumask() function that uses
> > list_for_each_entry_rcu() without an obvious RCU read-side critical
> > section, so the fix might be as simple as adding rcu_read_lock() and
> > rcu_read_unlock().  In the proper places, of course.  ;-)
> 
> IIRC that condition should be:
> 
>   lockdep_is_held(&pmus_srcu) || lockdep_is_held(&pmus_lock)
> 
> And at this pooint we actually do hold pmus_lock.
> 
> But that all begs the question why we're using RCU iteration here to
> begin with, as this code seems to be only called from this context.
> 
> Kan, is the simple fix to do:
> 
> -	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
> +	list_for_each_entry(pmu, &pmus, entry) {
> 
> ?

It does pass a quick test, for whatever that might be worth.  ;-)

So if this turns out to be the right approach:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul
