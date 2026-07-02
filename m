Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583603148B5
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022858; cv=none; b=ESw2CVw58gVEr+Brg8LY2Pbiac07YF1qvOy1erX81/SobEXdCAm1f1RHetvbUk2rm1QNwsgpOaHRjE55c2srsn6H45EQapoS/YsDh24mBIjsAvP+bHqoUiTWwWRK2OAbtAhyfg0KKxirXFDrA1MYVFSWhzJF7Un7K1LMKtBlx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022858; c=relaxed/simple;
	bh=VB/rB6tKg3XzMNEkLyajSbwOp7ccUCJam4goYL8vZxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U0dWLUvNKTup0eCdtrQirtp1cNshIuwLpkURQaBSig1zseLAnzElwgODlquJ2TKYjNcikIZTe9ehIraMm9X8wryUgcNhcuKFR5VWhrNP492bw4wz/qRZLF4E1KUkHvs6lUoiCv+0ZZV+leAweq/4+t0V5gBvwiLYMvAYjJlFqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hczg3b3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hczg3b3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BAB1F000E9;
	Thu,  2 Jul 2026 20:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783022855;
	bh=4EhGn8Yka+x+/G90TnOdLWFeCs1HR47Wolp6UmI0ejU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hczg3b3PjBDk4Oj/VkVxlnpdZAaP68G++HdWTtMi3KCDSVzY3o7/YQ+qBJHKSmodQ
	 cgMhLyTa+onJMWvcwX4pD3ZfIpkQCWqt5cPAe8RiJDbyIl6pYBRbIXvOP2L9AeE0CW
	 dmZ5VxCWoRa2F42ZLh6VOQT/PFMszbzyusm5tqhTgrOUawyLlsAHBSJZH4YJYZp6O9
	 +bH6KFJt56nXjQS5RDXUPAMJQ+lnc/f3pn3ylhcM/ZJUyEWzKEyZvil448kGIIz5cB
	 VMRE3x1IpLHqql2HHxYzrq7+3NGCxA7yRwHnsIIEwEFxw0FWSWpi08fwlKOYRUBd5B
	 G4yZuGzfG3CmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 8/9] perf cs-etm: Synthesize callchains for
 instruction samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-8-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
 <20260702-b4-arm_cs_callchain_support_v1-v11-8-846abbf600d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 20:07:34 +0000
Message-Id: <20260702200735.58BAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] NULL pointer dereference when cs_etm__context() fails on a trace=
 channel.
- [Low] Missing explicit POSIX libc header inclusion (`<string.h>`) for `me=
mset`, violating subsystem musl compatibility guidelines.
--

commit 962c8fcda00377c91b3a6ef8a062825a14d33107
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Synthesize callchains for instruction samples

This commit adds support for synthesizing callchains for instruction samples
in CS ETM. It allocates a callchain buffer per queue and uses
thread_stack__sample() when synthesizing instruction samples. It also
introduces cs_etm__context() for handling context packets.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f76648fa67681..95e3ec1171acc 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1602,6 +1616,26 @@ static void cs_etm__sample_branch_stack(struct cs_=
etm_auxtrace *etm,
>  					tidq->last_branch, tidq->br_stack_sz);
>  		sample->branch_stack =3D tidq->last_branch;
>  	}
> +
> +	if (etm->synth_opts.callchain) {
> +		if (tidq->kernel_start)
> +			thread_stack__sample(tidq->frontend_thread,
> +					     tidq->packet->cpu,
> +					     tidq->callchain,
> +					     etm->synth_opts.callchain_sz + 1,
> +					     sample->ip, tidq->kernel_start);
> +		else
> +			/*
> +			 * Clear the callchain when the kernel start address is
> +			 * not available yet. The empty callchain can then be
> +			 * consumed by cs_etm__inject_event().
> +			 */
> +			memset(tidq->callchain, 0,
> +			       struct_size(tidq->callchain, ips,
> +					   etm->synth_opts.callchain_sz + 1));

[Severity: Low]
Does this new use of memset() require an explicit inclusion of <string.h>?

The subsystem musl compatibility guidelines state that all POSIX libc funct=
ions
must have explicit header inclusions to prevent compilation failures on str=
ict
libc implementations like musl.

> +
> +		sample->callchain =3D tidq->callchain;
> +	}
>  }

[ ... ]

> @@ -1931,6 +1968,34 @@ static int cs_etm__sample(struct cs_etm_queue *etm=
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
> +	tidq->kernel_start =3D 0;
> +	return ret;

[Severity: Medium]
If cs_etm__context() fails (for example, if cs_etm__get_machine() cannot fi=
nd
a machine context), the error path sets tidq->frontend_thread to NULL via
thread__zput().

If the caller cs_etm__process_traceid_queue() returns this error, but the
outer decoding loop (like cs_etm__run_per_cpu_timeless_decoder()) ignores
the error and continues, could the next CS_ETM_RANGE packet trigger a NULL
pointer dereference?

Specifically, cs_etm__synth_instruction_sample() unconditionally accesses
the now-NULL thread pointer:

	sample.pid =3D thread__pid(tidq->frontend_thread);
	sample.tid =3D thread__tid(tidq->frontend_thread);

Would it be safer to ensure tidq->frontend_thread is not accessed if it is
NULL, or avoid continuing trace processing when the context fails?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-b4-arm_cs_=
callchain_support_v1-v11-0-846abbf600d7@arm.com?part=3D8
