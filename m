Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750026;
	b=HzBGV+SljxISJYSpIm7c3WzTz2Hs2ABXDDVO7H/N/8GTWp+NYr1JPnYaguBHpH0zq/2s
	 cWWlsXlNWjH6mX+WUIXhcw6Uy3TEK67NoiZQ9OwE5ck4XAviYI0i4ZranISJYqnfDqZCq
	 nWJ8UfZy2LOwS9XBrZ8rL7LdiadxxEmC9u6VkxZpZAWesn/0GRNeKRxelyoIRDcZdovOZ
	 RiUcdIjuRWjDObo1IuY5VV+ioYTe5KvV7eMua0+fClk0r37H0T/K0wzLrgUE8AxCylEi1
	 goUKBd8OQvWGY5E0icCZ1n8Ns4+pRQWMnuz7cA6U2NlN63HLfAvj1RFNOC5FanzX51w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750026;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vHhMl2J6DAPwMwyKkJVTS7RkudGR5EmledEdLMqudks=;
	b=mh2tyYc4rh31kX4B/ewDy/roUc9/p087GaloClxsxrqqB0C/PdPRXtr7CNmTxiwh3GhY
	 bYpPcsngpMpM9zwOScai0TMAmpDwRySoQvW1BWyIy1a1Jd2+X9S78YovTAAr07FA3FJcw
	 PR5ZumpDPjgIJKtBbkAyE+0n84h0NzzqQAp5W/8rf3PyzY7dkg507gvJeQ3ZML2odpe+y
	 vPsfjcHCi2U6m2t94mrstC2UxgoHSI48n+AC1RX0j8OBAt88rwtbtCo+ZjLVXeIfPDqD6
	 AO3KWJOkJwocL+qJitxAEvHve43E4nyHvYJR86h8rqUdmrQ064wOx6OUjsd3S3f/7HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzk1M7JE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A7606A32C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzk1M7JE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C8C1F000C1;
	Tue,  3 Nov 2026 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750025;
	bh=vHhMl2J6DAPwMwyKkJVTS7RkudGR5EmledEdLMqudks=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dzk1M7JE5knYstki90S9I16Pja6Vsfw7rcpVxh6BsKpVpeltXriyrFzPymYI7vjst
	 gvgmnd4BvB9u9f5HAyRph+0oKgfksku/kV2T4jIUswmX4Zzg8D+1X5XAr42W16jSKG
	 osJoaeIZIYgBdkLWIcryVkMxe2CCh+x8Uizxs3pVgKEkya0a1OOJCO1qBRPD+oXvEs
	 6eqyISqWqPeOlDOoVpDZWqlhfVBstA/A58XLcMjTTMnP0HXsL08WN8n7IMSJxxiO3R
	 rkEefN3lFmAlZ3EWggAOWt8yxKn4LmD5b76jPkV6V/D0IrNRgnna+xU0DbDSMhjaZT
	 tzFrLw9C5+xFA==
Message-ID: <sashiko-outbox-196249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/41] perf env: Make lazy perf_env initialization
 thread-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-2-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:53:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Guard lazy initialization of kernel_is_64_bit, nr_cpus_avail, e_machine,
> cpuid, nr_pmu_mappings, pmu_mappings, and numa_map in struct perf_env
> with env->lock, and use DO_ONCE() to initialize the cached host utsname
> structure. This prevents data races when multiple threads concurrently
> query a shared struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D1

