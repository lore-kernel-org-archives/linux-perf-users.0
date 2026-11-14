Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794638688;
	b=yVfSbNuY+VkU7qy/+kGMhI/XlC3eGUYYo/EaVq6SuuNjVAGBtHGgDRviTWJFy/bET6xo
	 XqrJus4sKo9mnrEl1FPBXWFjh54dhtZW73H9nLLbCUNzGVVs0NQxGxziJ3duFX3YR7+Ua
	 m+KmNGQ8nDsPQPJcOydycCnxCvwxrbk7DYf7ZX6TeKhXXtyNQkI4CdJJvCxQs84EExgCl
	 SbQVZpiDki7oC85VbAwQpMCr4ymj+flFgHnJyjuDhG7dUEuCPqOJsz08UHW+Rb6DrU+ad
	 E8BxnoJVx0Ao4Xj1wMcGKNEH22k1dCYre1Ft/wzERfoALzLPw4Mj+ibR+KMUjjltUQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794638688;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GEJPsywOUkL5+8Zrd7q9GUB69VLgLvLR1ooePOsVH1A=;
	b=RzPU9JPzoPKFvIGliCkJmd5y0r4sSpQpZOl+6CSmky69tmv6QGeQ55uFGoMhx/P952bQ
	 8X+1mRSIkWz59D9RyiZK0n35xQA1LgUoDZemfJxplSdzMaei/4TvXZBTo+JuCYO2mRZsl
	 o53i9hGGgSLag+EKdyUst4e9hV1JXjooPvLGS3XgCYfhnGUJTpC93kJIG+07F1GrIm0e8
	 h7CSIoL1yocehTMSkeyVpI8ZwSHsA9izRTVHQbqjEeK+SuWfzvtp/eD56YXD5/TGatCnA
	 Wna18M0XAKyr4aIj5TqtgzGtInpOMP2rE7HdAiTmPNRIdZGKIKmJmu7M4j6gOUVx+IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mtzl0Swv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822D606A893
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mtzl0Swv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B781F000CD;
	Sat, 14 Nov 2026 06:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794638688;
	bh=GEJPsywOUkL5+8Zrd7q9GUB69VLgLvLR1ooePOsVH1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mtzl0SwvzUigw9WjlBQmRfg1QOqp0qGLkVsi69UMXp922thxcWmkAQ2Nnr2C+I9/3
	 u/UDn75suWaLuMnzhKybjX0FmohTtE8tljSW5WE48WT7fHCKTMLVUXUGxK5WoqhSab
	 WCYdTQf6txecjMsbVlZIc2rDDgI3fVQogUz6EKbE3j/+ECfQP667bEhJMK6rf+PK0s
	 lXFNSYmP91J0RPIP57NEp+ly3DAhG1QKoNuNgudplVjHHgk0GnWyDtKZQ5jWZspZ/B
	 whYkaNcuSxX4Ug6IxfsDmm/Q3o2fyvmQ3vGGIOIjew5rmSRaSMSv+CGbm2oy61UAJ6
	 pbF57johu1L6w==
Message-ID: <sashiko-outbox-214232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/intel: Don't allow extended register sampling
 for BTS events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiwoo Kim" <arpe1618@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114062249.1301-1-arpe1618@gmail.com>
References: <20261114062249.1301-1-arpe1618@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 06:44:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> x86_pmu_hw_config() accepts extended (XMM) register sampling in
> REGS_USER for events without precise_ip, and the same goes for the SIMD
> register fields. The BTS event is such an event, and
> intel_pmu_bts_config() does not reject it.
>=20
> For a sample taken in the PMI handler, x86_pmu_update_perf_regs() copies
> the user registers into the per-CPU x86_user_regs, which is a struct
> x86_perf_regs. That is what perf_reg_value() and perf_simd_reg_value()
> expect: they use container_of() on the sampled struct pt_regs to reach
> the fields that follow it.
>=20
> intel_pmu_drain_bts_buffer() does not call x86_pmu_update_perf_regs().
> It passes zeroed on-stack registers to perf_prepare_sample(), so the
> generic perf_sample_regs_user() takes the user registers from
> perf_get_regs_user(). That returns task_pt_regs(current), or on x86_64,
> [ ... ]
> patch and its changelog. It has not been reproduced, and the change
> has only been compile-tested.
>=20
> Fixes: edd9aec51213 ("perf/x86: Enable XMM register sampling for REGS_USE=
R case")
> Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114062249.1301=
-1-arpe1618@gmail.com?part=3D1

