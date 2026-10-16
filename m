Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE422628D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110279; cv=none; b=C5jZJjF5MBpqZCvSta7eZ//e+0mIyAu3JzdvEmtwACjTs0bPTVbn9EMY5YfpFyR9bApVNLm75u6g5qNsRBUDsFRJdIpvcJ1zrz4hraYQ+Hk/vcAnTelZLO49kiUPjZ1mLSYZDFXsB97DaMLBCHx5aaEWLwHitdzVJ3lqi9phhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110279; c=relaxed/simple;
	bh=x7KXY4AL7+NmxgT2codlWwGDtYqrMp0kglXErgIx4KA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CnPuuR+mKiW0UaQyHPupyYfmcg5T+Xk0u0VmRzFgVHYn0bLjgSkt8v/2lPoHeqVe0tJUyATlH9n8mZoR7iuICtU9WECia+BjW9pm0f3P/dAxTsYxjvsK3Pu6EeobeKiLYYly7xv5qX5CCziBxlEBzLgMCOgWIUIxVzrvwSeNoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG9kLbtB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG9kLbtB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A031F000C4;
	Fri, 16 Oct 2026 00:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110278;
	bh=9H2BPMaB27wVCASwgrvd5WZfmeuUm8iqTMMYtZfXI9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nG9kLbtBv/7WGx63F6IS5qeTtgcO4xG7PehDmK55j2CA4nrnB3lcFyfXpmWdlnpjF
	 VMuWb86kGf6/2pILteT4f6z+PgJ33G2BaFFQ7wp4hIG0P3pE2/8xBhXhUWFy79QQ7l
	 cUe4I9a+P7pZBEFxKX5T144JRLisLCf64iY1CPy/RQIfKcD+kcDO/yEoRCXmF9P00Z
	 iuvHwXfqx72YA7XMaiYHX8tp2xNJltvMY6FuyfUfMiMaIKHmwJSFFFGBm0Tqrj1rzL
	 lcUIepJ6mTzd5WZl8oPhbHG0z8DtJwVFvCspCB7l2iN40Ski/3f6cYf2UKYJ+4VYm/
	 mLTvNDl0iDD4Q==
Message-ID: <sashiko-outbox-173520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/19] perf test attr: Ignore the core PMU type perf
 puts in 'config'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-8-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:24:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since commit 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and
> PERF_TYPE_HW_CACHE") in v5.13, and arm_pmu opted in with commit
> 5c816728651a ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
> in v6.6, the kernel can be told which core PMU a legacy type event is
> meant for, with its type in the top 32 bits of 'config', see
> perf_pmus__supports_extended_type(), which __parse_events_add_numeric()
> does for HARDWARE and HW_CACHE events, but only when there is more than
> one core PMU, i.e. on heterogeneous machines, where asking for one event
> ends up being one event per core PMU:
>=20
>   $ perf stat -e cycles -a -- sleep 1
>      20,520,998      armv8_cortex_a53/cycles/
>      13,029,350      armv8_cortex_a73/cycles/
> [ ... ]
> keeping what these expectations mean on machines with a single core PMU:
> which of the PMUs is counting is not what we're asking here.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D7

