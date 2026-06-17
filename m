Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC337B00F
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732111; cv=none; b=i/RRicI0lFjvlzdZI1rND/AQ2gHfAKxZji/D3ZdjEf14hrbWINORu0ehj/uGxTU3YM2sf8Z2aQWXyjzxbzVgXGU/o7JEJmIcVWUnjEM75pJ2oKA0bstLvvB8ImpymkcQYQnK6vPxWWc/20jUFTxA249GfCn015n+gE+i6ioKmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732111; c=relaxed/simple;
	bh=Le7j/B99x/F6h5AdI7b2lhtkQ+i453sxG02o9GV1Pq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VfZxQk7/R9XkMNYYvsX8ZdC+bQ3zIdrJrfokcr798YcBq3MJ9m9d11A5aWRxYdP3YJPhFpUiVHVOZoD0rxvam6a6IQS9SxMP3IyQCccRByhysq26RiogdpPvNpul91X1IcEDWFASRgkwmNaA8aYkUAG2blL9DNdXyJ07YlFHpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx6w8vLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx6w8vLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2031F000E9;
	Wed, 17 Jun 2026 21:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781732110;
	bh=qx/CJke+W9m4FPhu3HBeknuUAFLMK729MpS7VXiSsDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jx6w8vLG0i2UomTKn4ymhApiq05Kxi5vfuoX6p3wp7xv9NQA4FUJOxfkdB3Pt2e8q
	 KWgkLph4gPDGh8B71l9fJNO0NfulfHywyETIPWFCRUg3UA7VN9JoNq49xBBZrFNV5m
	 2p65OjRAcfIxQEdq+pBYPYjScdbEQXP9fZGEYUjPMLNehZk490Xy3YxZHMgfW1aoT9
	 9bf8gY8dFj+AiBwoA+ZiZ+qcz7WKqZbAlBLAf+9WGz/JLX4TnYjy95PbebdY8U0MRo
	 FRm0iLztbq2aCvFeHTAkNGa7ahoSIob4j6SzktVO3uyw6um5CKQ9WZ10m8bzF0Hu4L
	 wTafdUz7cLZxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/9] perf cs-etm: Synthesize callchains for
 instruction samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-8-e8b6e5d63db5@arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <20260617-b4-arm_cs_callchain_support_v1-v10-8-e8b6e5d63db5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 21:35:10 +0000
Message-Id: <20260617213510.9C2031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The error path in `cs_etm__context()` destructively nullifies `t=
idq->frontend_thread`, leading to a predictable NULL pointer dereference cr=
ash in the perf tool when processing subsequent packets.
--

commit 3e6647ae053d9c4c2c79da5f0062f4a5c6da23e3
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Synthesize callchains for instruction samples

This patch adds callchain synthesis for instruction samples in CS ETM. It
allocates a callchain buffer and introduces cs_etm__context() to handle
context packets. The synthetic instruction events are updated to advertise
PERF_SAMPLE_CALLCHAIN.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 30536b919af73..67885ed43bab9 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1910,6 +1947,34 @@ static int cs_etm__sample(struct cs_etm_queue *etm=
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
> +	thread__zput(tidq->frontend_thread);

[Severity: Medium]
Can this error path lead to a NULL pointer dereference crash in the perf to=
ol?

If cs_etm__get_machine() fails, we take the err path and nullify
tidq->frontend_thread here.

If the caller, such as cs_etm__run_per_thread_timeless_decoder(), ignores
the error and continues processing the trace buffer, a subsequent
CS_ETM_RANGE packet will call cs_etm__synth_instruction_sample(). That func=
tion
unconditionally accesses the nullified pointer:

    sample.pid =3D thread__pid(tidq->frontend_thread);
    sample.tid =3D thread__tid(tidq->frontend_thread);

> +	tidq->kernel_start =3D 0;
> +	return ret;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-b4-arm_cs_=
callchain_support_v1-v10-0-e8b6e5d63db5@arm.com?part=3D8
