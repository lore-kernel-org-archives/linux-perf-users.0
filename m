Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B523BED37
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053813; cv=none; b=jl6p5u2MQHm3DihPCW+ChzOcHqyAs704ZRmZ56OlYeTx6fL56bJemYpqS7QksgUMakRODaYuvtSWfK8Pht+hahz/80BcVWqO9qQcw0cPpuJsvKccdma33rFVOPpBByvBHAxaQRFAIeaLEuSTvUIeCteIC7arzVmX5E2Os+lCesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053813; c=relaxed/simple;
	bh=+DVi+EbxIjergh8989W+aZpInstE8bUW0Bwkh8275u8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gLOGKKAphx+DxQlYcHfWTgKBwr8Yr4xsVXatdmxdEUtzh0UkdGVbv3wafCUbQoMBYkssHNYJCPBx8/wChfBkxPkwd1lR058rCn1srijzkVAo96jdNhfxtTuFgd0oSrb+eII7HqAd9c7AfwwGSNfAJWhH3xLjIh0mcOPFZGUH/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWsFhSpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWsFhSpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140E61F00893;
	Fri, 29 May 2026 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053812;
	bh=Bll7yPBJ1EPfFsPPODrcU85p+1lYLjECAZTr+JEAXy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWsFhSpJAcnNoTto76lam51TsYGkA0qE6yatAWteqaQikMLCCaOmMcOhFmjImXzys
	 BEcz4WZFC6OsW1hyWV7vD/auUTYH1/9ZLta+RDiaheeFcVBY43Mmz1rNarwVY1s8L7
	 G9iGANlWfI3yrFXUmUCff7cwV3iWfkhuiTtdH3txuRD/YIN4VpMSisiYM+JM0TcSid
	 LB1AC6D19POEDetlWwr8b+RjwPeiOLwjTx9ZIHooga+Q9Z5ZsOoM2/duZz26dWgwMO
	 jzfekT6wvixvXtX5BoBP2C67lEuKZW1Oq4+MzwbNQpqlu6gMgNbOgiELMWcImL0mLz
	 bSag5rMgeb9Sg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 4/5] perf regs: Enable dumping of SIMD registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529082451.591783-5-dapeng1.mi@linux.intel.com>
References: <20260529082451.591783-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 11:23:31 +0000
Message-Id: <20260529112332.140E61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Misleading post-increment of `idx` in `simd_regs_dump__printf` inne=
r loop.

Pre-existing issues:
- [High] Integer underflow in manual `sample_size` calculation in `perf_eve=
nt__convert_sample_callchain` corrupts the event stream if registers are mi=
ssing.
--

commit 7e4b22be95dca28326d1271ce91f25c99e231f74
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf regs: Enable dumping of SIMD registers

This patch adds support for dumping SIMD registers using the new
PERF_SAMPLE_REGS_ABI_SIMD ABI.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -457,8 +457,13 @@ static int perf_event__convert_sample_callchain(cons=
t struct perf_tool *tool,
>  	/* adjust sample size for stack and regs */
>  	sample_size -=3D sample->user_stack.size;
>  	sample_size -=3D (hweight64(evsel->core.attr.sample_regs_user) + 1) * s=
izeof(u64);

[Severity: High]
This is a pre-existing issue, but does unconditionally subtracting the full
expected size of the register mask cause an integer underflow if the perf
sample didn't capture user registers?

If the sample didn't capture user registers (e.g., when sampling a kernel
thread), the ABI is PERF_SAMPLE_REGS_ABI_NONE (0). It seems subtracting the
full mask size would underflow sample_size (a u32), resulting in a massive
size being written to event_copy->header.size.

Could this corrupt the event stream or cause out-of-bounds reads when
perf_event__repipe_synth writes to the pipe?

> -	if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_=
SIMD)
> -		sample_size -=3D 4 * sizeof(u64);	/* Reduce SIMD regs header size */
> +	if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_=
SIMD) {
> +		sample_size -=3D 4 * sizeof(u64);
> +		sample_size -=3D (sample->user_regs->nr_vectors *
> +				sample->user_regs->vector_qwords +
> +				sample->user_regs->nr_pred *
> +				sample->user_regs->pred_qwords) * sizeof(u64);
> +	}
>  	sample_size +=3D (sample->callchain->nr + 1) * sizeof(u64);

[ ... ]

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c

[ ... ]

> +	for (i =3D 0; i < regs->nr_vectors; i++) {
> +		for (j =3D 0; j < regs->vector_qwords; j++) {
> +			idx =3D i * regs->vector_qwords + j;
> +			if (regs->vector_qwords > 1) {
> +				printf(".... %3s[%d][%d] 0x%016" PRIx64 "\n",
> +				       name, i, j, regs->simd_data[idx++]);

[Severity: Low]
Is the post-increment of idx necessary here?

Since idx is re-initialized at the start of each inner loop iteration
(idx =3D i * regs->vector_qwords + j), the incremented value seems to be
discarded on the next iteration.

> +			} else {
> +				printf(".... %3s[%d] 0x%016" PRIx64 "\n",
> +				       name, i, regs->simd_data[idx++]);
> +			}
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529082451.5917=
83-1-dapeng1.mi@linux.intel.com?part=3D4
