Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873318;
	b=WQk0z4pzCZvGWGFlwyLNc9yZuZpx9PJXLyY2twe55J6Az75ahkcGPgmK5lNiCVBTNNdN
	 HLgpC7svviLluWzzcPHT1FG8a0ow+KGLXDehhMctgHwIDO+lmY/6Cdhd5udAgudFWAum5
	 cVJSJlc34up7DJ98/I561fyzN5f+dAtOjE5sR7hVd4JHZJpKdm6V2f5LKZb54t9CNoF+3
	 8Jsn7xn/8rEaKpNaLamfMkqiR9VI+HieYZnWJgSD+VS2OF6EXe4lA3ew0RdAOHSyuY61j
	 4LngYoJist2weRdZFVvCC1f07QutShkUTFF8eXDl41PQkH8YJKpnz5C/TnlhejkVqUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QOg3JI/FsTEnFElzmMTiK7csuWJlwGpvV7zeQaEK320=;
	b=bdvxX5A90LTSg/flacljlaOfYBEHAS33+EreSIA1VvhNU4lt2vOaT8vvJ+TEyVHM10Ew
	 sHHpa0yVO40L4/GC2cYxp+3WgH7ZLtUeD/Gq+dcBpmZlNmHQaxDgkmolbjV9rh/YoqYaZ
	 HZGEWpfUCN8dpNavRFCJafKUlH/Z6D5am2lQ6R+c6LKHDthfPki+ZTdy5v5vrbKJWZUX0
	 3b50EsQo97ZSXiPv/ThcuNo9mLuUtWX0xjZoQnC5yrUBsAtPlk12nfn3l/XNjzG2ebhzQ
	 /soc6asSphzvLskyEF+OXQ8zGI5HD0Dokz986nuo0NyjVyTAJv3j/qy/qUSnJiESZqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbicOM+d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A4606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbicOM+d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E499F1F000C4;
	Mon, 16 Nov 2026 23:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873318;
	bh=QOg3JI/FsTEnFElzmMTiK7csuWJlwGpvV7zeQaEK320=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbicOM+d9TbQp6/vcAxED31LoubTCKvHM60fWlu5+CVU3jwixiq6gflwsTOtJIQH3
	 GttVMV7HA3ED/Gi24hfgPXJSwQQvQNaXZFYL+BsbvsGhzTu9tSKHpps5Dio+MMNez6
	 q1Uj86MCiZh84JYHdqepkQWAQChhDuEihrS4cZCdDaRmYDeW0ef0ZaLlYeZd+qzxGJ
	 lYHa1mvhhPl99fO2Om4gLaXxJ1x0p0KZVzbY6wMDdrjm1f1Jj6YdnUKMs45WSCGqA7
	 2qtu+Kdv5JdTSZObmBtdUZCHuf9na1l5zqTMxGpdBtG6m1KIJWw/ID9jmkIoiG3STA
	 0KxoTJqBoJRHw==
Message-ID: <sashiko-outbox-217939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/12] perf tests: Exercise data type resolution from
 a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-7-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:55:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> At -O2 a struct pointer lives in a register and DWARF describes it with
> a register location, while the unoptimized workloads the data type tests
> profile keep their variables on the stack.
>=20
> Add a regptr workload with a noinline function that gets the pointer from
> a volatile global, which keeps it in a register, and check that its three
> member accesses are resolved from that location.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D6

