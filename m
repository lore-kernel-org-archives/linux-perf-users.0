Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64553FBE1
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190353; cv=none; b=pzGW9AK9bzf2dpqque5/pbeD9u+IPGSKGE8DKZUouak5Cl6P8sD+AEOi/SCz/7PgNY5xsqOO+s2jomgjzXJ3lzvOQLgsAs38u2Wzhnl2MBE7rB9CaypJpY7PpxHlXldU+u+td282OJ9iuUbJ28RlrUoVO24YA670kTWQjWLNUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190353; c=relaxed/simple;
	bh=QLp/gXb+c2TsxfuhCJlUucTu1cXTlTAc9Br4pA3Hm4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oWhMk5vVhfKzhNj3T5u8QPjR/NMTVoYlL4k5FoLNU1moN/A6jypsRZkmeRQ8fYcbw8cL9bc1UunikcSTnI4sVmPlRvL4EN5tIAzbCJcyLIcmX+VB5/a1uqVpviqUF0Svc3UqouFNdSkB+Hmo+EQtITZnEOpvsZk6+To/uH9jbPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn0EmRWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn0EmRWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004C61F00893;
	Thu, 11 Jun 2026 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190352;
	bh=TNQD9reFFDgby1f26nb5R1gJO1rrNExVDErPjQtukjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dn0EmRWnOqpwp3r/gRC9EdWf2fnWnT586grHAIfPQnCJG38Yu7WMcf+2XZfRaRot0
	 ZlG8giUVb6XRyo4ANg42cMn5DVkdMoKB4Iv+whVjfhO8vrRfHvkQ3bQVPdSW/GpFgp
	 nAxJ1YGAIRWcu16FvWo3fVi2xAP+y7s1EBrNPcUbs0AXh3j/1chAez7AACwwElp/BB
	 v8wV2CAVs//FfnPlOEQ93Hjh/BWC/5Xbb25wloqCDfT6GyLPl5ed4yyNN1gbr7ZltH
	 pCc0THIE/MKzmNr7g80+5KwbZZa/hTIuEehpWlkdnXR9IYc3qFGvNbuO0fKJpXaj4u
	 sMJqdbZdkJKVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/8] perf cs-etm: Synthesize callchains for
 instruction samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v8-7-737948584fea@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v8-7-737948584fea@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:05:48 +0000
Message-Id: <20260611150552.004C61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The error path in the newly introduced `cs_etm__context()` overwri=
tes `tidq->frontend_thread` with NULL without releasing the reference handl=
e, leading to a memory leak and a subsequent NULL pointer dereference.
--

commit bbd0982199b3bebe7c4ff65cda463eab43f1b9d7
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Synthesize callchains for instruction samples

This commit adds synthesized callchain support for instruction samples in CS
ETM. It allocates a callchain buffer and utilizes thread_stack__sample() wh=
en
synthesizing the samples. The patch also introduces cs_etm__context() to ha=
ndle
context packets and update thread info.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 830618763d8b1..f37aa41b3587a 100644
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

[Severity: High]
Does overwriting tidq->frontend_thread with NULL here without calling
thread__zput() first cause a memory leak of the reference-counted thread
handle?

Additionally, if the caller ignores the -EINVAL error and continues process=
ing,
could the next CS_ETM_RANGE packet cause a NULL pointer dereference when
cs_etm__synth_instruction_sample() unconditionally calls
thread__pid(tidq->frontend_thread)?

> +	tidq->kernel_start =3D 0;
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v8-0-737948584fea@arm.com?part=3D7
