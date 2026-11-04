Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819070;
	b=FRwkeq1RqlUCFI1UTIsn58T1BtJtfrYyHqlEPImM3qk1D+IgU0G8Zr2SIliuXSMJgy2K
	 WOShzlKelh+/VtTLYpn8P/BvnM9RDqv442B+rCIDv8lJqSDSJetnhjlyoWIEk98j+oZTS
	 OafiRp70QU/sDjB4n/ICJhC2TcFsD4QJwUKnzBF9KUk1YefIP3Q6lykEp1Pf/ihAsywT2
	 JlFFi0fx5/qJf/PqmCnk57tkeQWQFxCPaK94Y6iaVojqNDkSLNsL4Ei5kz2tN9v6Qha3G
	 Y41JhvlFHC5XASJhEIK/nxfvxej8eJqJz3TMQx4cpeCp2Jemxi2zgn75WCtgH+NmYQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gCS1UeIgJT0G4r8rYhFw19G7q1cr2OLBaJ4+gcQi3YE=;
	b=MStPyyO4mZqwsE2NcJDZupxDAUhbw8Y2Xp27eNi2Jw5o3Yz8zVzlaYXFFjYQQI1AfQ9C
	 X0OSfG8jwNbCj4LbnmQR0hD7nA0Gk8/6r0vBO3r4nvkpdV7tOTXoT4CKNn88RDjALx2yr
	 CuPZt2WgOqt80i2IA4Eo9d7IBm0fElWkmpDiLlp7eiJ/jPj8MbtoKBc7qUnmhoI3/rLnA
	 3shE7y3p/ZYQZvv7xU4PNtvzv58ygb3kuu/sKZ4dNtIiFxUwOAiD9gX4ytpDd68+nsxSi
	 n3xeV5iymjpLA1cK3hooKDAnL1SPmcRQjNKxrJU+yn5GwiU2MHUH3zkKlcRjrOIPCxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLQf6oaZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0833606D82B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLQf6oaZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2691F00A02;
	Wed,  4 Nov 2026 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819069;
	bh=gCS1UeIgJT0G4r8rYhFw19G7q1cr2OLBaJ4+gcQi3YE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hLQf6oaZG1oSA/eMOxnWE6Axskea7tigbtajdrJN0dqwfiFNXTDWMoBbT4rwoxzNV
	 2kG5N0L7vLLs0zd0V8wUaRojbpIP53JQ+ZuI2blo62C39RsBM++3xsE+olEzLulmPS
	 T+4QtTdQG1pRew04/8PhWgDjkzJA3JGO9SuV+GWWB0N+TLdek7BuLBgar/I1wZDDog
	 On778ODUnsd01bf4/ExLQOOXJZ3i30kznZKT2Sz5oF4zA8SKt0WOe6DxxZUiKrs6Q1
	 XOEsdC7VBX8HrzwYHgV8VrBXeCTBlJJCp01Qb23B1UK4rqoPaTVFyfsburbppefkvv
	 zujUaEJMk0ifA==
Message-ID: <sashiko-outbox-197912@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/13] alpha/perf: optionally randomize the ProfileMe
 sampling interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-8-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-8-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:04:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] alpha/perf: negative period_left in alpha_perf_event_set_period(=
) jitter
--

commit 9ea17dccaea7d498bc01f69fffc0c162389f6e92
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: optionally randomize the ProfileMe sampling interval

This commit adds a randomize config bit for raw ProfileMe perf events on
Alpha that varies each sampling interval by up to 1/16 of the period in
either direction using a per-CPU prandom state.

> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index f6546d6481333..b33677cc23caa 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c

[ ... ]

> @@ -389,6 +399,22 @@ static int alpha_perf_event_set_period(struct perf_e=
vent *event,
>  		ret =3D 1;
>  	}
> =20
> +	/*
> +	 * Vary each new interval by up to 1/16 of the period either way, so
> +	 * the samples cannot phase-lock with a loop whose length divides the
> +	 * period. The count stays exact because prev_count records the value
> +	 * written.
> +	 */
> +	if (ret && (hwc->flags & ALPHA_PERF_FLAG_RANDOMIZE) && period >=3D 8) {
> +		long jitter =3D period / 8;
> +		u32 r =3D prandom_u32_state(this_cpu_ptr(&alpha_perf_rnd));
> +		long offset =3D mul_u64_u32_shr(jitter, r, 32) - jitter / 2;
> +
> +		if (check_add_overflow(left, offset, &left))
> +			left =3D LONG_MAX;
> +		local64_set(&hwc->period_left, left);
> +	}

[Severity: Medium]
Can a negative offset here drive left and hwc->period_left to zero or a
negative value?

In alpha_perf_event_set_period(), when left enters in the range
[-period + 1, -period + (period / 8) / 2], the first check (left <=3D -peri=
od)
is false and the second check (left <=3D 0) adds period to left, leaving le=
ft
in [1, (period / 8) / 2] with ret =3D 1:

arch/alpha/kernel/perf_event.c:alpha_perf_event_set_period() {
	if (unlikely(left <=3D -period)) {
		left =3D period;
		local64_set(&hwc->period_left, left);
		hwc->last_period =3D period;
		ret =3D 1;
	}

	if (unlikely(left <=3D 0)) {
		left +=3D period;
		local64_set(&hwc->period_left, left);
		hwc->last_period =3D period;
		ret =3D 1;
	}
	...
	if (unlikely(left < alpha_pmu->pmc_left[idx]))
		left =3D alpha_pmu->pmc_left[idx];
}

Since offset can be as negative as -(jitter / 2), adding offset to left can
produce left <=3D 0, which is then stored into hwc->period_left.

The subsequent hardware minimum check only clamps the local variable left to
alpha_pmu->pmc_left[idx] (16) before programming the counter, leaving
hwc->period_left <=3D 0. If the event is later stopped and reloaded before =
the
next overflow (for example on a scheduler tick or context switch via
alpha_pmu_stop() and alpha_pmu_start()), alpha_perf_event_set_period() will
see left <=3D 0 and add another full period without emitting a sample, or t=
he
next overflow will subtract delta from an already non-positive
hwc->period_left.

Should left (and hwc->period_left) be clamped so that the jittered interval
remains positive?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D8
