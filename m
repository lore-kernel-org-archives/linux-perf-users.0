Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120953;
	b=4Hs1bCfOwD4QZbMF1K7DdNEDF3HEzF5LbnvqV560ygWnPcVizQywYJ+QJhMnn3UNPnPB
	 QABM3X/xX0Q5bCoddqktF+UPL+g0rP3b18Zf1YQlTI99YvZObOS8J1DfdCoSinyTywkM3
	 BoF9oa98SNtVCJ9O4hOMRxXEFtB3QpNqc2/uXXoEPslp6EsP+OvmrDyNNTB2ohLnwXvda
	 8i7h1AHp5Bwe+T79RVnOIEREwqFCcxe7v1XN0MrPKdZ5aW5TlFR+alc6uXg7NrcdxGiA2
	 gkuPoHLEnflAMkwyv5ywajTH3WxHj/cWcdNbHVHXMFw+b2Ci7tzic3/kzixossHowhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M/QooLPOEyhQiNvmkAM0y/56aS5sgVVBAeinp4tis1E=;
	b=AsxC6FuYGpbqwgcWGHIVSppYUoK+i9GFF+B3ap0ADgAoWrjOuqPxgky+V0qfAav+dF7x
	 lpcy6lUftJRjPW2PyAgeKpRS4GQ7t7gY5OuIrmsJlIPyED0p9VONSRsGq2qhXU6cRoo11
	 qDpszTJJwPtZsJTiUB1gZ9RSH9COzde+7TjDaBsOq0tGLBnsUNh/AiShohLbUSXESP6ML
	 D5fUrsCaKDLpX1m3qBA7X/D26PxjFZCWWRcpzY+2RKFyccrAV2xp7EbOKaowM1iItB/ZE
	 qKotWJ5J3FhRYz8dUfO8RX1bkEEYJ8GXu/+wgAiYg1ETTp3JcpXnIV4vtJ0IVlKobmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRqZkD2S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F7606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRqZkD2S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405101F031E2;
	Tue, 27 Oct 2026 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793120952;
	bh=M/QooLPOEyhQiNvmkAM0y/56aS5sgVVBAeinp4tis1E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GRqZkD2Sg7QgORsBhrC52GDgMN85bmgEQOchD+7g038RXbyoCwcqvVh3yCg+fxfyp
	 oqdPfY1w1MG0aLyyRGJGoOVbt6PxgEKPTlVaehKnD/kgcTxD6ScTIAtk/SSOiPCzf6
	 xMf/o9qhZLUGeFN39YUlFLslADpBzN0evQVfVrIPBW34PH/rDhca5/LvBqeeEDbbGr
	 N5AsV2Nk5YF9W+1UWSRyyhgDSjCPhyi6bCr+z073fIGEfnpImlVRpDpFqIZ82pntJ8
	 WX3uLwRYw0e/qRaW65LIOa1w5ZwYgAc1wiZhHxkrjeVaBj/A8ZkLuU13yQFkpdGEqa
	 Ft+nBK1UEO54A==
Message-ID: <sashiko-outbox-186972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/4] perf off-cpu: Use the CPU map index for the
 bpf-output file descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261027170415.2815859-1-irogers@google.com>
References: <20261027170415.2815859-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:09:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When populating the offcpu_output BPF perf event array, the file
> descriptor of the bpf-output event was looked up using the CPU number
> rather than the index within the evsel's CPU map. These differ when
> CPUs are offline or a subset of CPUs is used, leading to the wrong, or
> an out-of-bounds, file descriptor being used. Index the file
> descriptor array using the CPU map index.
>=20
> Fixes: 282c195906c7 ("perf record --off-cpu: Preparation of off-cpu BPF p=
rogram")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027170415.2815=
859-1-irogers@google.com?part=3D1

