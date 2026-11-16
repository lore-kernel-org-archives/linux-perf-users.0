Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812735;
	b=AV7s+NdC6zd21PoCIH5NlXqW7C91uG1gOeSY1Po2kQETRb3nAnuZPTanE8P/50+BRhJ2
	 Fo27orpx/XeAiJuF83EU8IKnD05HOtvcnZYAe/6Qd9gdPikUDzo+eAsw9nAiM/O7vZ42M
	 VQLwxt6OgKrek5C0mUIaiOOOBc/qqCbdGqfbRbq6GgnzLhHVgFW5F7aWzHSNOwhAQMqF4
	 WNP1nb0PR1heyqGVIx0EUHXjQGbx3qmSRrPzZEld3nV/TebGtPuUbkf75xxr9AopYdbvx
	 ir520yOk/ox22f5V1oelG7PJaxNHUbuhIy3aYrWDnAZABkRY3strYWAm50JCK/zru1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cfOJ5ftYVOe28vicsP9WYCetdb3XkZ4XylG8woXzN7M=;
	b=tSJpTP2ckSN/yvSEtM2/NtYYT8SY+qKoIlEgNaMG+ZncScExI12Kigkh3J3xQdjWBQ3B
	 zcJUDUY3WgmpNMgiWw3AaEoLcbYMhGMTgt/BR8Wo8SFwUzFtEa7AeSEROfawWpwP5Ea6m
	 GtNqYT3LGAvJ9XJ8L2uciOT5INLeyGHsQOTxxP+XTeHr2d3KymQ84OjPUE8VtHpY4J6xb
	 NvM4ySsYoGd6ws+95SnqeS6sNuPKc5xA6gnF9MRLAIRFtS7PAn1u1Bc70KkUxQQdgMM+Q
	 xh/4ZVWPGfAXZuAkOutEx/85yc7ziyCzRMId8ejZ+h64AnNouaQ0qR2BS87UcvllyIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVtbmFmv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB013606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVtbmFmv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF121F000C4;
	Mon, 16 Nov 2026 07:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812735;
	bh=cfOJ5ftYVOe28vicsP9WYCetdb3XkZ4XylG8woXzN7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVtbmFmv/9QUlFEVXyRVqQGIefPkoT0nHjXaDpFsuSSoFLKkRKDOPIO1w4qQW1j19
	 KqewP0HQSS52wcQMC1SAoUOI7RAEQMWYbtGxAvG6S/KLI32Dt97lwS8SdtcCuPWEIf
	 XSUJomSskxqlWJXDU3VWnWcW9JAjTU+D7LeGK7dmFOMKdqK/6ECNCePLF9rdsoNBDt
	 fbRH5KxwDTkBLpHq4Mo2U3No+MHTaJKc4s7LX/fKcu4739C6VFa0UURLWFcMD/scSn
	 6pS+5od440hNPxegTI3oLYztmr8Xhhe8zcWAopIGaIh3EAYaWi3IDrK8q3liA9uaAO
	 j+gZ/iPbq3oQw==
Message-ID: <sashiko-outbox-216377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] perf jevents: Sort BigCString entries
 alphabetically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-3-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:05:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently BigCString partitions non-metric event strings before metric
> and metricgroup strings, and orders deduplicated entries within each
> partition by first-seen insertion order (insert_point). Because strings
> shared across multiple CPU models stay at their earliest insertion
> position while model-unique strings are appended later, later models are
> already fragmented across big_c_string, and identically prefixed event
> and metric definitions from different models are scattered far apart.
>=20
> Drop insert_number/insert_point so non-folded BigCString entries are
> still partitioned with event strings before metric strings, and sorted
> lexicographically by their raw UTF-8 byte sequence (which starts with
> the NUL-terminated event or metric name) within each partition. Grouping
> identically prefixed event names, event encodings, descriptions, and
> metric expressions adjacent to one another prepares big_c_string for
> block-indexed string compression (splitting big_c_string into
> independently compressed ~8 KiB blocks decompressed on demand by block
> index and intra-block byte offset), shrinking the compressed blocks by
> ~20-23%.
>=20
> Regenerate empty-pmu-events.c for the updated string offsets.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D2

