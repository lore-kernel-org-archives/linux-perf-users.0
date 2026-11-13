Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528272;
	b=j/RzCqbv3/jKu4IWirh5zsQQOe86RWjrrxwxFRU76mTj/wTn5C30dgHR1N6CIa1tUIw3
	 c8y0Q9/rzkbt9PgnozVIHV8TyjDdSNdPifvd28pLfSBuvvoKX6BM7KAgZwKhSSdbVNKOm
	 atjFkIe0qoQxrXIQFYOnrTL0FdIxkyOza8I2Idekdf+ZfYHgvXQDCErVfJxpek5e78gCa
	 pXEXycgZE5+ssjHpoVcMl087mzciFb5bslc+9MEN9hQn5vc9tSI+7pRn5u3DaytTmEwaE
	 LyI+26wFq4bVorBaoFMM5H41z3jR18pBgR3BjjpOj3Wnkr6a1CEr/6nTLtdxUZ1Wlow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528272;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6z3KiqEB2MzGEe99poEyfhx+Y3N9KMpkinri16H/VvU=;
	b=YZQKG9mghYXAdfC/0rGnkVnrhTrhA+cdyBh2JG18IwWU577TwYlMHhJCrwLDt/rsRf4G
	 HMbJNrr+MLRKZEfsh7hyOQfaHXlOIOITZyKscBOfxKtpAhiWi1/03MAJ8Kcew2sW8q4X9
	 HyH07NkbmDdrPcpv+bcrDinJy0A+UUAswTTzH0/XxY+Zuu0DTzbdaE/l/zDhZDwqqkPSz
	 itzOqn1Y+SpZkobHSSILm14NwJntqfxEj73gtat5puW/YhMWwMGTagweTjoIAmNRCK9ny
	 R3C8L27ZGj7y9kwwcf9a68MHmyDVBAFqmA6hAGsjGDopF7XvXekHpj28mYFWX+WucBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYhexb+X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F1606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYhexb+X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC4A1F000C4;
	Fri, 13 Nov 2026 00:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794528271;
	bh=6z3KiqEB2MzGEe99poEyfhx+Y3N9KMpkinri16H/VvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NYhexb+XKTKjH+ledmzhueMXOzpGISlg5keJxBZrdFAxTw0oGReea9Ss3nultzRW2
	 2+IHBLKwYWK/ibcGN5/A0WfzQfPCrRTq0BWZoYiHXU9k9ULm2PjzCxhqhXXXAh+F6m
	 pyyY9a4iQEVJw/hgUMdtZ0prB4uVmXqerUvm+M5daO+oClhzlba2tjeQQ4RcYklTBR
	 d4Jyh3KK0R0GxRdhGibtmCph3RYmjdcv9pgFKYS6GYoYE/ZQH/bI+gWxx2WP75Cd1a
	 SEE+lc+YZzhSRNAENSr+AtrnO3aXkyTcHeFFhJDgOW8jNVZKp2rCvmrmtq1J/hiHhm
	 btMYMNcq+2KZg==
Message-ID: <sashiko-outbox-211974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf/x86/amd/power: Fix missing CPU hotplug setup
 check and cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ayush Yaduvanshi" <ayush37735@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112235003.18608-2-ayush37735@gmail.com>
References: <20261112235003.18608-1-ayush37735@gmail.com>
 <20261112235003.18608-2-ayush37735@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 00:04:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf/x86/amd/power: missing Fixes trailer for commit
  c6a84daa3498
--

commit f8ef67a4aa6a417d77c332568d6bad06f58d1c90
Author: Ayush Yaduvanshi <ayush37735@gmail.com>

> perf/x86/amd/power: Fix missing CPU hotplug setup check and cleanup
>
> Check the return value of cpuhp_setup_state() and remove the hotplug
> state if perf_pmu_register() fails.
>
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>

[Severity: Low]
This fixes the unchecked cpuhp_setup_state() call and missing error-path
cleanup introduced when the driver was converted to the hotplug state
machine.  Should this include:

  Fixes: c6a84daa3498 ("perf/x86/amd/power: Convert the hotplug notifier to=
 state machine")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112235003.1860=
8-1-ayush37735@gmail.com?part=3D1
