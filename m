Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616003;
	b=qB9Y2/ZWYMhgYAMFtAQWltfi1G7Me7Y/Dv1gDYTyJTICvhPY+r66xNRaEgGA9KqW4VIL
	 C4si4rAsEDD4K5B+BtNvGKGIm6b8Y2gO/RnuVjf/5prczYi9bfpWmo3YEHs24jiXrCYV1
	 dRSrqmhIvfYY0g+HCFx/UNituaMBPJe9FOAewJrahxO1WTOEmS2w25nX/+H4EkRumkTkM
	 X5tllwq+CMzLb571FRO8R4HOX/9ZOJ6DOZ+Xi43z/MZHQjAc/3JmYiX5u1N9QCXz10aRZ
	 ujCoeNjT096xIZAlcvSTMW6g2n+9V+MyhYWzFxOrffAKkAkK10NzYVw9PLooYHt8TQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NK1ol+JDjdalMzuHqj0zmCz2NGqxPX6Svu31PIUN6fI=;
	b=36MXrcGa8qi9okBsRWUkD7CyYns2V3u/WkAt5xEVrkmKdG/PuptL8YNRKIRHs6UKv8j8
	 zSrEKoO+QXtFdYrlmAp99oxHlZIBIa2pHxeAO8AzQACf0qVOb9WBvvLYyI9c6E+oQDBYC
	 IDaRh/YPMbLcefcPHKHvgivY4AdnL0KuvSa4gpOSXb1GQ5uTx8Ol0Uu4H1ZagHSNPQ/+y
	 yxW0hLDM62OfqQQSUsHeCuhC71N8yHSB/NfnktpBGs6/nU11nquXmFg4RsYcO6BF5N5E7
	 0joBE8sgIoAaH8llKVuGNaQEnxtN2gGST25NjLm60GdM6Ibb9KrOrfmdIxt5CO7yOUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KHJaz/+y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB0606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHJaz/+y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BD01F000C9;
	Sat, 14 Nov 2026 00:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616003;
	bh=NK1ol+JDjdalMzuHqj0zmCz2NGqxPX6Svu31PIUN6fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHJaz/+yG9dLKZyryPDWkleE+bEiazUlHflt86f+OAM5q04vwEjGpDTifQNibodEp
	 wE4h0ned2JN3xvdmf6wyk8DTvpLXDlVkOqfV99RUHUtlK453RfBV1Cn3Y+MgSRh/sp
	 lXx8Ov1wW6aImfi340iZ2uaE4g+Pmw+AKmmqzWZmfXVCmbbB1Z3waTvuoVNNc+VADR
	 qk5GAmXWsGfRyAyZs41JQBiT0iD/xX0umFDsr3CjAgTV2kz/ACmsanoLI4QHWOnMHx
	 9DZyVQ3GdaV2QI5Nt687tz7AfZvgmtP8SI5BxU1n5ruOYcytYjNca327XTfPJoSJJK
	 w6xkOMNincLyA==
Message-ID: <sashiko-outbox-213923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/3] arm64: perf: Don't report the caller twice
 in caller-regs callchains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114001846.873499-2-andrii@kernel.org>
References: <20261114001846.873499-1-andrii@kernel.org>
 <20261114001846.873499-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:26:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

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
>=20
>   __traceiter_sched_process_fork+0x44
>   __traceiter_sched_process_fork+0x44
>   kernel_clone+0x250
>   ...
>=20
> Use __builtin_frame_address(1), the caller's frame record, the same
> way kunwind_init_from_caller() does, so that pc and x29 describe the
> same frame.
>=20
> x86 had the same duplicate entry, fixed by commit 6d08340d1e35
> ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"").
>=20
> Fixes: 5b09a094f2fb ("arm64: perf: Fix callchain parse error with kernel =
tracepoint events")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114001846.8734=
99-1-andrii@kernel.org?part=3D1

