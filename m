Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754851;
	b=kpYrkDchNbGICt3h2pDy005gFlHxne9DTZHBrb2J6RTLvsPOxjF9+Jn/7xqgv8SyQDfU
	 y4J14t+neEkTXHst4NlB7ZQUEyvMdR72dfdRsq4Pk29URiaSYTpFwmPoMV85CYhw+0Aka
	 W3zM7hop1eafXbJk6JEXi4skwp44Oo0U3ALgCm5HpwbJiRvz1Si7T2SL0pfSTEiNilI1J
	 EtFFP8nb0WmEOmRtK24vSFRHwQms25j9U5NpI4hp9V4MqmOUfpvFhpexrEcabP/+nVgZQ
	 fyxK/9kCrtWyn6GhMIbV9wOKLWPiHtG8i9DQ4T8NvbOaJOLofFaN4L0V6MxPzg+TF6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gq2ICEUTTW1z/0JhdsIhyIiWx+kHp3gH/uk24Mw0dGg=;
	b=HEt3/Yw9/8LjIILjUXg5UYB81p1XT+sxgc8ZKGTAIgCk/MTGwYUG5aWi1a3SAshy2RG5
	 SaRUKZKcc4ofYZ7HooIfonhQpBbxl8TcYZ3Mh/119IlACpRZpDwXdZXKuIJ1+knpntnQA
	 7dm03TOTWcGE2TuWD3Wd2MCe/oXuSUmOOUosAoPJgRxlSKpqy445Fkra9sEz01vPi23wB
	 ysccKofJ6/2dP/hR7XYJWmMlj1jQ1KVhMt4Sj4Lz9CLNlr/xGIW6IQxVRGuSpYG3KDAEj
	 UidZr5sc9uykZ5hK4WvBQW4OEP2K1AVqjlAnz0BA3+f5Inz7Ss0igDeHEwytPZIBWZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bex8TKxj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6D606A339
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bex8TKxj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDEC1F00A15;
	Wed,  4 Nov 2026 01:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754850;
	bh=gq2ICEUTTW1z/0JhdsIhyIiWx+kHp3gH/uk24Mw0dGg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bex8TKxjpM6FlbmlSeUcWfqCMM1EfiC40M3w7o4lYlasqgaexga1Ky22kCyBjWZQq
	 5vzuDqtlR2FMD6NhCOVlXDcUYjoVstFU8tCOi+It78e1WhUBbpwxLU+b89mLSUyPfR
	 b4NBb7IVQe48cJb8v1BWbGRUdPvfhf1nCGEptk9YYtAok590I39d2L/ZlhfAipsFSV
	 GwHmkoNyDUdf+m8brvG6vHbHRXclQJUN4vZggDK51I7xfQI8U6OThWwsWVnLtKlOBe
	 APEAFqny841GKo0Ia3Cfb1qWGFvVULJ7ldPDTOqbfjv3vSWZRn7rIwGK6V8CQDPS4M
	 LuwpxqaErTpQw==
Message-ID: <sashiko-outbox-196349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/41] perf pmu-events: Pass e_machine to
 find_core_*_table()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-9-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:14:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> find_core_events_table() and find_core_metrics_table() found tables by
> an architecture name, such as from perf_env__arch(), that has to match
> the pmu-events architecture directory name, for example "riscv" rather
> than the "riscv64" from uname.
>=20
> Instead find tables by the ELF machine of the CPUID's architecture,
> using the e_machine recorded in struct pmu_events_map. The test and
> common tables are found with EM_NONE.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D8

