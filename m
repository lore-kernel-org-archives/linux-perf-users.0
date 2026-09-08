Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992D3A1689;
	Tue,  8 Sep 2026 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854101; cv=none; b=uO+Lh9GitDuElpPlhad+OS0XYAqXbnVcHTtAplYkW+Jx61IW/KVxfVrDTK61SMpiB3Swnl63OFrHIokPYsRTH/TryYKaajwuEb3QTPdrEUTTXcKb+guBsP1KUEyITP0ms/QCsrEZUkIPxo6Sg3cAU/jkrUP4xD0MNaRgXhQDrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854101; c=relaxed/simple;
	bh=V74iGfBs4xj3cXo0HtXboe4bqdfUosm7GEnus1leJfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz7gzGcrvow85ljNKZTorIpopS4QHdqBwp2uy2n+WM37OSlyksrFcTcgjM93RQa6UUBN6+5/G2YohHp2Cd/AGY+osq/zgO9gncCy7Q367er0ZK0Lm97F0FFDpYak/e2R0zka9jnfTxeB1lD1p047zSIhIkYRaDawK3XLuaXEouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTDe8PJK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ywr7ePjS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTDe8PJK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ywr7ePjS"
Date: Tue, 8 Sep 2026 09:54:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788854097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VRXRVay6xLDZY+t9lcPrWvUb1XaHgPwRKdlm/Zpxbzo=;
	b=MTDe8PJKy74mVVCxKtrjvDjyETtY0k1cqzIZziqdC7jbt6wfLpZ8zhjCzYpJhCHwy6wuYK
	6hrzjO7dmx3Al/CY1uADqQXo7Tu2Ofg067RiGi9q/GcFvIKwr5Xd3bi7+kJQlem0obsdiU
	TaV/TbrSrslnYKCYD30aBmCsK9zFgBjkog6SvsQNGEFYh63ifrd4eXgA79Dosp7qiUtkr7
	B5dgUPYhGyJwVGhgOq5lZ1lBg3PA5fbC9JcqYLwTW9ivMi/9zJkVIvCPQEtWJhCEvjsf1C
	iDjhnl7Bg85zPff4JVLn4D2s9LJazauY0Qw/zlTNNegPjA+s0deMXaDvLCFVjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788854097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VRXRVay6xLDZY+t9lcPrWvUb1XaHgPwRKdlm/Zpxbzo=;
	b=Ywr7ePjS5TdqcKhAM5Xa5HO7Cqd6lr5qXZOzO2PgPrTykoYnGCTddGdthPyYuioQvx9hLm
	xyfCWP7dsxUfByCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Clark <james.clark@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Waiman Long <longman@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <20260908075455.OffmMhrB@linutronix.de>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260903160710.vVf4gEL2@linutronix.de>
 <apmknG55qFAn8EPf@shell.armlinux.org.uk>
 <20260903133146.07095885@gandalf.local.home>
 <20260904155404.ESPFg3zi@linutronix.de>
 <ap7OMYBVKUrQjX9O@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ap7OMYBVKUrQjX9O@shell.armlinux.org.uk>

On 2026-09-07 15:46:09 [+0100], Russell King wrote:
> On Fri, Sep 04, 2026 at 05:54:04PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-09-03 13:31:46 [-0400], Steven Rostedt wrote:
> > > On Thu, 3 Sep 2026 17:47:24 +0100
> > > Russell King <linux@armlinux.org.uk> wrote:
> > > 
> > > > What do you expect to happen with this? Which arch maintainer should
> > > > apply this patch that affects three different independently maintained
> > > > architectures?
> > 
> > Well, if you as the ARM person are fine with ARM part, an ACK would be
> > appreciated. If you have something to object, it would be nice to let me
> > know so I can adjust accordingly.
> 
> First, I only just looked at the email - you may have noticed I'm not
> very active with the kernel anymore, as I'm a full-time carer at the
> moment.
> 
> Second, I'm not fine with the patch as-is, because it's not clear how
> it could be merged in its current form. It would be inappropriate to
> give an Ack, because an Ack means I'm fine with it. I'm not.
> 
> Third, I haven't actually reviewed the patch itself (see first point).
> 
> Looking deeper now, I see nothing in the linked report, nor in your
> write-up that identifies what is responsible for the context being
> inappropriate to deliver the SIGTRAP. See the first point - I'm not

The linked report shows a backtrace by "BUG: sleeping function"
originating from el0_breakpt() -> perf_bp_event() following by sending a
signal force_sig_fault() followed by rt_spin_lock() and
__might_resched(). It also contains a reproducer.

The first sentence has the part
| The hardware event is
| delivered with disabled interrupts and perf intrastrucure expects
| disabled interrupts while the overflow callback is invoked.

This is what happens, followed by 

| The callback then sends a SIGTRAP signal for which it acquires
| sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
| must not be acquired in atomic context.

This is not really specific to PREEMPT_RT as we enforce to not allow
raw_spinlock_t -> spinlock_t on !PREEMPT_RT via lockdep, too.

> able to read lots of code to work that out, and presumably you've
> already done that ground work to come up with a fix. This is *vital*
> information when someone looks back at why this change was made as
> it helps to understand how the problem occurs. This is, after all,
> the whole point of commit messages - to help people look back and
> understand why a change was made. The "what the changes are" part
> is already covered by the patch showing what the changes were. It's
> the stuff that *isn't* in the patch that needs to be in the commit
> message.
> 
> So... don't describe the code changes in a commit message.

I think both parts (describing the issue and the change) are part of the
commit message.

> So no, an Ack is not appropriate.

Sebastian
