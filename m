Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020357;
	b=GgQxISKCVH39vU6BFBsr4y9o9WJKw8P4b7h/noBd5YWKwjw7KIybD2CrO1t5xfw9MC42
	 n2DFHYDINsbdUNdvtYDhJU4vWLBYXUfqAK+IFAt3s7Lfrq4YYHLkz7CYQTqIrSSsgjB50
	 N46buCavjVWjKbKtiOybyZ/xlggGcBHZvKuvNkEYA40k6m0joQcxTjiZ9JjFkpPpgetX1
	 6ZeH6dFDs12xTUIUouqE/O2pt3T0oi/9/tPx7EjEIiHJCBE4stEfYI7mgyrTuwW4g7ENS
	 FJfXfBz/omaHAK1I67wLYxcvyIRspjikGpGWOh0Y5MSODMeNmsIGA72Y+DYg0AiZxag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zpRiuXwc1iI/yf7V6LIqDABFHVho47Besk6CRpkY4/M=;
	b=xwEXgozHamyd3/Zr0iLcgnIDAOJ8Wr0xGbrDtBa6861zzUW4wFTwimKET+n9wAe4eeDb
	 zr5f3kmad614T71hEaJxq1TkL4Kq4V+Ek3TklnBk8Wm1D+WVJMMjr69F8WCJRKu1Xh0V/
	 OvZ3vNUE6PNtoeYHG29xK2zv5H45XrnRWFp6R4z8FDmUCSERKlZmBHpWTAu5fD+vdhW0t
	 UYkxeuhd/ERVB7BsC5Oyh4sbxPg4gXB4Ai5JKp/3vqgHgpDeStcciEoX/eWBKjvVy69+8
	 1YaeN1SZUHBXOOLcQVJ776T89BP0LArIRRrYvWVpwFK8A9oL8EYNlZkYUuiAV8V2dLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mhbd6Dmc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F5606A330
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mhbd6Dmc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F541F000C4;
	Wed, 18 Nov 2026 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020357;
	bh=zpRiuXwc1iI/yf7V6LIqDABFHVho47Besk6CRpkY4/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mhbd6DmcuMJ2ujxSd1PCyYcHkIiqG2gTbPWLrXxb5dQ+/3hpOhn1KFMEKImTTtb7j
	 DD5Jfqw++KxyXV81z0wVogBCI0uHbX34Mskr5UTtpyKMrgQa8LCu6/c0MnlyS6BnUg
	 /OuMbbD1jwmuNjvm16q8nHnByn7S2wUOB0ydV40CY7TVEBpzoyB8oIDEbkqy8n2XlM
	 oFJynVMcacVwQS33bDytyIWiUgxQxaveKov4ar8LNy7hmxXlcguldD1UK2ENV1HVJW
	 CSDCfEnnlEW+pFsRIkh7O37X+daz8fMj7GQNj1SFIJQxiDtxJXNr7o6rI5L0ZLHKUN
	 eccd8/PW7SYIg==
Message-ID: <sashiko-outbox-221544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 30/34] perf cs-etm: Invalidate OpenCSD's cache on MMAPs
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-30-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-30-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:45:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> OpenCSD caches instruction bytes, but with a JIT runtime a new jitdump
> mmap can replace code at a cached address without changing the context,
> so subsequent decoding can use stale instructions.
>=20
> Invalidate the packet decoder's caches on MMAPs when virtual timestamps
> are enabled. Without virtual timestamps there's no proper ordering so
> this wouldn't increase accuracy. This is unlikely to cause any
> significant increase in overhead because MMAPs should be relatively rare
> and OpenCSD invalidates the cache on context switches anyway.
>=20
> The API has no explicit cache invalidation operation, so disable and
> re-enable caching to discard its contents.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D30

