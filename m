Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388858;
	b=jf5cxD72ySlQLMSPrf87S5Np67GGIxisZi9gkdLmCwo04Cb1eA4PLEkeUNyftOGjUb1R
	 pct4OTQk70Q0TUfkGXvvkvqbQZt5WGYXtk5bkEqZ8aoZj72zmgxQnzghq3mUdvM9Fbsj2
	 huOZQrbox/qvxNlt7XN3eTakrtqQhVYmaDXk+tT2Dw0O3bS+qXf6WkMvp2otsd94vzTo8
	 tvQ5BIaUy4kumZuf4ktZcQqvAxQ3sqH0yUnAVr4OXiI31I8/5gx7zCHbnUu0LGrxMH28g
	 y1L5V00eR60wPRW7ZyW2oFZDpl+cXEOjaZoNU8cjYwet8OhwtDtzBGbij/TEGJjKKaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ThshnkOD6JBgPAG+EJgkf8kfkLeBHIQd+sbx9sV5l20=;
	b=YcBg1Fqs8YL/vmcPoy4uzny88voOeqzB9ZwJM1DhxGFyQJHkhC09s9WWSGA51Vjoa4Mo
	 aAl1i7sYusPC6+7SXXMxQG9+KsnWgddB/4Ulf8TEA/7tE9K2AGfoQ1kLM/llArNi6MLz+
	 vg+Q7T6OxZYsG4YT5x2izyyI8QyJqBDKqPBH1N2xxSySQCiNanICwwOwSiv+aBrKmXWt9
	 GJDX1AjI5LdxyBf31QpXZKYRwYnW4/nGg2S7cwqSAPVVS0XRLfMs93hEWs2vTQRl3Y+Xn
	 bZJ0Nac/wwGFY6Higqp6tSxHXN6FtkXZnVMyJexJdeVvBAHWVD5J3IO7PZzLPeYce/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOzThGOP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE257606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOzThGOP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F511F0093A;
	Fri, 30 Oct 2026 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793388857;
	bh=ThshnkOD6JBgPAG+EJgkf8kfkLeBHIQd+sbx9sV5l20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOzThGOP/a7ZOniScaDXzPxqmSojIkHNpgHc9GlifBKSAns2xjIOkcrI+FDNO1f78
	 xTE7g4ALu3ike1zLMubs7SycjMyrn36hBNNQ7esQ3PAT1Osqeo4ZSMcollnm9AMSF5
	 JZp+9brNqZVvacRFvGV6t0lJbA1xThnj/kxI/YmkWLN59flDq4nFYANE3pJ++KxJnE
	 GgulKoMX2hUfmJ13HV5gmv5j6+IuE6VYCGoHk56tYE/DUdGeJzC2OYKJcGEKcG2Iau
	 xsh/Zd+oUxHfRvuSxABS5oqP8IQVYl8ah0YLgMnjl6ODk9r+1HOv5a9PuBrGROWhQa
	 RZR3U9I/xHHvw==
Message-ID: <sashiko-outbox-191446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030192537.3079368-1-ctshao@google.com>
References: <20261030192537.3079368-1-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 19:34:16 +0000
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
> 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->pmu
>    is a non-core or hybrid PMU in AGGR_NONE mode (-A). Tool events are
>    not labeled as they don't belong to a hardware PMU instance.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030192537.3079=
368-1-ctshao@google.com?part=3D1

