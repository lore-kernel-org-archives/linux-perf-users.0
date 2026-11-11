Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365322;
	b=CJEWq/rgzOo1UnwEQegQ3uWibVrQ2iIfssEaz4N074f32ksU9gDj/dRVXSHb8imHnlsj
	 Bw1y65Pffacjt900gElrSkkmWsXwr8DYEcm45YJqNp+ZUhtSgn3mEazgLobflZVENZY+5
	 s3ROVU4bos8CcAHlTVt1Iv5Tz6GRDPISF/t810jQygQC2ncr+b8vAlxxipDrvj1Zfe4gY
	 ciuX6gvo7o1xSB0wc4GBKspYE09s01jDjG56Cmoh2N7DOMWNyuEX7zoNqF13di6mME0Zc
	 yrufir3nc6rQ0Gf/oEcwTr+uIkFNTOzArF+8ZB4/QjFUzHRW24akWnj1hTBO6CrNe2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365322;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UkaN+WKJVYE0wAdBmT3TjxhtZTYcXbe3yA5ENdqEmBs=;
	b=oMqSikG4Gb9dNGti0iz2GncuE4Vsa9yUUNZky52ETZORr51T777tqZH09P0MQcm7Zuki
	 tEj/tr4xKBv2Wd59OmWf4x2lHYVNqsoyG5wSBb9lyiS3NtWFVNaqmSB/B7AZmO9j2kGny
	 Iu3YMigaYCAhwq690jmtRZ88zrGZi24Vgy+3q/RaJnUu0xdAd3bWwNgDaAEJZzSeXPUAR
	 /KXwGAnCkwEVc0K8NEt2lfCBI/XwCuB+12UFfUX3ZFonPYp/N4mkfgvL8QSIMn+Ocr74g
	 wzkjPrld/cN1VI8rl9p7TKVJpDBYkNQS1ALQlqccP3jZiBS5mzX4Ee3KrJ1NvqBTcIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNOZ2YcV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A24606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNOZ2YcV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72BE1F0089F;
	Wed, 11 Nov 2026 02:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365322;
	bh=UkaN+WKJVYE0wAdBmT3TjxhtZTYcXbe3yA5ENdqEmBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNOZ2YcVoRa3N+r3Hijtt/KYOaVPKwYwJmj55d339amqT9+tJivj3SLBCiqAeL9L4
	 veZI4Zi3JeqHIvCt8qy/BjntnoGT1Ws/kaqnrFIT7eLCQStx5Zy4652+nrtmZgAclN
	 mp0l8fFByLeE9THij3Fy6MKVVBhpy9zw/zBwydbsRYhk5j81npvVPXf+eoX5fOzabK
	 zoiBs2lmfa56R75+N+6QSXA82NoB9ivdnFX+kk/Ci8O6Q4W7v2kFQLGGuria4qubl+
	 kdW3jPGjosOLBAdBjNouAOsf5+wbKAgMzCES/sCo27x3qMxKoqv7b7AaEwGLxitvqr
	 u2ezEYSm1FiFg==
Message-ID: <sashiko-outbox-208119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] uprobes: Use flexible array for xol_area bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111022605.66010-1-rosenp@gmail.com>
References: <20261111022605.66010-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:48:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The XOL slot bitmap has the same lifetime as struct xol_area, but it
> is currently allocated separately.  That adds another allocation
> failure path and a matching cleanup branch without buying any extra
> flexibility.
>=20
> Store the bitmap as a flexible array member and allocate it together
> with the xol_area using kzalloc_flex().  The bitmap remains
> zero-initialized, while the allocation and error handling become
> simpler.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111022605.6601=
0-1-rosenp@gmail.com?part=3D1

