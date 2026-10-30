Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373848;
	b=vXUxlrw94Ja7rE3klSep3SEte4kAG83ZODO1XLH12iHEL7xTNheqWBUF/a0AlyHVqJEv
	 0NJ88NA7BZdlpuWD/87S6G1wiWkj6Nd7PC9949ftJUOqAr+nD/deuLEB5vmQMLOaA6OCx
	 AtRM4qQy1HqtnP6sLoSBWo7a7ulwYpIh2si/BN1Y3ipfX1KlV//qQ+3QCOwWcYHfYmbtF
	 YeAvoY/ZwHbXBsOSix9LOcb/Lnh56Ghxms/6ljNxhy9ze3wiXS0KUpR5uj2yPKJ2v2l8Y
	 jvdM4ziDNxm2SUP2sKAWSDSFV/Ov3lIvRTQRnwCx4smUAMxMj5zzzSwal2wxWdwVP4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s7ubXvYBNdVBbcenw63tY91KBxghVOR0nP6tzsowUhg=;
	b=pXJvSeoR56gDuWG8aP+3W6EK769ouirx/BSHbJ/Z8jE7gENdJXrDp3P8f9RKqGKtifu5
	 LICugO79U0L7yddfyIYfRElufIBikQcj9u6FgmP/8d67qZHpLk1PQ0VV8sHT8ggkjSji2
	 W4jbqm+xsDG/63o8+hMMsuqy4WqCDAwypEHB+c69v80s5XHmMb+Efj1FTjqvfeBpqOf83
	 Ig9xQ5oFBDHEaUHmzdcChYdcA+xPLSuipBNLdUVn6RXhd/8Y2Mt3QgXeI2PQXFuhP2BqJ
	 wg0zQd0AdhZEX8Vs7nlOeWxnTbKKxZnYvYmlaGCTcEXvNn6J7Xxl5G7CzeojUGLsVjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQm8Z8qB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C8606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQm8Z8qB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4221F000C1;
	Fri, 30 Oct 2026 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373847;
	bh=s7ubXvYBNdVBbcenw63tY91KBxghVOR0nP6tzsowUhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQm8Z8qBcIpe6fYhw6Ltq8uR88uJccNuqt9tpTQleFAFtyHZrq0ehq2YHL2nzC6vC
	 qYdO/A9U+SAjtFlvLmpjOPzILe/IYYY2IzViNk3ARFBd0Tu83tk3ZDJa7gVnwFbXNy
	 kpE7FHZZnn6RDJetu1IAvi1RFHzfc3VzgOp9ajU67Sf6JwM8iyLCccCVvCUyWNyUl/
	 n7KTP4x8FB51tsx6vRGRAu83bZeL7fnzKqjad5con3aeGHvcuakpM0LTpPRIWepG7E
	 vC8XLxg77qvomCO/KRpry8J2xG5sQ6TDZB882fhFPC7lQSF9t6hIiIMRy1ADYMl/sR
	 3WbR8KB2/7NIQ==
Message-ID: <sashiko-outbox-191165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/14] perf cs-etm: Break branch history when
 instruction memory is unavailable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-3-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-3-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:24:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The decoder currently ignores OCSD_GEN_TRC_ELEM_ADDR_NACC, allowing a
> subsequent range to be paired with stale branch history from before the
> unreadable code.
>=20
> Treat an inaccessible instruction address as a discontinuity and flush
> the pending range and branch history before processing subsequent
> elements.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D3

