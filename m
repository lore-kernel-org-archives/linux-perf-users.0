Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA0348C4C;
	Wed,  9 Sep 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982260; cv=none; b=WqKBOPJV0P88Im4VATCMyk9Q3B0G8RINfqpd/Sw4LpsL83bHMqJtMxWIpGY8/Ewoth+pC67Yhv1Kw1BtCZwnOwoRkcd6S9lpv9gPnlx2pJbaY7scy4ZSD+2iFsbEgkChL7j21s6PjGVp0ZT2Zbf8UDlJvlGGtnCto2b6epGWpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982260; c=relaxed/simple;
	bh=Ev3df10mxNmGPEkApvaW5+98Bhm5asRrNwNxP3EKuO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJgLJcH6LBHCwKJFbbHBMG6DJE3ymIVnVmJHJDjVpy0da+6AyZGtm8kelAMcHzSGnZZe7aSMNPJHiqdWF/X+sBkezx8aQPOmkP2AvWy1cnrdmWeTugW3hF1Knm0lVv8IyhXmb6VBcla+zMzcX4KTKewlVXzdPStANsoOA8U4jAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU4Hvas7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU4Hvas7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279A81F000FF;
	Wed,  9 Sep 2026 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788982258;
	bh=h0KtUzQENRX3k+Qj7Puxd8aLhSB7ZM+KtB0tKaGla1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fU4Hvas7aGnAa5dJsVNL8C1FJdMChTrp0kGAH9Wu4G0YznEME05BTWcV8MGyR3+Oy
	 PHkr7LQhNEysr1eI8z+6eFN4pSQTEXtBeNt0iby1xH+RmaUWtVZ0nqVzp6W2F2YVWS
	 IxF8oUqykYV7qZj4DOZKM847niUNM7M5yOP0O+f/cQhDeHuG6XOPH9uz1VeMEi+VQj
	 aAIHT0AHaePlxGuV5tKbYYpVVnEwCJZDoU6gfmqJr43NdIlI+HWXNW/403V9BRuxLD
	 i46ptSWtnODqtbIFZnUYU+VZqpYYoZUpLxIJm+ciiS0N6iKqQkfp95FmYeP8DbdHA5
	 1m/kzzQ+vMOIg==
Date: Wed, 9 Sep 2026 15:30:55 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Gennady Kupava <gennady.kupava@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
Message-ID: <aqGz7324WTIwJ_8U@google.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
 <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
 <aqAlddsFPYJvRhFr@tassilo>
 <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>
 <20260909081101.GS4121339@noisy.programming.kicks-ass.net>
 <19a610df-530a-4397-9fb6-a1e12251c987@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19a610df-530a-4397-9fb6-a1e12251c987@linux.intel.com>

Hello,

I missed this thread before sending my previous reply.

On Wed, Sep 09, 2026 at 05:36:45PM +0800, Mi, Dapeng wrote:
> 
> On 9/9/2026 4:11 PM, Peter Zijlstra wrote:
> > On Tue, Sep 08, 2026 at 01:56:56PM -0700, Ian Rogers wrote:
> >> On Tue, Sep 8, 2026 at 8:10 AM Andi Kleen <ak@linux.intel.com> wrote:
> >>>> That's what we already do, no? I have distinct memories of making the
> >>>> stack unwind use the NMI regs rather then the PEBS regs.
> >>>>
> >>>>> In my opinion, it could even make the thing worse. User
> >>>>> requires to get precise samplings, but perf silently returns imprecise
> >>>>> records, this would mislead user.
> >>>> Mostly just the unwind might be off a little, the rest is accurate. This
> >>>> has been the case 'forever'. Performance analysis isn't for silly
> >>>> people, if they can't deal with a little fuzz then perhaps they're in
> >>>> the wrong business.
> >>> Is the main problem that the stack doesn't agree? Perhaps there
> >>> could be a check for regs->rsp == pebs->user rsp (if in user space)
> >>> to detect problematic samples.
> >>>
> >>> The question is how to report it and who should do the checking.
> >>>
> >>> It may need new fields in the ABI either to communicate the extra PEBS RSP
> >>> or a bit to indicate that there might be a mismatch.
> >>>
> >>> I guess checking in the kernel and reporting an error might be simpler
> >>> and maybe cleaner, but it would likely limit more advanced recovery
> >>> possibilities.
> >>>
> >>> Are there other mismatches that break the unwinding? Perhaps the same
> >>> for RBP?
> >> For DWARF unwinding any register may be the source of a frame pointer
> >> (e.g. the OpenSSL library would use R11 rather than RBP).
> >>
> >> There is redundancy on x86 you can sample the PERF_REG_X86_IP register
> >> in the user register and there is PERF_SAMPLE_IP in the sample event
> >> itself.
> >>
> >> My understanding is that IBS can only sample IP and so for precise
> >> samples we can use PERF_SAMPLE_IP as the precise location and the user
> >> register PERF_REG_X86_IP as the interrupt IP - this would match the
> >> other register values in the interrupt.
> >>
> >> In DWARF unwinding, we initialize the register state using the sampled
> >> user registers:
> > Oh, I had trouble reading yesterday :/ This is about USER_STACK, not
> > CALLCHAIN.
> 
> Yes, this is about USR_STACK. The CALLCHAIN doesn't suffer this issue since
> perf already returns an IP chain and user space can directly map them to
> the symbols without depending on any register or stack snapshots. :)
> 
> 
> >
> > I think we should try very hard to not use USER_STACK, it is an
> > abomination. Instead we really should improve CALLCHAIN to be more
> > useful. There are a pile of patches for kernel based unwinders,
> > including for .eh_frame (if only I had time to actually go look at
> > them).

That would be great!

> >
> > And we should probably look at doing a shadow stack based unwinder as
> > well.

Cool. It'd be nice to see that happen.

> >
> > This USER_STACK is really the absolute worst possible option. And
> > perhaps refusing PEBS+USER_STACK makes sense.
> 
> If no others insist to implement the precise USER_STACK sampling (what Ian
> suggested), I would give up for sending the drafted precise USER_STACK
> sampling patches. Per my understanding, refusing precise USER_STACK
> sampling what current version does is a cleaner and simpler way.
> Supporting precise USER_STACK sampling inevitably complexes the PEBS/IBS
> handling.

I think precise is for IP and it's not clear if it applies to other REGS
too.  But agree that it'd be simpler to reject.

> 
> BTW, currently perf tools already support the events creation fallback. As
> long as user doesn't explicitly require precise USER_STACK sampling, the
> USER_STACK sampling (--call-graph dwarf) would automatically fallback to
> the PMI-based USER_STACK sampling after the initial precise USER_STACK
> sampling try fails. So it won't really lead to the USER_STACK sampling fails. 

That's true.  perf tools can fallback to auto-reduce the precise level
unless it's requested manually.  If we go on this direction, I think we
should mention this in the man page though.  Probably the condition is
precise_ip + USER_REGS + USER_STACK.

Thanks,
Namhyung

