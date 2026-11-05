Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854431;
	b=PMNgfQOajoHH321x1ssSPifJUVwavvVRLZEekOHSraHSa8YQXfxTg9ZEpPzn7pds+zCf
	 sBGJimOTgZqdSW2bXHTv6UG2zqwf83nqJv75GAoWsBMwU/SyCjMpLLZnEWcehj2J6lCR2
	 uyY1ZT78WyRX+aAoFvQusGQaGyaVehJqWX4kxvDN0WG/H+aoGrF9ZqGojnwwHfempvHnP
	 QaQfxf8JckAIEsMpHNmP79VfkRcNH/Hu14mzW2YsUnO6LXEznng299Q5wifv476vGbpE4
	 VN0uW7UdqObuFCHhExEWDfnQILp43l6oaDqfw3QIIqWs/Gu/6vjvGzc1g2zuc+DcD4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N3M5N6E0wXoyyWK5o1LhXyM1qK2CjTbSFnL6N5rbBoo=;
	b=j3OAVZ3EX6ysEfXEoFVTmb71JR/a8P/TFTg5pbKS/pwOc2rT1mBeDiclHBceV0M/ACsq
	 vtlCgQ5SQ4OZDZL2o/KGvrmFoWhBW3aC2NZZ4Ep4cPv7Q7yHXAApl2fTN8YIX5RYF/Sdi
	 OJ9wkKfshBrwmDIPQbSZx0Zw8b6E3ZcjOQgCBOmQbU8Kwl9waQBVn0DbE0meD34vui7eY
	 aFakgGnbhnHxnOsHBtkvLQ0qYfPJIS6lTbk4MKGtNUjIuBbLOZ6+bLpu7MpxNkNLHDcS6
	 09MG8axMOKBs8+WvOnBep4JeAYnz0sXzNqoZyqwRzhj5WjZ/UUtdYb+gbNWpH8E14fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gn/rd2I3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F14606A33C
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gn/rd2I3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9701F00A15;
	Thu,  5 Nov 2026 04:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854430;
	bh=N3M5N6E0wXoyyWK5o1LhXyM1qK2CjTbSFnL6N5rbBoo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Gn/rd2I3/psMFnq4V7Kypu/W/ogyN3PEMYky6KYmTSdQbeL5gEf0YJmXq2RSPHwrm
	 r/cMHTUV7twmfrOqAv9yCSFrX9iQtDJxyApUFzDWQGREohviUHazQrH0UId0w5Qj6f
	 gd0DBKCxRHl8yOeJ141nmWNNaa09P9hGNddVz1VoozwHeHrH6mJSZBlCvhjDsiwIKV
	 jiZLiAV304AW9snuJ1jrQEwLs/22MwnW/S86c40s72WW/1YgJageyD5qVN/j/JYcIi
	 PlMfqAMrNBDkwR96/jfVEnnH01ffm/mGOh4dA1UF5W4QKu3WoVsh0j8FbRwslTxuAd
	 sUx+ifIczwyFQ==
Message-ID: <sashiko-outbox-198569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf jevents: Don't encode MSRs with no value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261105044841.102295-1-irogers@google.com>
References: <20261105044841.102295-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 04:53:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Fixes the events mem_trans_retired.load_latency (EMR) and
> mem_inst_retired.latency_above_threshold_0 (NHM, WSM) that were having
> their ldlat=3D value encoded as python's None.
>=20
> Fixes: ffc606ada3d7 ("perf jevents: Add python converter script")
> Reported-by: kernel test robot <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202611050801.67bb4af4-lkp@intel.com
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105044841.1022=
95-1-irogers@google.com?part=3D1

