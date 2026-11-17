Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918836;
	b=l7ddJRRQD1/lgotRzJg45rUOBfwnkWocZ88ETMkJMH/sVbHFZxnYVUf9vAmoc+fFCrFB
	 0VT6ZrOBKDpN5kEYG1K1aG2FWi/I6JJDIFCTZ4f0zuWRez6tSVAeM/+Uz2TVVBttLS+fV
	 5pnDA+2wqO8mnOFAddv8Y0JAohxlbK6Ym0K6//9cJP1QJk73P5pbzugyoDq7YBjnUeEoU
	 RhDkQ0i14tuWl+Z3A2K9E4hJDKIy8qhx9HpWzdPZL+n4PsQ+SMCkN+Mcw04Claej61YvB
	 KsRP79wGGu96hXzNsnR8AwLYuQARAaC3+BXbKpV0nP9BFr6zTrlS/YUlt8yk4sWjlLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918836;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=adJlCMc/x5vh5hhPkeNSjJ1CaT5lEnc4+iZowhfe3qs=;
	b=OJDM97zMPZ2CqXYzyyR1lP9aQv5NCWSoo2wwGaThVyucm2FCTT7kHazxj7cevFe9d/+l
	 WN2Utpjh6TPlWIhmo6VwHxR0YeYhLG7BFzi1f1ednlWvp3dLxlQuRzMva5zMaPHiPAkun
	 4XltzgCNJxWGHzD/vRh4LH4KbialXw+4B7AMfGg1B8z8M32Lq43f04GKY1c3oBKHvq0TU
	 ZbyftLDIWQW4huO0J+TnQEo55TsLbiM+9zwF0aadxAvOu40P7gu0ZH/2UkDDvgw0u7nSC
	 uTOw+gitifjgj0UUFx5HgSo6GMMvA4eotugEbP471gpYKfR2DvPziIp4qUQiJOzR/7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vho7oZPk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AC606A31C;
	Tue, 17 Nov 2026 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vho7oZPk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9011F000C4;
	Tue, 17 Nov 2026 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794918836;
	bh=adJlCMc/x5vh5hhPkeNSjJ1CaT5lEnc4+iZowhfe3qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vho7oZPkqfoiJj76Vcv5A/zl1ZmtxAhm+LVC6njmn/QuQMqsxiTKSgSJA+bc3xivR
	 H/NWybKgwbouR+Ca20ijSsjx09E80FGepJGppIz/gOsdIe3ByJD9hp6cEmyf36UgFy
	 UDQJF46KBJUqZKLf+l2o2TZ+x85ic6P19wVZNvRMjmRUaqy7yyqTYe8zpDJVvxua08
	 O9KqqIoTA7Mk50eekb8/lIaZmVTzYjwwEvaLebQybLCBwhLy82F5svlMZNOI77lLTF
	 t7QATowifNI0eqS+9XxKGMAn2Q53VEKR/IKOaQegOlddQDTuVC1NOpKWY5lhmzcmtA
	 KxsAyk4TB9cwg==
Date: Tue, 17 Nov 2026 12:33:50 +0000
From: Will Deacon <will@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	peterz@infradead.org, jolsa@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH bpf-next 1/3] arm64: perf: Don't report the caller twice
 in caller-regs callchains
Message-ID: <avxJrsiT5vdFESFO@willie-the-truck>
References: <20261114001846.873499-1-andrii@kernel.org>
 <20261114001846.873499-2-andrii@kernel.org>
 <DMUJKFF59EU0.3D4OXJLXB2N6B@gmail.com>
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
In-Reply-To: <DMUJKFF59EU0.3D4OXJLXB2N6B@gmail.com>

On Sat, Nov 14, 2026 at 01:27:16AM +0000, Alexei Starovoitov wrote:
> On Fri, Nov 13, 2026 at 04:18 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > perf_arch_fetch_caller_regs() sets regs->pc to the return address of
> > the function it is used in (CALLER_ADDR0), but points regs->regs[29]
> > at that function's own frame record, whose saved LR is that same
> > return address. perf_callchain_kernel() reports regs->pc and then
> > unwinds from the frame record at x29, so the caller shows up twice at
> > the top of every kernel callchain built from perf_fetch_caller_regs():
> > tracepoint events, software events emitted by __perf_sw_event_sched()
> > (context-switches, cgroup-switches, cpu-migrations), and
> > bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
> > tp_btf and fentry/fexit programs. E.g., for a tracepoint program
> > attached to sched_process_fork:
> >
> >   __traceiter_sched_process_fork+0x44
> >   __traceiter_sched_process_fork+0x44
> >   kernel_clone+0x250
> >   ...
> >
> > Use __builtin_frame_address(1), the caller's frame record, the same
> > way kunwind_init_from_caller() does, so that pc and x29 describe the
> > same frame.
> >
> > x86 had the same duplicate entry, fixed by commit 6d08340d1e35
> > ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"").
> 
> riscv has the same duplicate it seems.
> Its perf_arch_fetch_caller_regs() stores __builtin_frame_address(0)
> in s0. walk_stackframe() reports epc, then frame->ra of that frame.
> Can be a follow up by riscv folks.
> 
> > @@ -15,7 +15,7 @@
> >
> >  #define perf_arch_fetch_caller_regs(regs, __ip) { \
> >  	(regs)->pc = (__ip);    \
> > -	(regs)->regs[29] = (unsigned long) __builtin_frame_address(0); \
> > +	(regs)->regs[29] = (unsigned long) __builtin_frame_address(1); \
> >  	(regs)->sp = current_stack_pointer; \
> >  	(regs)->pstate = PSR_MODE_EL1h;	\
> >  }
> 
> Will, Mark,
> this looks correct to me.
> Mind if I take it via bpf-next together with the selftests?

Please don't pick this up, as I don't think it's quite right. I replied
on the patch itself.

Will
