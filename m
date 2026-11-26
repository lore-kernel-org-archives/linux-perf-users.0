Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673594;
	b=KilB9CmYIi4cnLRPOlhSgSiE5/+PaXCQoAMC6nyzrAqT/EN01vW7gWr5bP36aZGHMjkT
	 3JQ2Q40YdJnV4aVVyMZ1ujrNh9cHB40GOeDITrsAqPAR9AK/5IiMixh/8etBLW44QLwjl
	 BIueCwhBjionqNL9jYsLz2Ynkue9EFEocaxCtI5vbmAm5bSuEufIhT7XPP/NXMJoT1L8i
	 WU0h4SYAG+FxuSdp3bMIhw/phWOP42GhW1Wy87/PXYSYaVnGsk8DQz1jkOffzoKa1a1ma
	 w/9zjv9YiSNw7p5DtUpNtCGlII452V1e+gOJX9X8nrh7UiNw8a+MR54ye0+3MqCUOUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673594;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W0vyi4M0jYKFRwvYNMn+NEUV1INxYJZhdffYzuTqXz0=;
	b=hUspz1wkKif981+LSizr7ny0vjevhnYb4RxfxeBtIKJizkSgVeMa4+pdz1dstGOtNGxC
	 PYpU2uusIsZURTabAPB3URVfT+PpHJpfLK/YiLcvx7Y0Eo2axbtRsjdJMTTOCR82q5QcC
	 KKg2/Q6PgMHOyslxLh0ojIwopSCHlN6XNTz4I2GxOWc2WejmuHtfEYj2XgAlgfH7uKt7x
	 RCT8geNDAv8A9u1P/IdscbKKhoT3Qdr3FjCmM8D+KjkyGKwDryceowVXPJtpwH+10Gl8v
	 yXyEeVZDgK4AFvsumcni5SH/DG7UFQC0jbzTI2qAkQ4vapI/BHNABhA9nJvw705eKTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBRbUeXU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5B606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBRbUeXU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFE91F000C4;
	Thu, 26 Nov 2026 06:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795673593;
	bh=W0vyi4M0jYKFRwvYNMn+NEUV1INxYJZhdffYzuTqXz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eBRbUeXUGSSDrqrH5ZoIDafWjMT90H0I5UodRfOv4OJIqmdE7tn12q3VQJbwh6aKt
	 0IUa1hVjuQOAPmSIjO2BJxO/RZg7+G0CjZPpVvMSh2YWTlU87S3icH9tpk/BYicAE1
	 SWRQBiiFJyECci0M/7W7uwgT4Lgx31WfPVkjYHtxhEUFGgNMs0fhOEkq3ocV+PSaaG
	 0232jdWXLi3LVEBn1l79G0PL2UDuhzMYBx+ezRjeqOjRrze99gAG1Emf2CpKhknGyJ
	 zIcQL/0Sz97Z5WO8FkOtMN7OKUzaMGYbJXhCf5LVisso1QkpLT8B2ZLBBUP6NhdsEP
	 Uuj0ju2C+zvbw==
Message-ID: <sashiko-outbox-234828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/build: Include linux/string.h by jitdump.c for
 strlcpy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Safonov" <dima@arista.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261126-perf-string-h-v1-1-8f5c39ff30f0@arista.com>
References: <20261126-perf-string-h-v1-1-8f5c39ff30f0@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:13:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Dmitry Safonov <dima@arista.com>
>=20
> jit_open() now calls strlcpy(), but jitdump.c only includes the libc
> <string.h>. With glibc older than 2.38, that header does not declare
> strlcpy(), causing the build to fail:
>=20
> util/jitdump.c:246:17: error: implicit declaration of function 'strlcpy';=
 did you mean 'strncpy'? [-Wimplicit-function-declaration]
>   246 |                 strlcpy(jd->dir, dname, sizeof(jd->dir));
>       |                 ^~~~~~~
>       |                 strncpy
>=20
> Current mainline gets the declaration indirectly through symbol.h after
> commit 5a9dd835894c ("perf symbols: skip livepatch symbols when loading
> kallsyms"). Stable trees are affected, in my case it's v6.12.119 with
> stable backport/commit 649bf062b91d ("perf jitdump: Use dirname()
> return value in jit_open()")
>=20
> Replace <string.h> with <linux/string.h>, which includes the libc header
> and declares the tools strlcpy() implementation.
>=20
> Fixes: 4eddf7d9e341 ("perf jitdump: Use dirname() return value in jit_ope=
n()")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-perf-strin=
g-h-v1-1-8f5c39ff30f0@arista.com?part=3D1
