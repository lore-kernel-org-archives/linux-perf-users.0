Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777567;
	b=iv1IfujW+Gw/f+aK0+2p9Q/NRzChWTY9SMtgUZSJaQbi590jg26oBpoJIgyw+LV5Ihuh
	 oZzGjsIpV7foMw5k+bMAm38fmnOD1qV0UZk9bNspIqDmqq4pJvrad/Uot6VYFau7JGmRr
	 euTApu5OqYPQTzpkd/inIiMa9BzXEUJuMgIEjlMOUX+zyo9ZDl4M5K0ofMg4hx9AHcLK4
	 pfAEgaFNVjnDwPtiEzIJFq7HJ9Eb/xWxP67L7BBdXmjR7djKpiGaG1YW+DPVS8EeO6Mdn
	 o/ZdilzaAh3q6RUFVcwobByOn41ak4tUR0SHrc9TknOruwKI94k9WFpaUKr2FwdMIOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777567;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1ycD0BV4gVs7u8bqtOM4Z/HOT0u/KQ4oXXM9rPsMJaM=;
	b=m0dCm8pFglzMV0JFK1N/pWJIadUkDlMFVIXrvdDT/3DQM12C8xxD5I05U2g2LkbMyFdP
	 N89PClxmHs/a4XiL63HnfoJ2izAlYt9cusrv6nClmEsNTDSh70oaOUQjaDBqa9kJgKV9n
	 mFy5dRejFb+/CL+RhDl3et8PGGgD7TiFxSsWidikLZK5M9XHKcVHaWt97ulLX/uK990WX
	 Wrbxe/bpssHZSs5H0jMon0EjvFL2eRlmmOJai9FfyOGmdGYkKd3j5/wmgQ51Oaddqi5Ye
	 5tDANPZ8hUxIJfQhfbfiz2cTwULHWqfpCgu23Q7BHfa8zEk7ifEFs7MfymTHo7BMkZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqESkm2P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE4606A329
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqESkm2P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F771F00919;
	Wed,  4 Nov 2026 07:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793777566;
	bh=1ycD0BV4gVs7u8bqtOM4Z/HOT0u/KQ4oXXM9rPsMJaM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DqESkm2PgxhVDbLXS1psVA/sGjMq5KjxcwE2X9KkGEzc+MFqhfvE5S1n8RaEg0hgw
	 jQ8i9kuDqZXa9GR6u6xPE7BXi25irwqIx4NHPbFHIl++4axeShFdpVgJahhYpg/TvE
	 27/WEh7hql0f08ZH7LpJ0i/EEYX9DWNYAvrUpir9uC+Cmz1DSxHFmdtrhxgbBmsbWU
	 Aj7sfs59XdPkRD2ghNHrQD/OyI80PDvTJ59ZuE2KpKeUHgpfKYboWJ4HXnqlxCf9/A
	 ApakxrojETjcQVeiuKGbq+dDPHUXDc2sPCbb82S57Qq7nFeQTvgUbCdGGsNKKQ+Qqu
	 7QFHIm1XS2P0w==
Message-ID: <sashiko-outbox-196800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 38/41] perf pmu: Probe branch instruction skid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-39-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-39-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:32:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend perf_pmu__probe() with run_skid_branch_loop() and
> probe_pmu_skid() to empirically measure branch instruction skid across
> supported precise_ip levels (0..3) on core PMUs.
>=20
> For each supported precise_ip level, open a branch sampling event on the
> current thread, execute a NOP-runway loop ending in a backward
> conditional branch on x86_64, arm64, and riscv, and compute the minimum,
> maximum, average, and exact-IP (zero-skid) sample counts from the
> recorded ring buffer samples.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D38

