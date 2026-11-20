Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190294;
	b=YvBW5MTkULj32QKzr9QQk4y99pgK/VeLpgOrsbZBOF7VKQQX5OI5okV/S2J4gfx+AeJO
	 lvsi5+y2PslahL8OlGZcxld6UWw4E40aRcprBMwYOmLv4Z+mW0lD7EczZP6DQ5rByTxE6
	 Z34Dq2EdVWZ8Ef21zpY32lZqqDJ3YSe1PEfdgN6zzCQY4AlwZoYVx2URa0GwxF86KVLR2
	 H0CBdO+qoNP9XgGMJJWZQ5YVvFxr3u+fbAcyzRakw+Kw9bnmmhvQ1jKh5+aGhjJzpm/tj
	 l9XRQSdPOTttdkP2I9AkUqrvNpzIJ+zzbY6Pb+MsVUbjIrXuNIA471lpO589Xq3HN0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190294;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HshqsJTVQWKzzCpeTZNQ6x3UViMzlSmZnpb8BEfK+Ro=;
	b=oQFGr4vcFUA9x3EvTH5kqQWa9NXxkSkXj2jFVbADeP28+rP6u7Ow0PVUY+BO5h/Rj0/G
	 jZQiXen702A3afi7zgGtYiMLS+UgymNypcq2CnvoikFohHnfHXGh/woOgsKEPsofNACYE
	 TXJIxC3JLMCuKQDEy4fX2xlXXeZQEb99ZjJYN62dDXVUwepMAfDKJly0YZ6uQfi7bkjfI
	 sT/sllomR/ARcPohG8Qe/3SEVTU2R2ROS6R3GMXBE9W+m9LyBKofW5CBlmk75wXzhg1QI
	 Zr3j2s3o79I2yfvQFz6WG7GNbLL1j2dyx76MY1LY8qpXe5SscQVa8nUicTpxfX0zt6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PZz3Ur2a;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF8606A325;
	Fri, 20 Nov 2026 15:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95DF8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PZz3Ur2a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HshqsJTVQWKzzCpeTZNQ6x3UViMzlSmZnpb8BEfK+Ro=; b=PZz3Ur2a6OdHwfi/J7tRqJKf9c
	JkB20MtKPZOMm1TsoCDmVdbABbvFgh1EhVDiZpaUhJpTZNOYGkBRAVRz+6dYnh/a9lM8RWeglMFAz
	K/eyFBbBpcD6e53eMfHFrnLewpMKDbjDz6vkzYRYJ9i83WrYAmGk2lX8WdjsRD+5N37QPcD6rIq05
	agoYB1y7GZEKf8mIoWsrR5ObRnwu6kQF9KRyddWGskcEsgdJh161/MKbTocHRzDUcWy4ycgu1UiCb
	PwvTUf0hxXaSuBdtZT5Uewoy/KcD+mOn2BpqaBihQ1GITzP1HRA8zki1cleFXPxPozCnRuyIv6RWe
	dQZs4rYA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUR04-00000000vlw-0aHt;
	Fri, 20 Nov 2026 15:58:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F50E3008D6; Fri, 20 Nov 2026 16:58:06 +0100 (CET)
Date: Fri, 20 Nov 2026 16:58:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
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
Message-ID: <20261120155806.GK2669272@noisy.programming.kicks-ass.net>
References: <20261120144553.TjgAd_G6@linutronix.de>
 <20261120150320.GQ2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261120150320.GQ2668804@noisy.programming.kicks-ass.net>

On Fri, Nov 20, 2026 at 04:03:20PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 03:45:53PM +0100, Sebastian Andrzej Siewior wrote:
> > Waiman, Luis, Ada reported that HW breakpoints on ARM64 trigger
> > "sleeping while atomic" warnings on PREEMPT_RT. The hardware event is
> > delivered with disabled interrupts and perf intrastrucure expects
> > disabled interrupts while the overflow callback is invoked.
> > 
> > The callback then sends a SIGTRAP signal for which it acquires
> > sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
> > must not be acquired in atomic context.
> > 
> > Delay the event callback until the return to userland.
> > Add perf_hwbp_notify(), a generic perf callback which delayes the
> > actual callback invocation to task_work_add() callback. This callback
> > invokes the architecture defined callback perf_arch_hwbp_send_sig().
> > This requires struct callback_head and the functions require
> > ARCH_NEED_PERF_HW_NOTIFY to be defined.
> > 
> > This was reported against ARM64. ARM, LongARCH and Xtensa follow the
> > same pattern are also converted. Xtensa is the only not supporting
> > PREEMPT_RT but now we have all architectures using the same pattern.
> > 
> > Fixes: d8fccd9ca5f90 ("arm64: Allow to enable PREEMPT_RT.")
> > Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > Reported-by: Waiman Long <longman@redhat.com>
> > Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
> > Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > Tested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> 
> Mark; you was going to stare at this :-)
> 
> I'm thinking the archs are doing it wrong and should be sending the
> signal elsewhere.

Notably, I'm thinking arm64 should be sending the signal from either
do_watchpoint()/do_breakpoint(), after it has done perf_bp_event(),
or from el0_watchpt()/el0_breakpt().

Perf overflow handlers are not the place to send signals from.

That is very much what x86 also does, we send the signal from
exc_debug_user(); which is roughly equivalent to the above mentioned
functions.
