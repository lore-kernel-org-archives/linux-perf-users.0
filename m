Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E331F9AC
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264540; cv=none; b=azmud7ECDIoNoZ7qVpnoEtylQVFFiGOiJd7mh7pqGdKt36/oqtoSwKDrCVeN3/qWor8wzada1T3Kllb+rp4z/mfMa8aSBx5N7S9BsxEKbiQuYQXoJ5+MzWsP5V2HtzTpTuAB2YkjpxjA0lYFqpXFRodJlZG6b+a5ERZUtYEEE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264540; c=relaxed/simple;
	bh=DPdjGeNXauk8c4EfnPLvYhnTtHWnoKljZxBQsHphGeQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ERDJ1vqzTS1BA1JO8F063cocmKFVNXOVHWkDlSyyKLqtze0B0PwAd3VjSmtA+/LLuIMAt05WsrpqWlhfxzcMBJqiK6suIBSktDpwQDx7p23T2CWBWCqQDjkLg1i7BZK7C45ahkdh6n3GVbhhpuvCSNxxHNfPdDLNsfl2dfbjMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6m9imGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6m9imGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552B11F000C4;
	Sat, 17 Oct 2026 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264539;
	bh=ZNhriD+3X0xCPpHxJU9/SQa3f878Xrl9nXzC+OyLwWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B6m9imGbTrrAivAXISh0j3eYdbgEkDifpwxs5H91SZns5foAMXf4lGyyL89a13K51
	 UlqEWIowi+OcofI+5DW7XLUorxiKmi0I8tRIjFQb/FK8t23EcX+3stiYYFFQf+AEu1
	 qnWCsYA7VKP0uChLBiEUfqS1wqGqu0gnQeaCFF7J1OC6PFzF+s50FkVGNAHp6N4PtN
	 +81AZvhm7bpbCOYiAa8jeLOByFw6YkuGzW0+bKMxo3c/PsI+9MjZE6DafF456W5z1/
	 cuShTAwUV8ljO+bnWUr4OExUCaM4NMEFcrpP6p5BhECiY8d3U0EKga1REXW/Yte8/q
	 OWAC1jsObrU5g==
Message-ID: <sashiko-outbox-175775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 6/9] perf pmu: Probe registers, memory events,
 rdpmc, and branch skid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-7-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 19:15:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf pmu: 64-bit operand in rv32 asm constraint in run_skid_branch_=
loop()
--

commit 1d20e4dd9d51fee9a24330f6bf13bda0cca94b25
Author: Ian Rogers <irogers@google.com>

perf pmu: Probe registers, memory events, rdpmc, and branch skid

This commit extends perf_pmu__probe() in tools/perf/util/pmu.c to probe
supported user and interrupt sampling register masks, memory profiling
events and sample formats, user-space mmap counter reading (rdpmc) and PMC
bit-width, and empirically measured branch instruction skid across
precision levels.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 83c8d6f392ba9..15a21f8c65ed4 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -3356,6 +3356,739 @@ static void probe_sample_types(struct perf_pmu *p=
mu,

[ ... ]

> +static noinline bool run_skid_branch_loop(u64 iters, uintptr_t *out_s_ip,
> +					  uintptr_t *out_b_ip,
> +					  uintptr_t *out_e_ip,
> +					  int *out_insn_sz, int *out_nop_cnt)
> +{

[ ... ]

> +#elif defined(__riscv)
> +	uintptr_t s_ip, b_ip, e_ip;
> +
> +	asm volatile(
> +		".option push\n\t"
> +		".option norvc\n\t"
> +		"la %[s_ip], 1f\n\t"
> +		"la %[b_ip], 2f\n\t"
> +		"la %[e_ip], 3f\n\t"
> +		".balign 64\n"
> +		"1:\n\t"
> +		".rept 512\n\t"
> +		"nop\n\t"
> +		".endr\n\t"
> +		"addi %[cnt], %[cnt], -1\n\t"
> +		"2:\n\t"
> +		"bnez %[cnt], 1b\n"
> +		"3:\n\t"
> +		".option pop\n\t"
> +		: [cnt] "+r" (iters),

[Severity: Low]
Will this fail to build on 32-bit RISC-V (__riscv_xlen =3D=3D 32) when
compiling with Clang?

In run_skid_branch_loop(), the loop counter parameter iters is declared as
a 64-bit u64. Unlike the x86 and ARM blocks which are guarded by 64-bit
target macros (__x86_64__ and __aarch64__), #elif defined(__riscv) matches
both 32-bit and 64-bit RISC-V targets.

On 32-bit RISC-V, general-purpose registers are 32 bits wide, so binding
the 64-bit u64 variable iters to the single-register constraint "+r"
causes Clang to reject the inline assembly with a register size mismatch
error.

Should iters be changed to unsigned long (or uintptr_t), or should the
preprocessor guard check defined(__riscv) && __riscv_xlen =3D=3D 64?

> +		  [s_ip] "=3D&r" (s_ip),
> +		  [b_ip] "=3D&r" (b_ip),
> +		  [e_ip] "=3D&r" (e_ip)
> +		:
> +		: "memory"
> +	);

[ ... ]

> +}

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D6
