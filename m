Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942211;
	b=RoE/Eos7hX9izmAoDFiaTVyI3PUO2RIzJCIdB4/zkSV8na7H2F5aDERT1eb8ZKro+2G4
	 WP7lZIefjqCCwDZ7FvccNESa0UC0JiW/ES8PeRdoVh7I3PmvTMXWFlm7dpdlae8iQvogh
	 h11ljFMMBLJ2UQJLTbTpr5byOfi/k5zVfFt0HdWNgkRjMXGO3nn2SmIaSceK2mDOOjEVD
	 R5CN82X1bKch/uINHFz5spIZ4D0VE8mWB3ox27IKhuRcA2NqyJAg/JbVbSqD8eYBR/MWE
	 8qg58MRLqL/i5vyacnFII9i70ASCl4dW+1NK0FukymUd2gaEPELehIlSNGty2a6Gqfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942211;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rqcZ3uyslLjnW8K5ClRQcpuRQPyShvGJoToTQf6w73c=;
	b=DYJTftMEJwdtUkw++uGq4zIVo2Z1t6clV+ZLsaMGVUppSwEDROHi9mQzVUBEq4IUpCeG
	 rdbPx7Tg/TCVTdCLiTMk8oV5YNiynZ6NfazsiO56Zw7b4AK72r8U5hJuoXcihGG3YVZJd
	 mS9SRMo5keWQNfdRyv5XGQEuDUlJkyuxv1TX5FTpdbXHVCln9kXHEZelZitdjuWskUtvW
	 ozmCp61IjIpC05qsZfcgprCe4384Z6Mgakwzb4JorMEmglGQFhCOxnZRuxoVeNax9dAMq
	 5Nj2c8kFaO1cTCUgkvJxVS7o7GGQFqPb9LFouCfWwaij9cabzcvYnuJ0LGIQtWJA1dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZaBbQON;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231F606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZaBbQON
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B081F000C5;
	Tue, 17 Nov 2026 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942210;
	bh=rqcZ3uyslLjnW8K5ClRQcpuRQPyShvGJoToTQf6w73c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZaBbQONyop8dFhcgzIxZRWV9Ef+aGyPN9v1zMjy81LLk6ZwSZwMbZf/LGjz/VlkR
	 Iuhy9xCu0c/7kW6BXGZ616IBOpaZHakJK/cHsaVTFDnVfmfm4Vchwm1ogybGxSJ8Ae
	 Xi9cS0+12APgGuQm0Yh9Lfp6QPh152JUYBZ6q7p8yLDZs3n6DWgOWF1ZJ4UqC/7P1D
	 w6ecNY2IERM9RCapIwXTciAef9m4C1cmilLrqhFVCP5zhHIzQuTTNMTMESiNtqbT6m
	 hmsyMAg2hN8Hp4BSTDSciD51uRb6gXAP9TSC5WgnZ1s2zoXjFffoeK0afrGKNVU/vx
	 Ryhxr0pCPppBA==
Message-ID: <sashiko-outbox-219430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] perf symbol: Optimize symbol sorting with
 natural-run merge sort and binary insertion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-7-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:03:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ELF .symtab and .dynsym sections are typically already mostly ordered by
> address in ascending runs, and dynamic symbol resolution
> (dso__insert_symbol()) frequently inserts one or a few symbols into an
> already-sorted DSO symbol table. Invoking full-array qsort() on every
> sort after incremental insertions or across pre-ordered ELF runs spends
> avoidable CPU time in symbol comparisons.
>=20
> Speed up symbol array sorting and out-of-order symbol insertions:
>=20
> - Track the sorted prefix length (@sorted_cnt) in struct symbols and
>   replace full-array qsort() with a natural-run merge sort
>   (symbols__sort_range_with_tmp()) and galloping binary-search merge
>   (symbols__merge_runs()), plus an O(N) in-place binary insertion fast
>   path when <=3D 8 symbols are appended.
> - Insert directly into sorted position in dso__insert_symbol() when
>   symbols->sorted is true so dynamic single-symbol insertions maintain
>   the sorted invariant without triggering full re-sorts.
>=20
> Using 'perf bench internals symbols':
>=20
>   Before:
>     Average DSO load + sort: 6.242 msec (+- 0.057 msec)
>     Average bulk insert + lookup: 1404.150 usec (+- 18.752 usec)
>     Average append + lookup: 40429.750 usec (+- 507.578 usec)
>   After (-7.0% load, -13.9% bulk, -99.6% append):
>     Average DSO load + sort: 5.808 msec (+- 0.047 msec)
>     Average bulk insert + lookup: 1209.250 usec (+- 18.446 usec)
>     Average append + lookup: 152.900 usec (+- 0.736 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D6

