Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604387;
	b=E1x8Duhw/RHB0QawC6BEs48AZhvqnIuF0g9P94WnsUVJn3HSvSQ5bZPp0841c/V6B4U4
	 Z+SoHEohmKRhWpEOrKIVfnB+uecj4Vyb508xgHfg8lAyVSX6gqb1eD7lilSBbjNVJI0RZ
	 i6b+j+8nyDwLoApZXOHH+0n8O7nYztwan/+cCNWGDP2bSCtcraD/36n5UjWrCfZCE7meB
	 jiwbuR11hQZCXWliWsY1vsuy4U8MoQM3heq9hf8lV7E2fueJDm9JmUhZQNxKz93T8zHhc
	 zjyWRLcPFQ0t2RUQQ1D/V1e+I9kDTWQm8qHo7Y8P/KJgrKZlt/p1sEyb814uECODLDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604387;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1PpGmkYXQ8AuQVTEo8LgZ7p6KMxBy0LAy5TKfrZ8Zks=;
	b=o1m6T7PrBI/wfIpen61VEOlz/73K2KSSF7ElJWGpLZXCv59DR9JtUdQs8YMo0NsFbyTS
	 m1BPJYvIYYOnF/ra2UZ692yzh/bGMspJNsMSiN+Wx0r7lrdaOpCeEflNlU7uma+8KVpbl
	 f7xTkTcV9buUNeOVlfF4yG6euulhF5yD15yKVA3n7GeVuMVvukhYW0NT9mpATZjsTMFLs
	 AdrNTrhu1qqQLv5YaSbybqULLLgJ9yAtUfCabIWIfAZSN7ADF7ZPMpZ79QQRRtjBtyRpj
	 hny4bEzmH4Sj9dDhdRpUUtWOlRTdkBuzqPo087NHWJdZ8H1We+PAo6CtQHgr06Ilmew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXevilRz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CF606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dXevilRz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85C71F000C6;
	Fri, 13 Nov 2026 21:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604387;
	bh=1PpGmkYXQ8AuQVTEo8LgZ7p6KMxBy0LAy5TKfrZ8Zks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dXevilRzl+cyqnGWrevdv+ZfaEzynY4OkJi1UsUivrfFCt/OFa92rKRO1VgLe3C38
	 VPG7h8+Qh3HgW+Wv5KTzLkw8xVkOLB0g2u4FKCEWhLxnBX723PASAd63Omcng9gN/J
	 VIlwIcvsHK9Vciql07frOz3TDLk+8UKalXfxoaq5SkChoBtG4QTrM43ivIp6cahdAr
	 6R9uxmyX3mBmnu3jLxUsI8UITyPf0ovBn5rLGH4oRhRC0xfIe+6n/L8djFpWor1IVV
	 nCJ+1GTw1zXjYZU7uSErckFuG0UQbM/PC45ZfDpPDV7lxnsQtpsZKEarqHzAdttM/P
	 4ndGOxu3ANB/Q==
Message-ID: <sashiko-outbox-213696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] perf jevents: Store PMU names as string literals
 in struct pmu_table_entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-4-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:13:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Every PMU table lookup (perf_pmu__find_events_table(), map_for_pmu(),
> pmu_events_table__for_each_event(), pmu_events_table__find_event(),
> pmu_events_table__num_events(), pmu_metrics_table__find_metric()) scans
> table_pmu->pmu_name across PMU table entries to check wildcard matches.
>=20
> Across all architectures, there are only 68 unique PMU name strings
> (536 bytes total) across ~443 pmu_table_entry rows (which already reside
> in .data.rel.ro due to their entries pointer). Replace
> struct compact_pmu_event pmu_name in struct pmu_table_entry with a plain
> const char *pmu_name string literal so the compiler and linker merge the
> PMU name strings in .rodata.str1.1 while hot PMU wildcard scans never
> touch big_c_string or trigger block decompression.
>=20
> Regenerate empty-pmu-events.c accordingly.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D3

