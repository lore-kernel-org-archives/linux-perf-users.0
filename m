Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03C36F8F1
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622764; cv=none; b=SkH9eXvxirb5d4lcdMtpAvtwnJA+cE0qy9E80uPbaqW2ljAGmS8xdfVcwld9kjU2xYrdGLekx7b6Cu3TJttb14zalAi1zaWWB3YshI2f8O7e+BzETzn65L/IICJpegwldkeN07UEXXwKy4m/rPeeJ2e054rB1w60qPwtcO/PFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622764; c=relaxed/simple;
	bh=H71fy9ZouarCfpNJo1sVfAxZZCMTbZXsFRCajZ2Sb0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nBsQtFu5kCQ44pQzkYjfmMdG5KY4TP6Wcfp+z01kVulFIaCmgNeX0YNm1o/tAvsFaz7U2WHbEG4JN04eI7Ifly2hmF8oS+C/nGeWSj6ZRNCn4OCaojx9WNHawN8NCOQRWuaV9XAa4ybmHLzCw93apVYDXx8J2OeFGk6V9DG0jD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFPoFY3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFPoFY3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC161F000E9;
	Tue, 16 Jun 2026 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622763;
	bh=9QkK8KcLn7jLj14bl7A2Gd2qRyAcfW+Uh8PEQD1BsaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bFPoFY3A4rbSyHuzvcC6p+7HqaLoCjuHTwwCKD2I+QbaLvWuSonWn7uOqGblhZuqN
	 JJhxVwqILF4ogzCj3q1Xzwzzx0b7oNLbEnZhAzH4kw2X+lWZm9HxkkrSvPJAtmag7W
	 RkJdCrCUlxGHGw2RGc8L95/4Dk378lC/XG6vL+TgeY0j59lSO+KKcivtUFpnUjW3Mo
	 dXUTuMGWKNvkxpiX8zjyWWNE7paPLdF6S5o5VP6lrv4npz+LG7OJG+COFqFwU1t+v0
	 3UvLhMuD/EaGFySfjsIZf4kUwvr1Ez/zPprHQ8k814ojF1DaF2guihay7XtRlP7//6
	 1fYss62ufYnRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/9] perf cs-etm: Synthesize callchains for
 instruction samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-8-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-8-f8fad931c413@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:12:43 +0000
Message-Id: <20260616151243.8CC161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Prematurely freeing `tidq->frontend_thread` on the error path in=
 `cs_etm__context()` leads to a fatal NULL pointer dereference.
--

commit beaeb914d5e99fcdf91b04714fe39931a7466896
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Synthesize callchains for instruction samples

This commit synthesizes callchains for CS ETM instruction samples. It alloc=
ates
a callchain buffer per queue, uses thread_stack__sample() for instruction
samples, and introduces cs_etm__context() to handle context packets.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index e18d2dec79431..34489476681b8 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -1904,6 +1941,34 @@ static int cs_etm__sample(struct cs_etm_queue *etm=
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
Will this error path result in a NULL pointer dereference?

If cs_etm__get_machine() or cs_etm__etmq_update_thread() fails, thread__zpu=
t()
is called which drops the reference and sets tidq->frontend_thread to NULL.

However, the calling loops, such as cs_etm__run_per_cpu_timeless_decoder()
which calls cs_etm__process_traceid_queue(), can ignore the error and conti=
nue
processing trace buffer packets.

When a subsequent packet like CS_ETM_RANGE is processed, it calls
cs_etm__synth_instruction_sample() which unconditionally dereferences the N=
ULL
thread pointer:

cs_etm__synth_instruction_sample() {
    ...
    sample.pid =3D thread__pid(tidq->frontend_thread);
    ...
}

Should the frontend_thread pointer be preserved on failure, or should the
caller be updated to abort packet processing when an error occurs?

> +	tidq->kernel_start =3D 0;
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-b4-arm_cs_=
callchain_support_v1-v9-0-f8fad931c413@arm.com?part=3D8
