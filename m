Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE833067F
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622617; cv=none; b=SqjlEZAcZP9LSDCULLxKQDz9J/T9Tbnhs6uF7AOfhBSsR0m78u0++k5w6hH8EEs2JwoJx9pl4fWj7MHLN1JsV3osMKDHyw9XCOH8QIubHKVlyT+CH6Jo22yiRne9vGYjNzNIWbEh5SF4EoDvtqNwONrfu2kygtkHUHzuiNz0/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622617; c=relaxed/simple;
	bh=5BGMlgjB6tuNO5yRlMdjtJ/DzILVXpC9O70FXsSAulo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJFGpJDIhuYz/FlZ9gi9XS/hZ7bPikJsMpJ0dedSPHDbAjbl4XqcQocXrdIET2AipPCQNyHKedTecGgnSaWF20HsU6jvYirjSw60dw7i/XEH5WFmkYL+0RSZbRRBQSRIXtgrk+7EHZm8gRDNuPzEB5Eh5dD6aNFX5WdxLtapBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLJFiG2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLJFiG2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299B91F000E9;
	Tue, 16 Jun 2026 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622616;
	bh=Ff15yl0DCtDK7g3IPrds3Q0v0Ae1oUpsWIeNEghqcUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jLJFiG2BDgDj8g4U1QjGjS299g2BXdf2PskqNbAcUe8h7P45f+hr0zwXHmDoOAahg
	 zJshYOH7B87dZJtSqvfd9wnrUfxbyQeHbvIfjlFKY6BiJtbjLW/kXbNJmiFh5TYJRI
	 VEwspkq3XmGxU6aHZGi4pI23jsfAHrSx9eOYR8xZyA3acwvdsT9Imy1ZPCR3YnbWjZ
	 QXVr1ssKQ2d/j0NVkCNSX+D/SBbYAO2n+7QHCIGKDhL0DEdPJS/7IgkdrUFtUW+pcz
	 yJcSvyHjPmkOBnvF9zVD+EQjJxvgtLQbL1zNKQYw1EII5PwoDjMuGHnLqLc8XeRonr
	 mZnbC/TKm3iaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/9] perf cs-etm: Flush thread stacks after decoder
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-6-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-6-f8fad931c413@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:10:15 +0000
Message-Id: <20260616151016.299B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `cs_etm__flush_all_stack` fails to flush thread stacks when the =
trace format is `CS_ETM_PIDFMT_NONE`, leaving stale branch history for trac=
es without context IDs.
--

commit c2d1898309c0432c8c4f6c738f95194793449ff7
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Flush thread stacks after decoder reset

Perf resets the CoreSight decoder when moving to a new AUX trace buffer,
causing global trace discontinuity. This commit flushes host and guest thre=
ad
stacks after a decoder reset to prevent stale call/return history from
producing incorrect synthesized callchains.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 51b05a0bc1898..d41aad583a26f 100644
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

[Severity: Medium]
For traces without context IDs (CS_ETM_PIDFMT_NONE), will this skip flushing
the thread stacks entirely?

Even in per-thread recording without context IDs, traces are still attribut=
ed
to threads stored in the host machine (HOST_KERNEL_ID) which actively
accumulate branch stack histories.

Could this leave stale call histories intact across resets for these traces,
producing incorrect synthesized callchains? Should HOST_KERNEL_ID also be
flushed when the format is CS_ETM_PIDFMT_NONE?

> +
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-b4-arm_cs_=
callchain_support_v1-v9-0-f8fad931c413@arm.com?part=3D6
