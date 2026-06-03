Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACA376BEC
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483294; cv=none; b=j+eRum+8Lm/erygO0M2dM3oPjmp9RHNw6d3ocUQbgvEee9B788E6c5F7VCP9PoPzo9dsGeOsNHKN7xlkH/eF/V/G63rGnBfVeySBp5mDGSNNlJZ51WPLMbSU4WcJcTX7jeMj+OJpKmVKAUIs7rIvQP29OFyEXNiHmDXANWkUtVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483294; c=relaxed/simple;
	bh=/Mvf9S02McMawy+PDbFdX9dcL2kpLwvqdZJSQtzJZiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mn7+vcRYhVs5sSRKPRv9XVOkj+NDrY3gZGPVie+nQ2CDwxHYVhhElrJddLb5qH5TWxPL4XMkaj84h9cIiINHoBteBrtffIyllKoH4KPp0p54ZTJgtRrZ0V2GxOXPwyQFUhQJz/bGOEsy/p6L9hGsZEBm2ij65p7XsQsmRL5ShcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad+kXEFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad+kXEFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C65A1F00893;
	Wed,  3 Jun 2026 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483290;
	bh=0clQ4zJ+tJ7Pe0jNulg4Dij2Xfftl+EpAOsmhh2uBLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ad+kXEFAaCKZRGeV1j/ckM+a71Zreji0vJ68WrAP2BtCi8aA7TnCgo5A9fpTm7RPD
	 L2lrWW88FiKSNmR4a4q7H+oZ0kzjL8vf7ZM6BXvBN92xHr9kPdqRjRN6hlCl1CBKMa
	 0XgdnQjH2UPfTBiAxCNcTavacILL6fyRuC2uR6Qu/hnd5+js08iXnd8VZ59ANW0QB4
	 bRThBy4iJ8lFJFEtAQQ+5mWtlfIXwwAEuhFeLhQ+C9j4jptDRX58IhPVRrkM1sIlGE
	 eTh9GMkpXikMIeF8MeW8aVOmByg2TH21bxquqQxeh3nQ/P6mm0oCs8wXQBGHc8uBNw
	 N3e3br6nLudlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/19] perf test cs-etm: Remove unused Coresight
 workloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-15-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-15-c392945d9ed5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:41:29 +0000
Message-Id: <20260603104130.4C65A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The function `cs_etm__synth_instruction_sample` takes a `packet` a=
rgument but ignores it in favor of `tidq->packet` for critical fields, lead=
ing to incorrect instruction synthesis.
- [Medium] Incorrect validation of the double pointer `thread` in `cs_etm__=
etmq_update_thread` breaks the fallback logic and creates a potential segme=
ntation fault hazard.
--

commit b1b29e2b51869a73781c3576698bb30e8e7b0cb9
Author: James Clark <james.clark@linaro.org>

perf test cs-etm: Remove unused Coresight workloads

This commit removes unused CoreSight workloads from the perf tests. These
workloads had issues with out-of-source builds and slow compilation times.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 40c6ddfa8c8d9..ce570913669c1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1490,34 +1508,51 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
[ ... ]
> +/*
> + * Convert a raw thread number to a thread struct and assign it to **thr=
ead.
> + */
> +static int cs_etm__etmq_update_thread(struct cs_etm_queue *etmq,
> +				      ocsd_ex_level el, pid_t tid,
> +				      struct thread **thread)
>  {
>  	struct machine *machine =3D cs_etm__get_machine(etmq, el);
> =20
> +	if (!machine || !*thread)
> +		return -EINVAL;

[Severity: Medium]
Will this early return prevent the fallback logic from executing?

If *thread is initially NULL (e.g. from an allocation failure), this check
returns -EINVAL immediately instead of reaching the fallback assignment
*thread =3D machine__idle_thread(machine) at the bottom of the function.
Additionally, checking !*thread before checking if the pointer thread
itself is valid could lead to a segmentation fault if thread is NULL. Should
this verify !thread instead, or should the !*thread check be removed to
allow the idle thread fallback?

> +
>  	if (tid !=3D -1) {
> -		thread__zput(tidq->thread);
> -		tidq->thread =3D machine__find_thread(machine, -1, tid);
> +		thread__zput(*thread);
> +		*thread =3D machine__find_thread(machine, -1, tid);
>  	}
> =20
>  	/* Couldn't find a known thread */
> -	if (!tidq->thread)
> -		tidq->thread =3D machine__idle_thread(machine);
> +	if (!*thread)
> +		*thread =3D machine__idle_thread(machine);
> =20
> -	tidq->el =3D el;
> +	return 0;
>  }
[ ... ]
> @@ -1579,6 +1614,7 @@ static inline u64 cs_etm__resolve_sample_time(struc=
t cs_etm_queue *etmq,
> =20
>  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  					    struct cs_etm_traceid_queue *tidq,
> +					    struct cs_etm_packet *packet,
>  					    u64 addr, u64 period)
>  {
>  	int ret =3D 0;
[ ... ]
>  	sample.flags =3D tidq->prev_packet->flags;
>  	sample.cpumode =3D event->sample.header.misc;
> =20
> -	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
> +	cs_etm__copy_insn(etmq, tidq, tidq->packet, &sample);

[Severity: High]
Is the correct packet being used for instruction synthesis here?

The function signature was updated to take a struct cs_etm_packet *packet
argument, but this line explicitly references tidq->packet instead of the
passed packet. Since callers like cs_etm__flush() and cs_etm__end_block()
pass tidq->prev_packet as the argument, referencing tidq->packet here will
use stale or incorrect packet data, potentially corrupting synthesized trace
data.

> =20
>  	if (etm->synth_opts.last_branch)
>  		sample.branch_stack =3D tidq->last_branch;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-james-cs-c=
ontext-tracking-fix-v3-0-c392945d9ed5@linaro.org?part=3D15
