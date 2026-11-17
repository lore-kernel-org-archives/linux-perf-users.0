Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946822;
	b=szWDugRWNfDefqR86gqcOaBdGFx+cFlf7SEtmfb0dg0/hmZHDky4z9fJ4sgYPHJAIThD
	 MH+D9VHdIZrms7ILDfEN2n6if/XeRq6GFZTco2xn8Iaj4GcB8a+pOOBTcIddm7vTGMTAF
	 zTo+BFlR83z4vLygDlOgEffEsNbc15xHR61IEivf7LmpprKdzfAAQRebdUAgYx5aJD3VO
	 sPpc98s1KECusOTFHPfrdm5PU/ViEVRH76h1z4Gy713EwRp+CH0Joi1H8ooQEY0j5tcbM
	 dGStStJxNuRj8nbQ9+xLDYkgukX9Grq9FY7ShdzvjqNsRa6+EkT7uIb1i1SARn1rc4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946822;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VfTRzpLevrZUa359Cjzxmp8NLyoLxixjMY6/g1mFw/0=;
	b=jsTJWDoXvKJSW0Mb5vl0VQEWI0iU3VEmR7WR61QZLi72BywalJ+D+V+wUkom2JEnUx/6
	 K4C/zgOa+YEbGhYflBzirVB3YCKijIr/3TZhcrM1VoND0w6IumduJ/dAlZItARn6iBxAX
	 zvd3pzIaCzAJRxLMgA+CVmO/PzBwtyK1CzY6HiEbMSLmy1qJwzB3TRsYYE1QOYlVfx9fJ
	 ALSl6b34y6+L3gRznZDN6xQO0bYJ2n9FkChs6M/yUjR9J97s4/q6iXGVIeRBa6iVWHTEK
	 wFNHhzhV+cHLNMRG+8520nPpmmhd9yl+RpHseCdXt/7H0ZG+Hdjs+4JZfh8YuXB6qdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLFCE6u4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CD606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLFCE6u4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771071F000C4;
	Tue, 17 Nov 2026 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946822;
	bh=VfTRzpLevrZUa359Cjzxmp8NLyoLxixjMY6/g1mFw/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FLFCE6u42+pw7GeqcogjCDKQgahubYuqSi1VlRNs+jOPqNjJ3ycvi5pK6+JhckF5e
	 IA+LHv89xuXJQBWMaydc/yGBiHuQd0osRQdr+si6iX78EKEaSngbBbX6O/Nma1/N1w
	 hlHbOJGj0AI1xb4td3LegGliIVdkLLTGhHnDYmxyQDiMtWyKGZnpM0tZ/qnoijqEDq
	 kqBip3qNAo8chxrhWA892mgNArvltYW3ZwIoVnG2a8YaMhfuQjXF/KGIRT57pgSRKI
	 NDG2bAD+AA8blhDL8eF8kyWlNoaQoEElMmHlhrQY2Om8K2WCEiOkfED/ENxx+Wp+CH
	 I0dwXhGwl3lOA==
Message-ID: <sashiko-outbox-219590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/13] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-8-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:20:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> At -O2 a struct pointer lives in a register (with DWARF describing it with
> a register location on register-argument ABIs), while the unoptimized
> workloads the data type tests profile keep their variables on the stack.
>=20
> Add a regptr workload with a noinline function that takes the pointer from
> a volatile global, so the compiler cannot constant-propagate the object
> address, and check that its three member accesses are resolved from that
> register.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D7

