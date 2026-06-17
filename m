Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508ED38D40A
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730524; cv=none; b=JjOFQeELxTfaAMM99HImX6FzZib4Jrtj3/mCY8Nszbu32uqtJRbp70kS9e0R0Vz9R2xdSRhPJMRvoJrS2CpwyHLr4Ihr9m1NNTsh1ZOuSttXj77wT1J26ddey/m8PUIoNkKDBWvpvAX0SVrN/Ty34+5U/q6XkbPiynAUFaVmxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730524; c=relaxed/simple;
	bh=TDoetV+96yq2ZNzpzFQDNRixgVB5Hze2gxt4WqbKcRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ef3FncggzGZ+HlQIVBgODtYxpyT0o0QnR/n8dfqUJ4hngPjJpMCmaKxBBmvECSd4G+Ge6PVBkZ3wn6FOwpcKxnjDktNvXCh9NzM7OknP/h/2IEO3Qg/FnGnTqEdwnwQdWysu3b1DTwMvP9zbD4qQP/wjeA/CelSltGPHNkE4YCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOJTAmRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOJTAmRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CCB1F000E9;
	Wed, 17 Jun 2026 21:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781730522;
	bh=RpIF1GNO7gYVU24XIHQSQqgpqcSPskNAZbStt9zf/hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOJTAmRvz0m6/x1DxPSYkNdSsEz7odxehMWOuEmo04WI0xtydGS+BPppvZk1IPgX+
	 ePIZC3W9v/rcC6vwyuKTyzPMEXPaq7qcgRFMDkVRW7ute/tjBoHSLr2bLx2gXYHnJT
	 NDQ6XZeBQQUHEBWbhFARKw5gb2Tn8n1Raq3N4ow0U1mH16TLvziEwl7jfWuEbCzG9z
	 JE6hBX2QoN6DP+OuxEiHmunGBTKkBb91NTeEHgbL6P1HsjpEl1mSxNArbCiXSZk2eg
	 4jjPcS7PeVHhY0pP+gqpfCh5ok1F9WNUy91K9VpTihToRNGLrWf/2TD2qvxrqyZl6w
	 Bd82z1mVrTtnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/9] perf cs-etm: Flush thread stacks after decoder
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-6-e8b6e5d63db5@arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <20260617-b4-arm_cs_callchain_support_v1-v10-6-e8b6e5d63db5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 21:08:42 +0000
Message-Id: <20260617210842.D0CCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing thread stack flush for traces recorded without context IDs=
 (`CS_ETM_PIDFMT_NONE`), leaving the stale callchain bug unfixed.
- [High] Global thread stack flush on a per-queue (per-CPU) trace discontin=
uity inappropriately wipes valid callchains for unaffected threads on other=
 CPUs.
--

commit 50abc287497c8a3fa0588b51842fb028097af238
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Flush thread stacks after decoder reset

Perf resets the CoreSight decoder when moving to a new AUX trace buffer,
which causes a trace discontinuity globally. For callchain synthesis, keepi=
ng
thread-stack state after a decoder reset can leave stale call/return history
attached to threads that are decoded later. This patch flushes all host thr=
ead
stacks, and guest thread stacks if virtualization is present, after a decod=
er
reset.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5ede0f0ff8c6e..e43f0c1dd0078 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> +static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
> +{
> +	enum cs_etm_pid_fmt pid_fmt =3D cs_etm__get_pid_fmt(etmq);
> +
> +	if (!etmq->etm->synth_opts.last_branch)
> +		return;
> +
> +	switch (pid_fmt) {
> +	case CS_ETM_PIDFMT_CTXTID2:
> +		/* Clear the guest stack if virtualization is supported */
> +		cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);
> +		fallthrough;
> +	case CS_ETM_PIDFMT_CTXTID:
> +		cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
> +		break;
> +	case CS_ETM_PIDFMT_NONE:
> +	default:
> +		break;

[Severity: High]
Does skipping the flush for CS_ETM_PIDFMT_NONE leave the stale callchain
bug unfixed for traces without context IDs?

Even when Context IDs are absent (e.g., in --per-thread mode or unprivileged
system-wide tracing), perf still maps execution to tidq->frontend_thread on
the host machine (HOST_KERNEL_ID), accumulating branch stack history on tho=
se
threads.

By bypassing the flush here, a decoder reset discontinuity would leave stale
call/return history on these thread stacks, producing the exact same incorr=
ect
synthesized callchains this patch intends to fix.

> +
> +	}
> +}
> +
>  /*
>   * cs_etm__get_data_block: Fetch a block from the auxtrace_buffer queue
>   *			   if need be.
> @@ -2034,6 +2073,12 @@ static int cs_etm__get_data_block(struct cs_etm_qu=
eue *etmq)
>  		ret =3D cs_etm_decoder__reset(etmq->decoder);
>  		if (ret)
>  			return ret;
> +
> +		/*
> +		 * Since the decoder is reset, this causes a global trace
> +		 * discontinuity. Flush all thread stacks.
> +		 */
> +		cs_etm__flush_all_stack(etmq);

[Severity: High]
Does this code unnecessarily wipe active branch histories on unaffected CPU=
s?

When a trace buffer hits a discontinuity, cs_etm__get_data_block() resets t=
he
decoder for that specific etmq. However, cs_etm__flush_all_stack() ends up
calling machine__for_each_thread() to indiscriminately flush the thread sta=
cks
of every single traced thread system-wide.

In a per-CPU tracing scenario, a trace buffer wrap on CPU 0 is a local,
queue-specific discontinuity. By flushing the global machine, doesn't this
unnecessarily wipe the contiguous and valid branch histories of threads
currently executing on other CPUs, potentially corrupting their callchain
synthesis?

>  	}
> =20
>  	return etmq->buf_len;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-b4-arm_cs_=
callchain_support_v1-v10-0-e8b6e5d63db5@arm.com?part=3D6
