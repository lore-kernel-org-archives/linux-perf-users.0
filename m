Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561978;
	b=DSojQET2pFey2n4PK7FDeZpzcxgomndG0r7BjXjcSztt6uzUX9Aim+/Ryibr1xt/MQQ0
	 QcbE7yZ6KFNjjxCYuKos9MU7qdm+3eN1hlVU4d4FjuUbO79RkcuG445gOLV4YrTFc4OcU
	 sffhH0a2Xz81TyrkG3y1Q8f5gxLyWbl5HgekvIfBJ4qJQDH9u8fCOXZoIWYu1ZwjKVXGm
	 pgPXjmBF9hH9K2JImmVuxKmAVTcVHDB426FAk4WTZi/DJHMoPg99W+CZtb9OfD8iMAo4/
	 BaBh4GTtbLa7Owwl8j6VSoi5bX8tCvswoUtsUW6uNAv03B8Kgtmy9vYnbHIKNETs57g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xYgSNaQN02yuR9YSRfqyjLlPdEU2rxctqq6lZejBfzY=;
	b=Vjrp/EpHV3X97b7/XgATNNd2xZegUHXW0fI/P7twMnc8RmDD4VDJsTwul2acmnWHflmi
	 8HJezu7Z2YJ0LXsga6sfWY5tuZX1zmh5gRAWTC8mNj7POyI5ArDoUuHdygUUsM18t08fS
	 tHiAlkbaZBD72gXnrgV0HRbsrlhrDkiXrbKIwA4ngDigOLeuVGU0xZJbXLLclai+Ipued
	 tNYn0Q+PtCdxBli0ImLVXPszceW8hmxLvanEgwFTxO1SzfTBcEPG3WKes6bT/g3KKZKY5
	 wXS3wKFQmVeVr3lENSxv3Zg4MTX0mkok0cUaBJ3paGVIOMBKQeMHwkDFM6lRn7bFL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqGOxpAJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ADC606A324
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqGOxpAJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA801F000C1;
	Sun,  1 Nov 2026 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561978;
	bh=xYgSNaQN02yuR9YSRfqyjLlPdEU2rxctqq6lZejBfzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VqGOxpAJ3Y6/XDiJZxg3kWdvQn6IoMzl0WUkE961B6Ypsv+pohXdi3kUvnYMfSiOj
	 qx0v0xvxgvHMXocaQvzz60xesEiXx5HjdfmarwR2ZvkvXmG+OPt3R2eHfltTyryeor
	 S7a2/hlk4nT3jynJdcdYxMyzpTFBmRMhcFaZ4S0VzDM0TGnWaaaymBP9qKPIcLU5vd
	 T2ZeIXu1wuaJTKN2PpVNbkrpp+kLbEUAd3dR7fjyiGDOiHnONJjR0YpWOzOM2LmUUg
	 Z9+fP86b69kSw0yPzKkWMi8/J/K9oeLX2uB4W13I6ZQSp7CNUVlqkILIF3Iu1ruLRQ
	 QXdXM12wnQKmA==
Message-ID: <sashiko-outbox-192626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] alpha/perf: clear PERF_HES_UPTODATE when an
 event starts counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261101-alpha-profileme-v3-3-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
 <20261101-alpha-profileme-v3-3-92d511b5a044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:39:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
> then programs and enables the counter, but nothing clears the flag until
> the first alpha_pmu_start(). In that window alpha_pmu_stop() with
> PERF_EF_UPDATE skips the count update, because the flag claims the count
> is current. Since the next reload rewrites the counter, everything
> counted since the event was added is lost.
>=20
> perf_adjust_freq_unthr_events() does this on the first tick
> after an event in frequency mode is scheduled in, which is the default
> for perf record, and it then sees no count to adjust the period with.
>=20
> Clear the flag where the event starts counting. alpha_pmu_add() cannot
> do it, since the event is not programmed until the PMU is enabled, and
> stopping it before then must not read the counter.
>=20
> Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-alpha-prof=
ileme-v3-0-92d511b5a044@gmail.com?part=3D3

