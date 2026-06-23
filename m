Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD5393DC0
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246267; cv=none; b=rro9wxZJzN8jiRy54kGNu8CeHIH5DQfdO0CwKQ717aXMtisgRiZACg2o0KgjrHmu2DMgORKM3hPylH0frbVTe/AXXp4omUrLaho0/8kdJonK9btStfkxY3WZpd1zuhEXxCTa3leVgYKiphqt0cv6staf9ithwx3S93F7q2xqDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246267; c=relaxed/simple;
	bh=xSTzroVuXPwijFbJC7EnhRmiamtRbHX3u6dSsynZvC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NmgkZozmSBCNFXyWlLKESs5qXRK2krYhZEBMU1BvIY+mOez3IVBX+w2syIKxi9QBhT3w5GxW/0piOmQSf0S5HQ1Qm8iyqwTqpdvZEoPtIjSzUs3l/p1BBGfCwrOVk2Ku2RM6XnYPPUZRmU/tRws8QzoqAAf8W9zb2q2PRYfWlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZw2QtM2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZw2QtM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB831F000E9;
	Tue, 23 Jun 2026 20:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782246265;
	bh=wbcWm42PSgKlSS1FFdjxvKi7o4VWHNiVTqMX0O4ucf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZw2QtM2SHjYLmSYlh1xq4F+I7K3pxn2l9IKVBRQZavTiGkJ0kK6ElX6kqLrRblxD
	 nygiY7AorBg9lr8Cwf8q90MFjhuWUEg4pCbzTUk/rQUVsHIBpq/sI/O0KCaFOOS3AF
	 fdivuTtFmZrIMTDJgtV2BBgX/C95DLF+q0i8d5ke8k1UKGxH04/tje287fgVZTsJOR
	 ieVR1N4ytlZHVeKXK9apShtP1WGMZfMQerslS1aH3xcF7a1sntF7INF/iLkDlOHfxJ
	 827+nta6/QDoY03t/aTW5aZIeo0y9ZNh+3/PuezcSg4RdT0n9xn3eBayHzifncz1oT
	 2mG0Uy4YQqUyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/8] perf cs-etm: Synthesize callchains for
 instruction samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-7-1ba770c862ae@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-7-1ba770c862ae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:24:25 +0000
Message-Id: <20260623202425.8CB831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The error path in the newly introduced `cs_etm__context()` leaks=
 the thread reference count and causes a subsequent deterministic NULL poin=
ter dereference.
--

commit 08ea8a8a8959ce5cc5f77e8d3b133c16e92cb0b7
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Synthesize callchains for instruction samples

This commit adds callchain synthesis for instruction samples in CS ETM.
It allocates a callchain buffer per queue and uses thread_stack__sample()
when synthesizing instruction samples, and introduces cs_etm__context()
for handling context packets.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1895,6 +1932,34 @@ static int cs_etm__sample(struct cs_etm_queue *etm=
q,
>  	return 0;
>  }
> =20
> +static int cs_etm__context(struct cs_etm_queue *etmq,
> +			   struct cs_etm_traceid_queue *tidq)
> +{
> +	ocsd_ex_level el =3D tidq->packet->el;
> +	struct machine *machine;
> +	int ret;
> +
> +	machine =3D cs_etm__get_machine(etmq, el);
> +	if (!machine) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	tidq->kernel_start =3D machine__kernel_start(machine);
> +
> +	ret =3D cs_etm__etmq_update_thread(etmq, el, tidq->packet->tid,
> +					 &tidq->frontend_thread);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	tidq->frontend_thread =3D NULL;
> +	tidq->kernel_start =3D 0;
> +	return ret;
> +}

[Severity: Medium]
If the code jumps to the err label, it sets tidq->frontend_thread =3D NULL.
Since the thread struct uses reference counting, does this overwrite leak
the existing thread reference?

Additionally, if the outer decoding loop ignores this error and continues
processing trace packets, could this lead to a crash? When a subsequent
CS_ETM_RANGE packet is processed, cs_etm__synth_instruction_sample() will
unconditionally dereference the NULL thread pointer here:

tools/perf/util/cs-etm.c:cs_etm__synth_instruction_sample() {
	...
	sample.ip =3D addr;
	sample.pid =3D thread__pid(tidq->frontend_thread);
	sample.tid =3D thread__tid(tidq->frontend_thread);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v7-0-1ba770c862ae@arm.com?part=3D7
