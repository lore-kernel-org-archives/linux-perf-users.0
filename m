Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B613DBA0
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966180; cv=none; b=r8b+hzQ0MiYSSF4Hm2hD05yeVy67bR9pSNCPRKZPGwHccfcop7IGDBx3Uqi8RSf8Hiepa4/RjzxdLVu06DC4EKuheEnC2Jb/jf0DoEpC58fB2F6Z2hpEHdqVRYv3GmmWeJviYDNWBt5l+FtYwY6ik5/g4LmW/Oy1yyNL4f+AJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966180; c=relaxed/simple;
	bh=li3an3GdW++7e3Fduq3VCREU/pRnFNnOUlXtjm4wv8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sRs3ljZO4I0QPGlYCNhrBH2Pm/1yeLgjWFQjmhFPyRkJt7Yj3FCpsjJqF769JCJPFEioF/56wM+vDyF+QJLSwTtikSdmIrjHti9mThyRLcu2NgK96WH6jAm4R1Bi4lD68WOmF+Z4W9FzS2FNJy9fGrw44ghH5pYNnBtDKzP0wks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOk8kaZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOk8kaZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650181F00A3A;
	Mon, 13 Jul 2026 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966178;
	bh=Si47PtGjDqh3KmG/bbuLVgAaJNmDWpuiJzGPn7Hk+34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOk8kaZM6HvETZwDZK/58NJmW/vRx3U9jtc8nSJo6v/esNXTpDYR+vL8L4ZzYPfjl
	 4hHJ9/F2Kl6muU8UnegN/BFWeyeieq+EeDAIgcJd+AQ7AbZn1Y8A2T+/nou4FYBS5n
	 E7jla16W5SRiaY+PUoBJxE9zOx2J2Bvqae7kNrVlnOhRdmuHBLfKsrNRdWwz1SY5e5
	 bUrKVl3pwHFD2l0dB2GHNIRVHc000u1TicxjH4v3jxz3NfjGTLo/GZXk78NLRuIh+e
	 apEZ7rsNxKJYZ8h70yPllNq7oSYPGQkdoYmJRDjb0e7gILnHV9o8CDq0SL3gJttyR7
	 UsNY5x3CiIbzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf cs-etm: Avoid bogus branch samples before
 async exceptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260713-perf_cs_etm_fix_non_taken-v1-1-4561607fc69f@arm.com>
References: <20260713-perf_cs_etm_fix_non_taken-v1-0-4561607fc69f@arm.com>
 <20260713-perf_cs_etm_fix_non_taken-v1-1-4561607fc69f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 18:09:38 +0000
Message-Id: <20260713180938.650181F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Restricting the `last_instr_taken_branch` fixup strictly to SVC in=
structions silently drops valid branch samples for all other exceptions, in=
cluding asynchronous interrupts and other synchronous exceptions (SMC, HVC,=
 aborts, breakpoints), breaking the control flow graph from user/kernel spa=
ce into the exception handlers.
--

--- Patch [1]: [PATCH 1/2] perf cs-etm: Avoid bogus branch samples before a=
sync exceptions ---
commit d678304a350e693f048123702c01ddab5fbae8a5
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Avoid bogus branch samples before async exceptions

This commit updates the CoreSight ETM decoder to avoid synthesizing bogus
branch samples before asynchronous exceptions. It does this by restricting
the fixup that forces the taken branch flag to true so that it only applies
to SVC (system call) exception entries.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 95e3ec1171acc..05e698f666bbe 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1999,17 +1999,20 @@ static int cs_etm__context(struct cs_etm_queue *e=
tmq,
>  static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
>  {
>  	/*
[ ... ]
>  	 */
> -	if (tidq->prev_packet->sample_type =3D=3D CS_ETM_RANGE)
> +	if (tidq->prev_packet->sample_type =3D=3D CS_ETM_RANGE &&
> +	    tidq->prev_packet->flags =3D=3D (PERF_IP_FLAG_BRANCH |
> +					 PERF_IP_FLAG_CALL |
> +					 PERF_IP_FLAG_SYSCALLRET))
>  		tidq->prev_packet->last_instr_taken_branch =3D true;

[Severity: High]
Does this exact flag match inadvertently drop valid branch samples for other
synchronous exceptions like SMC, HVC, or data aborts?

These other exceptions use PERF_IP_FLAG_INTERRUPT and won't match the strict
mask introduced here. When tracing into hypervisors, secure monitors, or
exception handlers, the last_instr_taken_branch flag will remain false, whi=
ch
prevents cs_etm__synth_branch_sample() from being called for the exception
entry.

Could this break the control flow graph for these traps by omitting their
entry branch samples?

> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-perf_cs_et=
m_fix_non_taken-v1-0-4561607fc69f@arm.com?part=3D1
