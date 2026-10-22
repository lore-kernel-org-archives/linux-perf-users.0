Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700687;
	b=wezDXW8BNy1KOoE/LJ/PcWib6Xu3CLNkpWpRJD6iVajMOGOMUJ0WJAv32/vJvBnWwxKd
	 1MXBc7oyjr37VBHeQSve5M6eFxFZz1ViI/3a7BhM0igEX+qb9FLtGsq+2qQ72EYBIFiny
	 XyAc8LOEtpPA7j4o8HkC8D8Y4t9+CP00rv5N9TvI89Kcb5aI+z9XEcOUewKv+MncSlTWV
	 cMYxyATUk70FzWF4s83P06/nvLf82iz9NG5BEeFm4R66Q7s2gpBSTOYOGGUlfJ2IREbd8
	 7W4bJPGShDzI3pbX0oACpGLMxvRU5yoXO90PE1yBqCcENbmw7bqnSy/cNz0DhEU2PPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700687;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cJdP7JiqLRQdpisMYozkKNOAHnZcvA6P8t6XW9fryvY=;
	b=ylDI7b2MIhvyoUwTQxUfxD/xbNhV92/m7h8L8SMUFiwmqtaYk3aCf+C+XWwvVE/FWh0S
	 53O3g9F/sj2UMHhQDsnDERANseYjT/EfCV8gWMEyL+s3lkITvpUfvJ/HwjYLBVq80TyNa
	 aL7kLlkdFuRmGLvPRWbmFMGy48OcazW62gzOny1q3R1OET6jo13a0Q8nKnlA5LoC8P9JG
	 Q2Zm2DRZJNgkRrbe+OoRaslEYGIG6xxtY1U7cIc2ggV+T2Z6kOQANr8Tj4SE0V1o4Ofz2
	 439ByY48jaNp8Rwt5yueehREwp2T21S4SzN5sW9EhNXpccQNCHct7v51BDPPEw9xDKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cctUzYSr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764D606A31B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cctUzYSr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBF91F01825;
	Thu, 22 Oct 2026 20:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700687;
	bh=cJdP7JiqLRQdpisMYozkKNOAHnZcvA6P8t6XW9fryvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cctUzYSr0NBLVJzScpSFsAmUBy49E2hxs6aFqNdCQlryObXHnlKqcnO+DruGDs5pd
	 JJW4FNW3eFptX4HHumv2YknaOFSZf8aSbpInQJdzsAe/cShpiTJAb1cMiZ66DvASl5
	 ZF6xI9t1yk3lNCedoRRAGUKFmGTgga7vpGf4F+GUh4qHnkP+cUKJrYjf1LuDcE7EtZ
	 14Y1w5BM/mqThBN71GQ5BcKYuCgrwgsP58IwebPi8dKaQFwrpVH7z52HstuxxvCUlW
	 BtFcDD68iWB6lqcwT8zZOYh7zrMd2b+lPdeGTjZqxpuL6Fkqgs4VS2l79Af+mwNfM9
	 qziY2Ikkmw/IQ==
Message-ID: <sashiko-outbox-181996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/19] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-3-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:24:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D2

