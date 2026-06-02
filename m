Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3632BF52
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382482; cv=none; b=sZ/hjg88iBmd2xAu72Yu0rdjTsAdZW/O9iGVVrfTcJHC77zfhjBTNlksBzb+OlSnDgcOS6t0k/rUdiioW2wSWN+CLxcwPGeSefP6Si644zSOjN6LjiSG8kjZrkM7MWDePUvIra8UBC0dnBOgUpA4f8iq7xaNtssGFhdqLLkuDXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382482; c=relaxed/simple;
	bh=OLBr0biYmcajQvpIpCi04FKr0JzRA0VxHzIm70ruQJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3dnIcBI/mKBgrqT3AEJXcyw0ODkAux7G0siPRG0LLi23Ups55m2jkWySfCI160Fyak7lOOn0Hy0dKz3kpQQHQd2UjjWcytEmaOHmQIYvA7KfcTuSaFjgU3XM04Q9bb5eQ1QbfHM/KZAib/emwLwW+xaoDrnJSFs7GSHVfUmeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBr9HDOH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBr9HDOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151531F00898;
	Tue,  2 Jun 2026 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382481;
	bh=tqRmOiGrtg2A5c+v+Vme1W2EfoB5yRqzFfhwzYSC8Oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kBr9HDOHmLAsZ2DwPQJ3ahTRtup0mdYGBbf3HpWz8BeNYTp8ycZlpeE0WNpG3EWIj
	 XiOjD5pJ8PMlikc7M3+/6eVrkdVMU204wNi8KLQiDyU26AssBRDtgh4qwo8yaBWedt
	 Yr1b2CQGZ8As7/IoVI5X1INzOz1yOAaq3J8senfbxEEfytHHXGjL2+B4BvsR6CZUW8
	 aL2tyGsmo88/AhtpaBdZkNWXDfKwwa5skQ2NJZ31BzSgJJLXUx8mRYriIxsmDl0poM
	 cjPME7oh3aTfYHdg25T/iTv1nsit/S4+ZwbQQvzyOoT1Bdt9F7RVi8RmDLPk/0qplj
	 uw8CuekKmokYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/19] perf env, dso, thread: Add _endian variants
 for e_machine helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-4-irogers@google.com>
References: <20260602062452.2583619-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:41:20 +0000
Message-Id: <20260602064121.151531F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Lockless double-checked initialization of `thread->e_is_big_endi=
an` lacks necessary memory barriers.
--

commit 0695e7d47980d268e68f0873d5d1c5a0e48b59c7
Author: Ian Rogers <irogers@google.com>

perf env, dso, thread: Add _endian variants for e_machine helpers

This commit adds endian-aware variants of the e_machine helpers, including
dso__read_e_machine_endian and thread__e_machine_endian. It allows querying
the absolute endianness of a DSO or thread to support cross-architecture
analysis in tools like Capstone.

> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index aac9cb75dcf44..ba33c0dfc18fe 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
[ ... ]
> @@ -458,24 +461,38 @@ static int thread__e_machine_callback(struct map *m=
ap, void *_args)
[ ... ]
> -uint16_t thread__e_machine(struct thread *thread, struct machine *machin=
e, uint32_t *e_flags)
> +uint16_t thread__e_machine_endian(struct thread *thread, struct machine =
*machine, uint32_t *e_flags,
> +				  bool *is_big_endian)
>  {
>  	pid_t tid, pid;
> -	uint16_t e_machine =3D RC_CHK_ACCESS(thread)->e_machine;
> +	uint16_t e_machine;
[ ... ]
> +	e_machine =3D RC_CHK_ACCESS(thread)->e_machine;
> +	args.machine =3D machine;
> +	args.e_flags =3D 0;
> +	args.e_machine =3D EM_NONE;
> +	args.is_big_endian =3D false;
> =20
>  	if (e_machine !=3D EM_NONE) {
>  		if (e_flags)
>  			*e_flags =3D thread__e_flags(thread);
> +		if (is_big_endian)
> +			*is_big_endian =3D thread__e_is_big_endian(thread);

[Severity: Medium]
Since e_machine acts as an initialization guard here in
thread__e_machine_endian(), could a concurrent reader observe
e_machine !=3D EM_NONE but still read an uninitialized value for
e_is_big_endian?

Because this lockless check lacks an acquire barrier like
smp_load_acquire(), it might be possible to read stale data if the CPU
or compiler reorders the initialization stores.

>  		return e_machine;
>  	}
> =20
[ ... ]
> @@ -515,16 +534,27 @@ uint16_t thread__e_machine(struct thread *thread, s=
truct machine *machine, uint3
[ ... ]
>  out:
>  	if (e_machine !=3D EM_NONE) {
> -		thread__set_e_machine(thread, e_machine);
>  		thread__set_e_flags(thread, local_e_flags);
> +		thread__set_e_is_big_endian(thread, args.is_big_endian);
> +		thread__set_e_machine(thread, e_machine);

[Severity: Medium]
Could we be missing a release barrier here to ensure e_is_big_endian is
visible before e_machine is marked as initialized?

If the compiler or CPU reorders these stores, the read side of
thread__e_machine_endian() might see e_machine !=3D EM_NONE before the
e_is_big_endian update is fully published to memory.

> +		if (is_big_endian)
> +			*is_big_endian =3D args.is_big_endian;
>  	} else {
>  		e_machine =3D EM_HOST;
>  		local_e_flags =3D EF_HOST;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D3
