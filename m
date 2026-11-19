Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047759;
	b=bnydeS0e+/+ae2YHhfd78E9kDAc4PthcLuzNlvyETIm2HRe/Q+lOtkpoUbbrVvnaevTY
	 gv87Q2867uipp94qB0aluqCyiVoz0IpVfv0sOobuXmAeLFCWzBG8aqbCmAPHrdKy5Qcm6
	 497wg7CNoZCsdHVijayWKiizegAjI9XZ0QSZDxnTpJas5VEzgzA6feUOOQjdrNOng9Vcc
	 ObIBymwrz7D6zX/rduzB9hpOdwpByz+ycNXi3ogdEn/uAf9lxzn9INZ7OwAkJPn7hMl0g
	 PzcjMPrLJf710uwZCsn/rv1QCzS+/vd+nTkhjWQ4jamDPLW/4h8harzua7GrRLWoqIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GAQ/sj9UBYlxHr0cM+j7tq/rbmSIO/uS2PZfHfuBVJ0=;
	b=wyEnRwdYbolY/bZmLI0lFA2ZCw2/Lu8u64S2DBu7NKvxDNjIC7XoS7MN2UDqmSZGJ+gW
	 tciFvq9mO/lgc/PmjUIvRJLXUVRRJffzDLn7j6DDdUMWjQXyHyfnR1+gBLOEIOlILjoCO
	 DTsDdguMew0b7jPBwTVKqCVJUNmUgr9yDSdZCxoa4cL4vykdD1TlLZg5wr1r+bLI+xrIB
	 fJV06auuJ3bkVaYZiwtwJQg78EjkkTi9GSzCw0xSX+/SAHqI7VS4/R1Ptx/0YoiVi3g0l
	 DdkbYBMLH1G42b0CI+hQU51NtcewP5RDYbjsW/GrZGex0G6tXv3EthRFJLMntpsrLng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZS8rjf92;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55AB606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZS8rjf92
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC361F000C4;
	Thu, 19 Nov 2026 00:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795047759;
	bh=GAQ/sj9UBYlxHr0cM+j7tq/rbmSIO/uS2PZfHfuBVJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZS8rjf92MRUZVFA4Fnk2bQJFuegthi0k0o5CoDuQgK9dRjmJQLRze23gusufWqGMQ
	 jC9QCJKeJeRnq9DWmkAcIGEoly2oz45V8YkiSd6TacCtf7nz2+8ENVCaUYzY5jcAPq
	 hqtdy4tZUte60SS7y99uzzYbx6s8q/AOJzJfEGMZFFkW93ZRjsm0yrDTIiqFQeQLn7
	 SwNsvZ0aDfdRZss6pYoDF27I04FvTzCyLpeKjPLmbyjTYJGJPOwfpBZsEV3nD9KFmD
	 1TgrVMWcg3AF7WMCgRM0YZrH5ZUgXlHIAiKE+Bglsxv0CCiVfaLwqXT9NVOPlb9RQm
	 cA4KjgLFCnh8w==
Message-ID: <sashiko-outbox-222243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] arm64: perf: Don't report the caller
 twice in caller-regs callchains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119000112.2377949-2-andrii@kernel.org>
References: <20261119000112.2377949-1-andrii@kernel.org>
 <20261119000112.2377949-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 00:22:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_arch_fetch_caller_regs() sets regs->pc to the return address of
> the function it is used in (CALLER_ADDR0) and points regs->regs[29] at
> that function's own frame record, whose saved LR is that same return
> address. perf_callchain_kernel() reports regs->pc and then unwinds from
> the frame record at x29, so the caller shows up twice at the top of
> every kernel callchain built from perf_fetch_caller_regs(): tracepoint
> events, software events emitted by __perf_sw_event_sched()
> (context-switches, cgroup-switches, cpu-migrations), and
> bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
> tp_btf and fentry/fexit programs. E.g., for a tracepoint program
> attached to sched_process_fork:
>=20
>   __traceiter_sched_process_fork+0x44
>   __traceiter_sched_process_fork+0x44
>   kernel_clone+0x250
> [ ... ]
> x86 had the same duplicate entry, fixed by commit 6d08340d1e35
> ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"").
>=20
> Fixes: 5b09a094f2fb ("arm64: perf: Fix callchain parse error with kernel =
tracepoint events")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119000112.2377=
949-1-andrii@kernel.org?part=3D1

