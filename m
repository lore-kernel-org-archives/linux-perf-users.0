Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793506099;
	b=g21Vz79TXnPSfjR3hPA36WaTG37/R7toNkdHPhUnGN6RxNCD/YwlSxj5V/G4XmEVbBIc
	 EJoihyC+SeIrmCpqkitqft+o8D2FGPrNouj5k5Zcp9IN3RSQRjp//o2GZi7ZC8cP1RE/Q
	 yOpiQKwVfMVXNz5MAkOU4iwiQj2RHLXHuQSGzNabU3Pa38341Ve8nApGUZOQN72dZZr2G
	 yUclgCIM1U6qf9r0jjAwOmuDj83r7Zkv3Mlvta3TCaK1/+QD8nFyHHLwycoElNKvIby60
	 RsWI5I4lNpcokYtPZuxNL6KcHaGdzrMqcRNhn3MuqVQAbr1NQmD4BGy2Oi8g3P+B6jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793506099;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a9ZOCIatw/pQjomCG+CDg+50Ms15aRF7lS8WJOd5hhw=;
	b=IcT5vNp/Nd0f3v/wNGLpvxPBHnf1l1ojaLUePLHPLHoOnO7oBh+rgXr5IOYgkvXtobSR
	 +IYWnQxcQFnGi31GDarRkdHE85jEs8xYdNNkUkhMmCpOQF4G9ZGWLPgmg7mHpT76ijukw
	 pI37+2Eky/k80kX0qqG2wjEED2sKPBTNYUCpYwMaO+kQg4H4X+2P+ppl3wDwiu5VrUdu0
	 kq5Sm/ZKZAbLyStwDCc7xX0jvGr5XaotrnM84yT8moRrdWZZ/lfMxgFP6fVsC3gFVFFYd
	 vCgkdH9nGn+I5Hlx1TPMzhGb1yy7axxm/UUxCeKwbb+Le0W3sz2YDdsxMb0QO+Guv5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIfcsVyv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43F606A324
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIfcsVyv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BB41F000C1;
	Sun,  1 Nov 2026 04:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793506098;
	bh=a9ZOCIatw/pQjomCG+CDg+50Ms15aRF7lS8WJOd5hhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIfcsVyvYSxzzmDj8fjNpjeYrWU4T77/Ysg4UqtBgkP80hCNtUXW0fCsuPQTmHZII
	 m5QcFLsgBlgt6FHzARhUoEzyUR117LEbJpX9SZed7Og1sjBClIPCIkLT6+08mRIkRW
	 a+zi4iGne5ZZZtiX9Ukk0chT95omNeKAzzJSuLda1euUqwZ4BTz/B4FrCCTGyM3fsg
	 TOGUCWmSZ51ASNqCksqr3WyaowSClu3E193+67OjQun1JelRsMjoy10cekk/N71lTW
	 voQXWA/fEJ7OFz+FJN7QroH42Sb6cxCqnOQa78RCwNn9F8JRdX+eSVCZVGDrrdQowj
	 66LUdlERG8nFQ==
Message-ID: <sashiko-outbox-192267@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/core: Make amd_core_pmu_init() return void
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ingyu Jang" <ingyujang25@korea.ac.kr>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261101040356.3204097-1-ingyujang25@korea.ac.kr>
References: <20261101040356.3204097-1-ingyujang25@korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 04:08:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> amd_core_pmu_init() has always returned 0 since commit 471af006a747
> ("perf/x86/amd: Constrain Large Increment per Cycle events") removed
> its -ENODEV path for unknown CPU families, so the error check in
> amd_pmu_init() never triggers.
>=20
> Change the function's return type to void and remove the dead check.
>=20
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101040356.3204=
097-1-ingyujang25@korea.ac.kr?part=3D1

