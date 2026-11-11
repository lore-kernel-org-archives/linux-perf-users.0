Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423946;
	b=duUyt/6kbGHjLXXjo7oa6YcbKUavxjcS2HKu0dI8X49o+HqVZnrp5C+dOSBywkGP02HD
	 dfkbGIFODeg7gOJWq2GCSfEO4mrvheKi6wSPUr4osf+nmZ3bHDSbcxzgmn5kjRTx8wkrh
	 blUOtApoUV7ppuJAAq0MMqrFfnmmc/JpBP9csRczNKhMvd732lL61O5j911KTQxaQWj4L
	 mVHByMOGUEISZyY5bSUx+smackjHBW6MJNqR/HQugVk9eyooPvsHWnnCfy4R1+FLvfisX
	 UFtcVgYpCJ47PcT6GSeo2Wh0y9rEtD3OcSBPFhnUXYQAVowG4I0tHNGJItQ6StONxFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423946;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EqO+YMWzym/ukEW5qAG0PlRlMiS2P/d+pu8LjXSVuOw=;
	b=lr7iEvYUosm6hrK1x8yv6BgTGX2Z34vwxS011zaaIvFgSkNwyRAiQvzRj/jCYggifPl5
	 bk9sfJY/7M95k/K6QCWsPJbz9NSKlhJTfAns7JQFAnU7/IxmSML0FKnFvMG7Ppy+Mi2SF
	 I1S1odO7gecSoGiRG3LLtTz9GZ36TZtn0jBb3kHo5RI8awxwnmIeZbhA7pwxkM+k35Kcd
	 BQcqqupfY3LqEW74A9u37sApsggllJc2ttKSSYBTSLwnNQCHZx+UU6UEZ3gnE8L97BV6v
	 G/OC6npg7mhKN7WphXORMif+IedMnxt8ygUT0yoc3dwb2YB9ruX2bkQXVTw2yfHklDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jdm6a8t1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEDF606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jdm6a8t1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575771F00A05;
	Wed, 11 Nov 2026 19:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423946;
	bh=EqO+YMWzym/ukEW5qAG0PlRlMiS2P/d+pu8LjXSVuOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jdm6a8t1FaLi9oUd/Uy0aRQLt4KRfQ4MJfAlSdkbETkdGHnIXdR/qI/soTeWJOmTv
	 /kgwYd+cteSXqsrH39ttMLFmdLN4acvWCMtG302OurVFL7Q6LqMEuV6Ausi4pHUNl8
	 KfxTgbRuNmNXf3zKBnaIL2MduqHyZJOVy4CcguKYslRA3diSCTRfmOjx8W8ziJ3VVv
	 wsx5W8Um5UWLjH8aAA3ilO8Ir1eEcadNqLCYuIx202Q/G/G3/6C4sOG3AnIG4cGFlZ
	 S400zG8mxSGNES9k2wi2V1UrTs0378HNzVwmM8MgkrMRjlv+7YGxOJ/s3V1EL4n1X+
	 DkfWcwAamLR0g==
Message-ID: <sashiko-outbox-209529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111183209.1892421-1-ctshao@google.com>
References: <20261111183209.1892421-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:05:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> JSON output mode (`-j`), `perf stat` evaluates metric expressions
> across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> `uncore_iio_1`, etc.).
>=20
> However, `perf stat` previously formatted JSON output by printing only
> "cpu" : "<id>" and grouping all metric values on a single line per CPU
> without identifying which PMU instance evaluated each metric. As a
> result, when an uncore event spans multiple PMU boxes, `perf stat`
> printed repeated, ambiguous metric keys without PMU names.
>=20
> Fix this by:
> 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json in metric-only
>    AGGR_NONE mode (-A) when evsel->pmu is a non-core hardware or hybrid
>    PMU. Software and tool events don't belong to a hardware PMU instance
> [ ... ]
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s =
 iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s=
  iio_bandwidth_read" : "0.0"}
>=20
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111183209.1892=
421-1-ctshao@google.com?part=3D1

