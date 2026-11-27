Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804683;
	b=1E4qCel5s3TLQ1woGPosij44jeW9mxuefPVOQkd7o5/sQpqmHH9LhhnvPFAWgvMOxr6S
	 CF1GEdg225gZgCGNQ2KuQ9QgmzB4EhAKwCw7C4Jw+fVa+XUM7sarf+Zk3ypnjHYXtaPdI
	 yXtYI2C3u4rONeXADAy9cC7tX55ui+83G590Cgke4REB6caWlY8TuxLSSbQlwgrMC2ibQ
	 fWR4IrVOyx6WJQCkAsh4fsBXwcKgmWxKR0nc2UxzmO3aa0eKij9XvXWB9VwmzJL+FSnGa
	 fihkMS5SFvINo67dih61JgT+HL4fnolE2i2V+kFU+cVkzjJU4pzCAE5IHWKdhh89CXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804683;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BWblz2p3e+RANKxaoCJc2peYHCm2/SRIz3+0ra5cwvs=;
	b=ipsUahvfX9O0Yc9zeJzITMbtkJrA1933HuxHV+nwhtC4tBgPxJ8pLingzQYh1sh05kUj
	 MMFmkbSQVitMFce6lCPyvK76LAljK5bxlKAuOXuxC4ZHKv3J6HNK9P/144ySIkD3R9of1
	 Q81X+SrpkUHNAVbaEHkrSRCQVNXW/hCqsuUDHMB1+brupgTUv1jKteD+nssqDqgAtjc4B
	 GgByhVOlwYoXtxIXimveMS1z68oNA2DrWzpIhZ0E9RMp0MNV8Rzu0shUMjPaX3BpSImmD
	 HLh2GNd5HQeUpxrJG8tIIDX7bfi5Xcxe6l2EL6H37EVn5IbT+do+3HSTfAie77bg3sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Pj8RMo4+;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51910606A31C;
	Fri, 27 Nov 2026 18:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51910606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Pj8RMo4+
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 932731575;
	Fri, 27 Nov 2026 10:37:59 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7798F3F86C;
	Fri, 27 Nov 2026 10:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795804682; bh=WmazKbbRJkJgrB2424W6m6iKCFKjBQNVA1FAYPEAZmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pj8RMo4+8uVvzglyYRCuvg790viYUgDQspUF3aRjCZFHTiLXEeLCktxCz2Q7UPnWh
	 4Z1ld8xUtlEp1n8tZigZexN643W7Amw3OqJikuSRR51zOqjfZIVcfNaTH0fln3cY1l
	 SXQYNpjkf8/BO1QI4Ya//Lf7Zr/ObA7Ku4CQn1+s=
Date: Fri, 27 Nov 2026 18:37:55 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>, Oleg Nesterov <oleg@redhat.com>,
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH v5] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP
 notification to task_work()
Message-ID: <awnOAw-bnxDbljaE@arm.com>
References: <20261120144553.TjgAd_G6@linutronix.de>
 <20261120150320.GQ2668804@noisy.programming.kicks-ass.net>
 <20261120155806.GK2669272@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120155806.GK2669272@noisy.programming.kicks-ass.net>

On Fri, Nov 20, 2026 at 04:58:06PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 04:03:20PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 20, 2026 at 03:45:53PM +0100, Sebastian Andrzej Siewior wrote:
> > > Waiman, Luis, Ada reported that HW breakpoints on ARM64 trigger
> > > "sleeping while atomic" warnings on PREEMPT_RT. The hardware event is
> > > delivered with disabled interrupts and perf intrastrucure expects
> > > disabled interrupts while the overflow callback is invoked.
> > > 
> > > The callback then sends a SIGTRAP signal for which it acquires
> > > sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
> > > must not be acquired in atomic context.
> > > 
> > > Delay the event callback until the return to userland.
> > > Add perf_hwbp_notify(), a generic perf callback which delayes the
> > > actual callback invocation to task_work_add() callback. This callback
> > > invokes the architecture defined callback perf_arch_hwbp_send_sig().
> > > This requires struct callback_head and the functions require
> > > ARCH_NEED_PERF_HW_NOTIFY to be defined.
> > > 
> > > This was reported against ARM64. ARM, LongARCH and Xtensa follow the
> > > same pattern are also converted. Xtensa is the only not supporting
> > > PREEMPT_RT but now we have all architectures using the same pattern.
> > > 
> > > Fixes: d8fccd9ca5f90 ("arm64: Allow to enable PREEMPT_RT.")
> > > Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > > Reported-by: Waiman Long <longman@redhat.com>
> > > Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
> > > Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > > Tested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > 
> > Mark; you was going to stare at this :-)
> > 
> > I'm thinking the archs are doing it wrong and should be sending the
> > signal elsewhere.
> 
> Notably, I'm thinking arm64 should be sending the signal from either
> do_watchpoint()/do_breakpoint(), after it has done perf_bp_event(),
> or from el0_watchpt()/el0_breakpt().
> 
> Perf overflow handlers are not the place to send signals from.
> 
> That is very much what x86 also does, we send the signal from
> exc_debug_user(); which is roughly equivalent to the above mentioned
> functions.

(Mark and Will are the experts here but they are busy)

I think we can do something similar for arm64, send the signal in
el0_breakpt()/el0_watchpt() after local_daif_restore(). We do this with
el0_brk64(). ptrace_hbptriggered() can just record the perf_event and
defer the sending (we may need a new field in thread_struct::debug). No
core code changes needed.

I think Russell also objected to this patch for arm and Sashiko
complains about loongarch issues (I haven't parsed them).

-- 
Catalin
