Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8E1A3172
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297632; cv=none; b=e1eqehNcoYs+hvOH9MU/n4EXRd8c+MAN7fiawKjjZOdQOQl5FNiYT/g6N1QepnIaAe8BAI25+8R/ki4/2gdVcB5x+zC02qicMB3kiDytRyni6OdmdfMzG4EdnKz4WNpoSJ0ZX2YQCPs/fEX387AoyAiWpzMktXEQQbVu7aVm4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297632; c=relaxed/simple;
	bh=QncDqN1HioHEf/Q7/2KJ0EHVQHeYAmiHgqrCL8ABX+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mh7Tmxn9DD32QK8rZiQdM3L9vtXnjYXFYKb+mc29G6J9gAWUkPBcnEjEYEUjm53SEKCTsJXTmR/UMd1bKDWZtjQEaplG/dhgdOSGg2deQnGHh6apSuyzqXJK2fLFYdfnUOfRhP8jf9nNbm88vBxAd52H9CfhFvS2OJzJ26coqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk63J7EK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk63J7EK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6C01F00893;
	Mon,  1 Jun 2026 07:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780297630;
	bh=g8mlIXGPARhntAg7ReTYjHvavPSFadN9A9iCbEJVPj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uk63J7EK6slwnplGUJsZlxl9dzP0LAlyN4KEsJA7ygfwpPog6TlUCdeX10GuZXPbw
	 ZZ2djZGATAA89be3n6v7Rm4DCyea0F0XdDxv28SXTjGKrPLMGNY1ngKtAtF9GvgIyQ
	 cbrDItw2aEMCQYBTwg1O1tOTBcjCjBBzdEmUaaW1X3BEYEi9LTGkVSGshQ5Bbj/X+v
	 OFhotYUICMU/U51QBH3dXU175neYFymN0a1nMajDZ+fFARmXVdEWT6Hmu+VNKjkFIg
	 +fylqehMqYGCeEqhtw4ipi/BwoCktZtaMt4xWKdKwMwCfCm9TWsbVpvKnGtjtN7WiJ
	 eYyzygOApTLFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/18] perf env, dso, thread: Add _endian variants
 for e_machine helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601065407.1597927-4-irogers@google.com>
References: <20260601065407.1597927-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:07:09 +0000
Message-Id: <20260601070710.3C6C01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect host endianness fallback in `thread__e_machine_endian` f=
or NULL thread queries.
- [High] Data race and TOCTOU vulnerability due to concurrent reads and loc=
kless updates of thread architecture properties.
--

commit eb24af8119780afad944b6a5f56753d733d7d010
Author: Ian Rogers <irogers@google.com>

perf env, dso, thread: Add _endian variants for e_machine helpers

This commit adds _endian variants for ELF architecture helpers to support
bi-endianness and cross-architecture analysis. It introduces=20
perf_arch_is_big_endian() and updates the dso and thread structures to
query and cache the absolute endianness.

> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
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
>  	uint32_t local_e_flags =3D 0;
> -	struct thread__e_machine_callback_args args =3D {
> -		.machine =3D machine,
> -		.e_flags =3D 0,
> -		.e_machine =3D EM_NONE,
> -	};
> +	struct thread__e_machine_callback_args args;
> +
> +	if (!thread) {
> +		if (is_big_endian)
> +			*is_big_endian =3D perf_arch_is_big_endian(NULL);

[Severity: High]
Does this fallback path incorrectly use the host endianness instead of the
target architecture? By passing NULL to perf_arch_is_big_endian(), it looks
like this resolves to the host's __BYTE_ORDER__ even when performing offline
cross-architecture analysis.

Should this dynamically resolve the endianness from the machine environment,
similar to how it is handled in dso__e_machine_endian() by passing the
architecture from machine->env?

> +		return perf_env__e_machine(machine ? machine->env : NULL, e_flags);
> +	}
> +
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
>  		return e_machine;
>  	}
[ ... ]
>  out:
>  	if (e_machine !=3D EM_NONE) {
>  		thread__set_e_machine(thread, e_machine);
>  		thread__set_e_flags(thread, local_e_flags);
> +		thread__set_e_is_big_endian(thread, args.is_big_endian);

[Severity: High]
Is there a potential data race here when initializing the thread architectu=
re
properties?

Since struct thread objects can be accessed concurrently, a second thread
could observe e_machine !=3D EM_NONE in the fast-path above immediately aft=
er
thread__set_e_machine() is called, but before thread__set_e_flags() or
thread__set_e_is_big_endian() complete.

Could this cause the second thread to read uninitialized or stale metadata?
Would it be safer to update the payload properties before setting the
e_machine indicator, possibly with memory barriers?

> +		if (is_big_endian)
> +			*is_big_endian =3D args.is_big_endian;
>  	} else {
>  		e_machine =3D EM_HOST;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601065407.1597=
927-1-irogers@google.com?part=3D3
