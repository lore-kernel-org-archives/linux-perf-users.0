Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918803;
	b=ay9ftFkjT1newcd8xWQxJx9rnKWvNpYI+G0G+OJRYuGNw7e4QyKpNGv5VdoECUNUJtp6
	 ESfThx5S1caGxifqDIzuzKFUUB2jvQHXMwbcj9v2ea8vvwVpGGuFDQKYvMWGkN3C2Y2gr
	 Lr5ssWMAUwh6gp/04zcJw8ZL3hAalp3QRNpwcGorilVK8EWpXgpyzVPsFd2heidGGA7Yc
	 SXPzMl/6JDbM9hfKwu3oZQvI13R0QgRtrwOZqB5RSDKQ+TyHZJADgUaQflTC8CCk/sEnf
	 KZcdcPxG+QrIkRXF7NJiuhr4N7WKEDs5kNtz+ZDEISb3mUHApFurVryg8nG9xEqpqPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918803;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L9/zmyDwR7zpVKBQBxJnUV/A6ZXWQ4xYlPUf1Rc2SXE=;
	b=KIqFmC23qlW4LFo2hk52sCJhxAITj9A0C8SKb0a8cc9T2l/9ANFJW+BDwl+1TDQ5DR3n
	 cRraxqu30nc7whrWq8gZSQFy8DOYGIwcs70dA2b3BOTOE6yyfkmFi8dvQISytJCmQ5AgZ
	 V0z/w3FdYYLpRRNQP8hQoC63lPTobP6wefZABulRxGx1r/AMGxbC7aUQrKqmKyUidN2TR
	 cGrApbWQsCML+KXbrCemsAPCnEZP/MeOtgG+wrsY3l2tkqZP2uwVAsblT9KvIhEbmy7e7
	 xCgSNTjSzZn3LL3wZ5o0tBNrbPUaCtyShTkzJnVM371f/NrONUSkWymKTAgR4ChMYdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJVccZ4F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B05606A329;
	Tue, 17 Nov 2026 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJVccZ4F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2991F000C4;
	Tue, 17 Nov 2026 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794918803;
	bh=L9/zmyDwR7zpVKBQBxJnUV/A6ZXWQ4xYlPUf1Rc2SXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YJVccZ4FtB30FrpS0eEMJXhwJRbh2ntPnBPlG2e1Cr/x3syKsL1nDqCSfZ3ZNeAXb
	 a/D9uDRNYuc8aJE3Fz6A7jmLiUEoEysx4hcnrKdDfqKxr3JE+w90zEj6j8LKcEOozi
	 5xBGQo/4YVCNT5pGDPOsmKqhjag08h+JaeCSBDmPzlwLkzH0gc3l+QB6BdvGrv+Grw
	 qSWuEAs3L4W6sWxLLu2g83niXofan0w7VYJawhLtQ1iWjIZ+4dDToBb7mUKsihSQ/4
	 l0hsEOIX5sHnc3GjosU+QJnCdpIKUEa7hhCC6+JLUtoEXmUp3Xtj8fr/8MG9cMBCOP
	 4HG5/3cnLanWQ==
Date: Tue, 17 Nov 2026 12:33:17 +0000
From: Will Deacon <will@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	jolsa@kernel.org, rostedt@goodmis.org, ardb@kernel.org
Subject: Re: [PATCH bpf-next 1/3] arm64: perf: Don't report the caller twice
 in caller-regs callchains
Message-ID: <avxJjTWOp250aDYC@willie-the-truck>
References: <20261114001846.873499-1-andrii@kernel.org>
 <20261114001846.873499-2-andrii@kernel.org>
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
In-Reply-To: <20261114001846.873499-2-andrii@kernel.org>

On Fri, Nov 13, 2026 at 04:18:44PM -0800, Andrii Nakryiko wrote:
> perf_arch_fetch_caller_regs() sets regs->pc to the return address of
> the function it is used in (CALLER_ADDR0), but points regs->regs[29]
> at that function's own frame record, whose saved LR is that same
> return address. perf_callchain_kernel() reports regs->pc and then
> unwinds from the frame record at x29, so the caller shows up twice at
> the top of every kernel callchain built from perf_fetch_caller_regs():
> tracepoint events, software events emitted by __perf_sw_event_sched()
> (context-switches, cgroup-switches, cpu-migrations), and
> bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
> tp_btf and fentry/fexit programs. E.g., for a tracepoint program
> attached to sched_process_fork:
> 
>   __traceiter_sched_process_fork+0x44
>   __traceiter_sched_process_fork+0x44
>   kernel_clone+0x250
>   ...
> 
> Use __builtin_frame_address(1), the caller's frame record, the same
> way kunwind_init_from_caller() does, so that pc and x29 describe the
> same frame.
> 
> x86 had the same duplicate entry, fixed by commit 6d08340d1e35
> ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"").
> 
> Fixes: 5b09a094f2fb ("arm64: perf: Fix callchain parse error with kernel tracepoint events")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/arm64/include/asm/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index ee45b4e77347..13efb46f0fe8 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -15,7 +15,7 @@
>  
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \
>  	(regs)->pc = (__ip);    \
> -	(regs)->regs[29] = (unsigned long) __builtin_frame_address(0); \
> +	(regs)->regs[29] = (unsigned long) __builtin_frame_address(1); \
>  	(regs)->sp = current_stack_pointer; \
>  	(regs)->pstate = PSR_MODE_EL1h;	\

This doesn't look right to me. Presumably, the compiler is now going to
emit the first step of the unwind, but it has no idea about the different
stacks that we have, the meta frames or the invariants that the walker
in arch/arm64/kernel/stacktrace.c takes care of.

So we should continue to unwind from the current frame, but then perf
can discard the duplicate leaf entry if we don't want it. After all,
it's perf that's passing in CALLER_ADDR0 for __ip.

Will
