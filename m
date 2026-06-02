Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91303EDE67
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411410; cv=none; b=lFrJgGevMNXA9eyDvxyQB4Xu+YMlO89tSQF1LVPu11ztuCaTpqDyCRAdsabpV2UaBCuzZKFkZpnUwc8ufsdTrA3qUVGqYKVfbH2FnxVRVTy93bBUNjwdq++iE67/YJpq1RUbzgI7NpWmcVeuPTUjtoZHX8+YBtxAyFezz2PI0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411410; c=relaxed/simple;
	bh=nYgm4dSMTOEzZ6mE04+taZ+bYlonYHrdM6lBmZDaUho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZNet1suefKU0Tib9rotAQfTN33bI0Hau14R6sY086Ly+y/aBGbX6v5soqsRVyEIxKwoPXbcmhQWjEO9jKvK2CnLAWTeD/CHLRn2lKJoJv2wE94+D/V0pGcdB+Zz3yy7z7lX5jw/QEmC6Si58zdu1ijV9HuncKm60GQ7srewC8ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohoQmCpg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohoQmCpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DFA1F00898;
	Tue,  2 Jun 2026 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411409;
	bh=1OrrQvBrOLnoVuLQyviJZrdb/NlyL/6yvFQDoiR+acQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohoQmCpge1OukEwm0JFMrDAWcSmpldJIAI1q4r/S5ixqX7/6TwVUwD6T7nYlAfP59
	 nyDgFhguGghikVQ1/0aTDmj1YZlxhD9nJ67q209VO0BnByU5HN0k7hfoSXmRNBEkRB
	 JuY2k9KmpWs6hs4muU/x577W6wukUDn7Farj7nfbg/9ZQ1J3dEyCg1KrKNlCshW4A6
	 itqy2DJOIUW0yIb3RTCvdcrncAqYw7SEoeQ01/4xK2utSXNlyIcDEs4btVoJf3EVAO
	 7bLsU0G71gOtkAfxza9J+COBusPCe5RC9MK0RjBPDgpL4tAs4pkJdBuFgLFhZ3ITsS
	 PCy+AblodJjbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/18] perf cs-etm: Queue context packets for
 frontend
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-1-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-1-85b5ce6f55c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:43:29 +0000
Message-Id: <20260602144329.A5DFA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect CPU mode attribution in `cs_etm__synth_instruction_sam=
ple()` during flush due to relying on `tidq->packet->el` instead of the exc=
eption level belonging to the instructions being sampled.
--

commit b9c32b9ed06ee8adb88b0b63943c694b4108e629
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Queue context packets for frontend

This commit adds a CS_ETM_CONTEXT packet to carry thread ID and exception
level to the frontend. It separates memory access functions between frontend
and decoder, and removes prev_packet_thread tracking.

Closes: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-a=
aupov@meta.com/

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 40c6ddfa8c8d9..524e2a6feba8e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1588,15 +1632,15 @@ static int cs_etm__synth_instruction_sample(struc=
t cs_etm_queue *etmq,
> =20
>  	perf_sample__init(&sample, /*all=3D*/true);
>  	event->sample.header.type =3D PERF_RECORD_SAMPLE;
> -	event->sample.header.misc =3D cs_etm__cpu_mode(etmq, addr, tidq->el);
> +	event->sample.header.misc =3D cs_etm__cpu_mode(etmq, addr, tidq->packet=
->el);

[Severity: Medium]
Does this misattribute guest traces to the host when synthesizing samples
during a flush?

When cs_etm__flush() or cs_etm__end_block() calls
cs_etm__synth_instruction_sample(), it generates samples for the execution
range of tidq->prev_packet. In these scenarios, tidq->packet holds a
CS_ETM_DISCONTINUITY packet (or a stale packet) where the exception level
is ocsd_EL_unknown.

Passing this unknown EL into cs_etm__cpu_mode() causes guest trace execution
from before the discontinuity to be misattributed to the host machine
(PERF_RECORD_MISC_KERNEL or PERF_RECORD_MISC_USER) in the profile statistic=
s.

>  	event->sample.header.size =3D sizeof(struct perf_event_header);
> =20
>  	/* Set time field based on etm auxtrace config. */
>  	sample.time =3D cs_etm__resolve_sample_time(etmq, tidq);
> =20
>  	sample.ip =3D addr;
> -	sample.pid =3D thread__pid(tidq->thread);
> -	sample.tid =3D thread__tid(tidq->thread);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-james-cs-c=
ontext-tracking-fix-v2-0-85b5ce6f55c6@linaro.org?part=3D1
