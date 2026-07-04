Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8213AD1C
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Jul 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783133059; cv=none; b=sDxMY1+W02g7dgERE04Ehk+lNCmIn3pkjBw582RJgKjpJQUvfNEkjD6zaCG+KieirR2SWZAsd/XwhWI3AjAmCBEglXXXy4cbSLwUpsPneHUODAGIGsVPhsh0x2eS5Hbw0eq3nDaqPUTu3BkCXvb7QpjkX9DYpxIebcNAkew658I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783133059; c=relaxed/simple;
	bh=7prJADnQymn+rs1252TSn3BunTPxI2H4f6DIk2QJR9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J1cLd4hMpa+suqfNt6o2fhMtO9cQbXCepdd8YDYbG6XkjuKUKM/2N2ZMQIh6HazaWYiPPQMu4fygzyv8BsbH1gQpnQzuz219m9drrCf7pApm0Ts59E1HveLI3ItDA44LHvZc4KUKPMtYc/ZbWaiR3TU5E8OhpZA81FIRXFJ1aiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3bkaOCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3bkaOCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25F21F000E9;
	Sat,  4 Jul 2026 02:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783133057;
	bh=/L4J7kqYCN7zXqVNto2FAFm+uDdNoMwjBA12wG/e+T0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3bkaOCGQwQ48YPTdGnepe4bNRCyzRXF79e+GJj8sJqVeJx8+khmzhYvNAeq1wIRy
	 H+JkzaCmIKgG/7Y+8EWWQioz0BzoTSpsYQtnuVlSnrjl0T7aJ0671Ot/NxbvdxTgaw
	 QGZuRwvclIgCfQ7FaCmH32FWpNIW4YWvYFJLQf1tiDnIrS8c9e7Wl0m7AH+uGdOYhp
	 wLHEVH0IYow9gA9gVmTSREHcjQgD7RS5DKjrx0QLyDrPSp7tbgNACPCa7dtt5VLr0n
	 O39/ydPPUgGhbCNJ/w0wrAozo6znEWEs4vx7DVLk5WtPkY5afV3UKCFio0eXViO+ip
	 CtJ4EMRl63/zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf kvm/riscv: Fix event key collision between
 interrupts and exceptions
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260704023608.24971-1-fangyu.yu@linux.alibaba.com>
References: <20260704023608.24971-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 02:44:17 +0000
Message-Id: <20260704024417.C25F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using the compiler predefined macro `__riscv_xlen` in a static a=
rray initializer causes build failures on non-RISC-V architectures and brea=
ks cross-architecture analysis.
--

commit e5247b904831a2084b1e8757d98d388a7fc008c0
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

perf kvm/riscv: Fix event key collision between interrupts and exceptions

This commit updates the RISC-V KVM stat exit-reason decoding to use the
full scause value, avoiding key collisions between interrupts and exception=
s.
It splits the TRAP macro into TRAP_EXC and TRAP_IRQ to encode interrupts
with the architecture-specific IRQ bit matching the hardware value.

> diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c b/tools/perf/=
util/kvm-stat-arch/kvm-stat-riscv.c
> index 967bba261a475..829096a41a3b2 100644
> --- a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
> +++ b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
> @@ -23,10 +23,8 @@ static const char * const __kvm_events_tp[] =3D {
>  static void event_get_key(struct perf_sample *sample,
>  			  struct event_key *key)
>  {
> -	int xlen =3D 64; // TODO: 32-bit support.
> -
>  	key->info =3D 0;
> -	key->key =3D perf_sample__intval(sample, kvm_exit_reason(EM_RISCV)) & ~=
CAUSE_IRQ_FLAG(xlen);
> +	key->key =3D perf_sample__intval(sample, kvm_exit_reason(EM_RISCV));

[Severity: Medium]
Does this code introduce a regression by preventing dynamic cross-architect=
ure
bitness decoding when analyzing traces? With the dynamic mask removed here,
the lookup now depends entirely on the statically sized table.

[ ... ]

> diff --git a/tools/perf/util/kvm-stat-arch/riscv_trap_types.h b/tools/per=
f/util/kvm-stat-arch/riscv_trap_types.h
> index aa5d24fab4ee3..da1f1ce55326c 100644
> --- a/tools/perf/util/kvm-stat-arch/riscv_trap_types.h
> +++ b/tools/perf/util/kvm-stat-arch/riscv_trap_types.h
> @@ -38,20 +38,21 @@
>  #define EXC_VIRTUAL_INST_FAULT 22
>  #define EXC_STORE_GUEST_PAGE_FAULT 23
> =20
> -#define TRAP(x) { x, #x }
> +#define TRAP_EXC(x) { x, #x }
> +#define TRAP_IRQ(x) { (x) | CAUSE_IRQ_FLAG(__riscv_xlen), #x }

[Severity: Medium]
Does using the compiler predefined macro __riscv_xlen in this static array
initializer cause a regression by breaking the build on non-RISC-V
architectures?

When building perf cross-platform, this macro is not defined on hosts like
x86_64 or ARM64, and the static initialization in riscv_exit_reasons expands
this macro.

Also, does baking the host's compile-time word size into TRAP_IRQ introduce=
 a
regression for cross-platform analysis? For example, if a 64-bit perf binary
processes a 32-bit KVM trace, it will expect bit 63 to be set for interrupt=
s,
which would fail to decode 32-bit KVM events using bit 31.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704023608.2497=
1-1-fangyu.yu@linux.alibaba.com?part=3D1
