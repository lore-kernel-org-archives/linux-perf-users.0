Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778715;
	b=OcrdYYcLD4RWQZNMCBzOFO23D+BUyxUadCQAMdlImXjzb9tprPtsDzjhBldNpu2VudZO
	 4tbiZsrnR9PpI77AB4oNnQ9+vmk1omcZWA+WomxVbvBN37be1CLGKbJJsdjtLXbaJGMHZ
	 3nqcoAi2LtdZxX7dJ2Kh7DVs4E+mx9kIp5ADm6RqNVarrBu4y8NL3RRHl5UFjSeonsCr/
	 gCBgokLUhFDrzrVIFYub0lx4r6cnbCdH2eG6UokBAH5rjKWsF2/AWa7N8jc/dDeinx4mw
	 lQGh2BVTZzrhLzx1a/lYsAYZ7BIMUdMG1tQKIiUR/tVpsZwQ8GmAn/hj9SX0Iq1f1dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778715;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J1NaGaLBjREd4e4MywfxliFMOCk7MAKk6WXYSuHZQaQ=;
	b=1n2cfvfeXIWX/EewQHmy6k0fJo/sBQDcvqBjR/KCCPtLo5IgqL9ii0qCs9A/IMN4+Wcf
	 ZxJN/YJve/BpZw3r4C5/QgUpuTxBSkCyURFaVrwYf85VS3o7FQjQHfnw4beuLUJhVZHPV
	 uxqMvLGXnaOuvR0wuySvxzlk/wh0KxAOEGfxmXKhd2FmqiJa9NyjnpN4/GVofGDkJNESA
	 XSrgm6m/dwXZyCf+WqD8E6WKkI9l5ReAcJiR2jpyCG1AeFVXkPPPpiVhC2Xgo+LkwNgiZ
	 k3nsLMiHxTDuCIsShUXfP5mLnrLzk0llsBtpVgtHRW8jwrZ1KfLfLgH7icvj8RgtVLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qmnk9YRy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FC606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qmnk9YRy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0351F000C1;
	Wed,  4 Nov 2026 07:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778714;
	bh=J1NaGaLBjREd4e4MywfxliFMOCk7MAKk6WXYSuHZQaQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Qmnk9YRyhnDxLIDlHNgFv2lNvbjik5epggsu68aZ0xhJzqtw7rf0Uxnj+ZVhf98BK
	 ikJBFiWeu5AXjjxVmQGYBLpxZRVgSI0B5Qcnu8kIUPAEJ/pFAmodkn0I5rPrHIMRbD
	 THguRQMtlsmz1r0F13KKuwaC8lSFo04A0S9+ijzSFf1bSMR6pJIt3JQdhdwAixJ0jn
	 uYdwfwvKbsIuXWYpu0VSq6E6b3pbe52gqNtCUMr/aK6guNUyW7KDIgr5W0XpHDjyWX
	 EMeRF5yVAODEdFZJl147tZqvmeSoiPY2NGQxDWhuW11vRI81rg8UnooMk+OrE0RKRb
	 +TTGbRE6+tfBQ==
Message-ID: <sashiko-outbox-196835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 40/41] perf docs: Add perf-sysinfo man page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-41-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-41-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 07:51:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Document the 'perf sysinfo' subcommand and its options in
> Documentation/perf-sysinfo.txt and link it from Documentation/perf.txt.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D40

