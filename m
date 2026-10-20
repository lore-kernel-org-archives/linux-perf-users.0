Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507392;
	b=LMxhUKS3tOe8ecbzQaPoZJnf16mXpUw2iZkCoMqyDQpDn//mw9V0ct+02d7TuZT//FV6
	 X8XJ3SpNnXov6S4eDtwjaVL0+0AEZlpJSO8evx9WEIluLowO3Tf3pvXs8XvKEqQgSU8PJ
	 pj+89URGQRuf5bLgSfA8LSrjqmnyegKK757umEy2h7iFBlaD1PyLFadOJOwz1gd4T8njV
	 3VM/vpvvhMbjIFWZHMU+iM52cx0VsY4xZeJjNP6Ubt+KTo97IvSw9nPXDbZS/1+hkCFvg
	 X9IAjtJxBvb8MHd+Z5DyQIxvYCemeqnY9dh2LRoKpUr1AKeCjeKWx9/xrikENo3Qz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507392;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GIaFPs0LZlFtylBvUkFEW+0QGGEdOM4fw5Gj/vuIZkw=;
	b=ZNvQwUaFHR4tzDaUjyEQJPGMu2k29lKN3KF9Czcv2ouZhj3LT12wKCHwc0ITKeFqcWt6
	 W2xpscWeSvSB2yVfGISjPWe2ADtJD8TsjYVJOmhhaFZdnzbrrWnVeqFhAYS7aCyZ0atlh
	 LcttFXl/riq8BljEwm2rtQ/J6BCmVeDGgAnDCumXqdI8bn0qh+5ycrbbwVqCAOjp+DAog
	 FUcCu/hdIYVS9DR3UZIbtm9gpeCLvytJzZlbRPqWS3kUIda3yDMGvJRPwS455aQ4NbHy5
	 j1rLBBM8mvo3FZO2yYtnYdIIX9b1PN1OI0BzQ9uYyIqGA9ydww30NdbSZmFWF4fLtJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2hnDJy8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C20606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2hnDJy8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDFD1F000C4;
	Tue, 20 Oct 2026 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792507391;
	bh=GIaFPs0LZlFtylBvUkFEW+0QGGEdOM4fw5Gj/vuIZkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d2hnDJy8XpgTlcOtXhDKLVyMJkDCmse4VSQqNDLG30yNzEtXuKPk48gFfhViQWhgY
	 DgXOaHjBY+7ylFiRnEQIPFJRaQIDkNWrnSSONS5dDMzbxpqYo+CGsBFVueg6y5/wFy
	 9Y54yIPcGMDIDWCzSm7fs0KUjczDogtzZWazZyCvYNb1pRL0WbxQVfJHhopRVZSlTp
	 1HZJuwM0KhDXEh5BlhxhwSOYIRQYQr+FrTRSmHia+E5vLeFPMT7D4wlV3sgE6mpKmW
	 VZVV+ih+YtInItTqJ8J6ApCJjHeB3Au8aVIYLOicmZx+/2IaGO40iPGD/i1SPbpfgK
	 stUasdBfCuaOQ==
Message-ID: <sashiko-outbox-179183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/15] perf annotate-data: Expand type_state_reg
 imm_value to u64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <66343ad84d8a95ca695b2f716969ac4c2de0b7a8.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <66343ad84d8a95ca695b2f716969ac4c2de0b7a8.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:43:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The arm64 'adrp + add/ldr' instruction pair involves global variable addr=
ess
> calculation and passing, which requires storing the 64-bit address in
> type_state_reg. Currently, there is no field in type_state_reg that can
> hold such an address. The most likely candidate for reuse is imm_value,
> but it is defined as u32, which limits the size of values it can carry.
>=20
> To address this, expand imm_value from u32 to u64. Also update related
> compilation warnings and fix the sign-extension issue introduced by this
> change.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D7

