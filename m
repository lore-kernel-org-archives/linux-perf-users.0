Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694187;
	b=URKQDRinEfYlW+s3r4vk5fXQJgm7ygfiiE/J6zNO3eKgioUokPZPdFWEl7Axqy4cOyLc
	 ifjBsm1QEZYjKwArVvKS6r/EJLDECv5obKwXqX9YWrV7OzGhLxbzXebdguYIJCiwnS2js
	 PgK9ToKm1kdounOdlf/sptDMg46TLayjfFtx0ntEmiFWVPweusrEldAdtRFP3anF0ENyI
	 0RXEnWlw529ivmS1JygxWUuSNmaSFrwXNMK3GSVxq19TtiKOUSUuEu9izmN/9MMSz0QC4
	 YM54kdy4x70l8ejc2U/Bmgty8e8mVaRX48Lv0w8Clia/tMKtA9ZyuLn43CSERh/hPow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694187;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zyEH5qQeBk8aPgh9727MJpc8SiWm6/FkT1scJGf5st0=;
	b=xggrgpsg0jNlJuCbHlU77iz1dRAwl3sMyH04fZnoxrPa9E3IY4HP7LMM5SLp4CboThLh
	 +7jeRTa6ZklARX7y578BlIA82dzUsW2V8L3DYC8Mla8fCeElPDM8FEQsRa9H4j2h3iLvL
	 s1V06rYkgpfI46dmNzAULqFUGbNF6oAn0+l79fBEOoeB1Hliqk378b5uXJwQGPznad3Yq
	 yi8liWMoH0yNW6EGc9LLSAeW6Vr4KWrNAwGFj/i8hUXb3Tg536EKfx2jMCQL6ng+ttpfp
	 Svho3DKriESYla2bk7j+XFC7p7bjj3RF2WllAAmAc3++lyE7GxVH0ntl+ypO8DygV/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsVRDCBw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AFB606A322
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lsVRDCBw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9696C1F01829;
	Thu, 22 Oct 2026 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694186;
	bh=zyEH5qQeBk8aPgh9727MJpc8SiWm6/FkT1scJGf5st0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lsVRDCBwV7d3IvzXBACdDmMx7WPTWFJePb/Bc6F0CobCOxKgrf4m2QirdMRd9Kk81
	 JgpMtaOW1nAb+Rprj5yeLKa63BVyo/WC5Se8nzaTGHnK/T2IIZ7b5kWRXPrlThRo+p
	 w3YGZpeDedThB3jNMHjlFRO7+qtYLqse/TSfBeQB2KebUUAOm0VzgszBTsoFLbe1BN
	 IFljtJPJ3ukU/5C5+dlVZb2UV+18aTj6tOO/ahc6O8ZGFF2tXopqV5spoQBJGhcfVB
	 pYd2Ch+fxHwRuAjhg2fnV1QwxQ/T8VOKDVhN+C5MMq436fzicVBaX63/pwLMCt48wR
	 8FzJM18/SONzw==
Message-ID: <sashiko-outbox-181929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] perf tools: Add script and make target to sync
 the header copies with the kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-2-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:36:26 +0000
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
> This is to be used by the perf maintainers to sync the header copies
> with the kernel originals, see the description below for how it works.
>=20
> A copy is left alone when only the tools/ side changed or when it carries
> intentional edits, and both sides having content the other lacks needs a
> manual look, --force then syncs and records the tools/ additions that are
> dropped.
>=20
>   $ tools/perf/scripts/sync-headers.sh --help
>   Usage: sync-headers.sh [OPTIONS]
>=20
>   Sync tools/ header copies with the kernel sources and create commits.
>=20
> [ ... ]
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D1

