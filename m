Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524156;
	b=oxfwOQ3l4s5lWrdZqXiCEZjTS8dt8lrAKopp4aQlSqvHexlYOGfFh+API6r0scNFYnW1
	 jrUyjMgZ2LMW3Y9bb33shQitMTFBXQzia3kQ28NHMShoWwXg/wlYghLQpwb1oAIXIQi0m
	 dmYspm8pfS5eQDkYt9M0UzBf50tEv9Jae+xTYb4Z1OwwwmFqnFnAjVHIbQXEN4DBwzFfW
	 JDmKz2QkUp7zh7nS4eK9yMX2weNWbsUS82t6pVdkXgkAFLCiUYks+wQTk1tEHIJOlHsMM
	 nmz3olTRF97UgqwcDZCrqFzlyrdYvyA8JNqBr3FwqyxBRrc+NH9e3LOBoEBL5AHsvUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524156;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GQFZJuVMxS7mhwMp1ulf7TAAWs1vPeYMKrt044hBxbo=;
	b=MibVD3r35rFIX0BHRuPGnTcz9qKO+7g2OhE9yvrVr2tBSbkPOg2Z7XcqK2iRrN57OZ39
	 Rdyc7iXXGi4y9yZk5raIrGvsJkgOrtM8qydLpjUhNa1kFFTHNhqD4//XEDiSjqo3P+/AW
	 T46ZaRugh7dm1Oa9SQuzG25K75IM45SvnFEFPZuwXSRf9SoHsvNo5qbrMKWcJIWlcXpdo
	 n9YMfmM3UFm+gnyOVOVi6IQ8G0GQOF61IfDTAs7u7rxBT53oHVTTX/T1982oHox+sT/KD
	 rcHN92Jr2AeEileq248f5z0GYOf7pmVkc+4V6/566SqqXgYm5yc1LUUFlT1dKhEGQbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K2trm/Wy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4A606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2trm/Wy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C513F1F000C4;
	Thu, 12 Nov 2026 22:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524156;
	bh=GQFZJuVMxS7mhwMp1ulf7TAAWs1vPeYMKrt044hBxbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2trm/WyY1Rc4SaRi3sy6DpZ1EBMk1lkUKbCYY2Gj19atUEzOXw8UVpnyxEMDsfut
	 IPXtiTjv1VtfVwxNVN5GXaaVs4dCk1hVEM4MBxLyo5+WWcl5lNOgOehR0y2BTbbsoj
	 GweZNFi+ySCU/z2/9K5/TTBTlcz5x/Ly+IccVOMA6kcxJ6IYmpl2xpYlkq+mgISI7g
	 9xEsSkCsj9YQ0KQzit0HhV0gVw05orc0Ch3cE1N1oPiui921SUGcVMPqDQczzpYsOS
	 skRqfF4iqbr+VVbHuEeai6UUUrRGlVi5n/f4Yb6txVZXkiH0t8l7zDCt56DPg0pt5p
	 Pm3hINw+wHF9Q==
Message-ID: <sashiko-outbox-211927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] MIPS: perf: look up the PMU interrupt when it is
 requested
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112224445.213324-2-rosenp@gmail.com>
References: <20261112224445.213324-1-rosenp@gmail.com>
 <20261112224445.213324-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 22:55:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> init_hw_perf_events() is an early_initcall and asks the platform for
> the counter overflow interrupt through get_c0_perfcount_int(). On
> ath79, that interrupt goes through the MISC interrupt controller, so
> the controller has to be initialized from IRQCHIP_DECLARE before the
> early initcalls, even though nothing else needs it that early.
>=20
> The interrupt is only requested when the first event is created. Look
> it up then, so that it can come from an interrupt controller probed as
> a platform driver. The boot message no longer prints the interrupt.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112224445.2133=
24-1-rosenp@gmail.com?part=3D1

