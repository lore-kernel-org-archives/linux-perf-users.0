Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968621;
	b=Ig8HisM5LqCXLCcL26jKVau6aHioKuFiQ6BPNfz09L8/R82fnD88fTnTnD+EGTZwqeTK
	 wMCo54w7eCZYys9Apl6t/IAulmbT06x7ERuiWivUdkwRaij4tj1Ly8ODMYt+Yevmj24gA
	 07YdV3PWLmBjg6u7IPxhWtpvzG8SzXM1b4NgltWBmBBm0rV2AJSqnYg5IAdtoz0B1WDkR
	 F4hqnxx4MZjcT55Q1eVI0oG+1nnvLZ08nS9VCHEJYaNnA94Ko/nU6Zwli/0T12M0euCdm
	 qk0vEHFyzPMNBPwpJFlTnA+kABEnfFP5pvG4OiejxMczvkHHGRUwkyaTV+QveucyB7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968621;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LZLB9iLqkiJ2r7/f//C802HmN7prGXhrrL3HR6BoANg=;
	b=S6JdkCJ9Sm6V9LzXQ0WcT1Tr7P5ppfsiuS89W+HFXsxF8zcY9iISzONgWy9HzpSb+Sn1
	 Q/U1GNc1OtCu2qnesey7urLqcJPahVMIG3CKaIKM+e5MvXb1YOc2hdFD3joAZ5SUTGe8s
	 SdAdxctEZTo6GjPBpM+VMUlljFaVHsRF2DEsoSWC2wW2Sf4+VJUu3opsbRbmeIiO1brxR
	 LaBelJ/zwHGpKkIChT+LY3ZIMaVzwxjRohuZWDGsIG7Q9F3r/Xi/JkabN23bXclrmRIQw
	 7ikU2gNjXvKaQDalEFuaQp7G/NrN6KEdCwv+iHakDUJv99pG3bWJ/8jedSZH4Zphgcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZulK8US+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB30606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZulK8US+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF561F01825;
	Sun, 25 Oct 2026 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968620;
	bh=LZLB9iLqkiJ2r7/f//C802HmN7prGXhrrL3HR6BoANg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZulK8US+wbxRRbq8cArY1Qg8KdEID6/TtZv4dnIunzd8WHQS6bcGH2taymPsfG7DO
	 km9s19k+r38lXNH4Zqps6rfC3qhWvmt5uG82xZp7RkxXnTgQWFZzPYoUNqbEZqxfI5
	 YPFynXifUcs5pFm5C9+fbMo0ZS4dQEC/UtqbW1Il5w80aQua2RtbbI8E/Yvqgn3RTN
	 2wgMhDXMWQrrxYYsYFqG1UWUbDNTqPrRduTrJSHdCDCL7yrt3fV4B9TrJUpqUEhl9y
	 tCCVlv1QcTbtUrlty907Bk5/2VYJ4f8nCYibPbuHemwAHFyNcJMZNyQO0Hb9+2ysQY
	 ASHtj1XSbS1Aw==
Message-ID: <sashiko-outbox-184507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/7] perf session: Check lbr_stack for NULL in
 callchain__lbr_callstack_printf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025220349.1244499-7-irogers@google.com>
References: <20261025220349.1244499-1-irogers@google.com>
 <20261025220349.1244499-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:50:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> callchain__lbr_callstack_printf() can be called on an evsel with branch
> callstack enabled even if a particular sample has no branch_stack payload
> (sample->branch_stack =3D=3D NULL). Check that lbr_stack is non-NULL befo=
re
> dereferencing lbr_stack->nr.
>=20
> Fixes: febea9ec382f ("perf inject/aslr: Add ASLR tool infrastructure and =
MMAP tracking")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025220349.1244=
499-1-irogers@google.com?part=3D7

