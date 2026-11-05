Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866437;
	b=tv2GQ6ZbF20LUsLE5MjPxu7UNL4x8Z2V5DV8dTL44PNCrFJclubckRiEkm0ZVvtq3oqf
	 jrafK9hY2c9lFiL0sx/n7QkmaDgDYl+J0jm9hS3huJeuCwDwRLCdU8OX5hC7OymlB/6T9
	 hHqdufL6N5ZLqN6gvk0tYCYoE3qlMAqxkkY1zge0yQclZrwvBiTwC1FHGs8k+2XpSQtH5
	 GGOQHObmnZ5jb29AwjdZHorB52IU3tG6u3X94aFeZVBnYh3LGOltVZTWQHMIFvO0jrup8
	 F1oytina8/Pt5ncJd/NE/Fqw/XClvQGh+DAwIIeEu92stT9cObW2EsWPodn3oLqox6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866437;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tJhAuAnTRMVGfJJl2R81J2DAvxJs8LpBhvUL1VO+n+A=;
	b=abXzKEDKVQwyaVKo0g1golnvCETYmu0aDCfRhZ78KMp1Vrnxih0b3GuAIj6r9IjF/8EH
	 Pn4fagsh5NzvFMSZDTRZjCVn+DLgEVlM3kF+uTJA57ojXts9ow0p4K2U3Fu/JlOBU3e7z
	 6FzlojpoyJwFemtRkMZyflR+T5WMCd8a3GNUCRJX0ydUEih1Y82bUD6YNjFNbuYFDandh
	 afkrjOxfSAxOJVQb+s/XIyz1Na8rBNjgZNq+0Wg4pgcadFrDiQV9VUfSX6cK/Qc8B4qfe
	 R7mL3D+KMB3zEDMQCP31qJi5uGT3wDBJwQyiYf5PeO2bGy5S2WowzE+LPQLIToQ0QnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C36V30Mp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045B606A32F
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C36V30Mp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A081F00A02;
	Thu,  5 Nov 2026 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793866436;
	bh=tJhAuAnTRMVGfJJl2R81J2DAvxJs8LpBhvUL1VO+n+A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=C36V30MpjjdH1G9TLpIFABIwhz0eTFNPeEEzdXpPn1R8jePz99f1UmMPPfPU/8J3H
	 ySzpoAGokqz9hBODjGR02aPv3ZKjMg92dn/zeLXhjAeI05pV1YN1LLD0OTru0JQF3M
	 zwS3SyLi6OWSHdpWTGW/FsRe3Ti1RgMDN4hDOT6vzRk2zFiHum8P0oXzYerl7eeiM4
	 9dWEF4cnh9YRIxwrkOCmzZ1Qk1NGzbnW3uTO06DI90rhp29urrWZKOZ8y+5BHsqznD
	 9KG8ptPVk0OMMQ9zDz/sNo6LxW0dv1ZoMAWwRIiYyWyvjOKh3IBgkG1nyXAvDjbphz
	 XpDG5/+GArzyg==
Message-ID: <sashiko-outbox-198713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf iostat: Do not compute interval deltas a second
 time
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261105080429.2472-1-lirongqing@baidu.com>
References: <20261105080429.2472-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 08:13:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> process_counter_values() now computes deltas directly in evsel->counts
> for global aggregation too. It saves the current cumulative raw count in
> prev_raw_counts before iostat prints the interval.
>=20
> Subtracting prev_raw_counts again can therefore underflow the count.
> Worse, replacing the saved raw count with the interval delta corrupts
> the baseline used to calculate the next interval.
>=20
> Use the already computed delta and leave prev_raw_counts untouched.
>=20
> Fixes: f976bc6b6bfc ("perf stat: Aggregate events using evsel->stats->agg=
r")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105080429.2472=
-1-lirongqing@baidu.com?part=3D1

