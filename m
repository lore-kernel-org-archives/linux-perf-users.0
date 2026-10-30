Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383133;
	b=UKFRPkMLp+Xw8FAE0aQMU5HIkaufLHh5i6cazrb4PMSVPIrlgtk/xpK1Edy21EdVCrzc
	 eE4efKkmYUIVM/dYGCcjp36sBldDn/kvrLwFBu7nXY5ZZOLIfEi/XXz+Q7J1lOEjHJHJ4
	 EzzXTR1m0loXtUrDPMihvMb/pOoDHyEfKtb1SH1t/64If1MV1Pm5B2s8iEK0jc6RPl2Zg
	 J8f649oh24gkJr/6POBi+ADFWhlPeAapLwL+lq/aG0mBJ5IrxYNHtdR+l1e1aiBAYRtYV
	 gw+mS4TSpRmjqNzv3K+Bq2JinYmhosjHt/TZIvX+9NCa85goI1RV0OQxbcXn5u76P3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eiK6Ne9NyLckZq3h7MPJul9sow7+oqH6edRBQZqc5pU=;
	b=UfCotH3GyXi72hfjrcx9QKKmh8ABrVOBC60AcBcJSZAEm6QIQ58bZ/l6CbPPkZFwJbsg
	 nqX/w7QXoTwnJtGSISGEyXmK3s891AaryK48mbPKSRksUP6NMJ7GvwVnDetgYdT0YEkUZ
	 a125umQ/knzZySzbU/iTxfA131Ii3u9PL3bFjKwNEI/SNDfw05CoUU8uxGQwu9cbPaWJG
	 Tkn8cjBtLGhJ0yJEZ38SYKtggWb99Dt3Tu6285+jLoJqk7ti4gudGjI8BZDTJsfpIc0UL
	 hsYTJ9upa6XmlSxU9OnAJi86gl0HqOOuWSb1yn08oQGUGKb9TKRcLWA5VG1xZMcLoSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ll06EoeT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331F606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ll06EoeT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53AE1F00A02;
	Fri, 30 Oct 2026 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383132;
	bh=eiK6Ne9NyLckZq3h7MPJul9sow7+oqH6edRBQZqc5pU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ll06EoeTIzlStP3318eYK0ZQNsi78QOvzVFWCTrzEkR1tAdoAt+cdo6h4q+iHqp4d
	 8GmjeVNLwwAzwQ+gPBjNvFfJdFgV7SNri5CWMCeZ1qjUtmvHucb4yaWAQGsD0RpnXf
	 srXsf4xDTRyoE+S6fwsyr8YF/dqG6VeE3EcCUMKa4m5bZxHXnLcjL7AEcLtmy6l2zn
	 u9TvaW9wEKWlrMo8hr36v5z6L4u9LZ9Yz8GuhIZl/ndjFqnAjU3wo17IuYrYmNGFH7
	 Ok/Ex8d3l/VBfY6L4N8mf4Rwc4ldxP4F+2twd7nR2IjGVSuENhBosb8mSlp1I83QXy
	 /NrWNYW6oKAMg==
Message-ID: <sashiko-outbox-191384@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] perf pmu: Merge PMU instances that match the
 same comma-separated json Unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-8-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-8-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:58:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Since commit 730670b1d108 ("perf pmu: Support more complex PMU event
> aliasing") a json event "Unit" with comma-separated parts matches PMU
> names with an optional number after each part. For example, the NVIDIA
> Tegra410 PCIe PMUs are named nvidia_pcie_pmu_<socket>_rc_<rc>, and the
> Unit "nvidia_pcie_pmu_,rc_" of their json events matches all of them.
> perf uses this match to attach json events and metrics to these PMUs.
> But perf uses a different match to decide which PMUs to combine in the
> counting result, and it only ignores the number at the end of the name.
> So the RCs of the same socket are combined, but the two sockets are not:
> nvidia_pcie_pmu_0_rc_<rc> and nvidia_pcie_pmu_1_rc_<rc> give two
> results.
>=20
> On a dual-socket system, this gives one line per socket under the same
> name in the default output, and with --metric-only a metric column per
> socket, a "none" value for the other socket and a duplicate metric key:
> [ ... ]
>   $ perf stat -a --per-socket -j --metric-only -M pcie_avg_wr_bandwidth_t=
o_all_dst -- sleep 1
>   {"socket" : "S268435456", "counters" : 6, "MB/s  pcie_avg_wr_bandwidth_=
to_all_dst" : "0.0"}
>   {"socket" : "S285212672", "counters" : 6, "MB/s  pcie_avg_wr_bandwidth_=
to_all_dst" : "0.0"}
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D7

